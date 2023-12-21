// ignore_for_file: slash_for_doc_comments

import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wepick/common/model/api_result_model.dart';
import 'package:wepick/common/provider/secure_storage.dart';
import 'package:wepick/common/utils/datetimeUtil.dart';
import 'package:wepick/common/utils/result_util.dart';
import 'package:wepick/partner/model/partner_req_que_model.dart';
import 'package:wepick/partner/model/partner_search_model.dart';
import 'package:wepick/partner/model/partner_search_result_model.dart';
import 'package:wepick/partner/repository/partner_repository.dart';

import '../model/partner_model.dart';
import '../../user/model/user_model.dart';

final partnerProvider =
    StateNotifierProvider<PartnerStateNotifier, PartnerInfoModelBase?>((ref) {
  final partnerRepository = ref.watch(partnerRepositoryProvider);
  final storage = ref.watch(secureStorageProvider);

  return PartnerStateNotifier(
      partnerRepository: partnerRepository, storage: storage);
});

class PartnerStateNotifier extends StateNotifier<PartnerInfoModelBase?> {
  /**
   * 기능 목록
   *
   * 1. getPartner              파트너 정보 조회
   * 2. getMyPartnerCode        파트너 코드 생성
   * 3. searchPartnerWithCode   파트너 코드로 검색
   * 4. sendPartnerRequest      파트너 요청 보내기
   * 5. getMyPartnerRequestQue  파트너 요청 목록 조회
   * 6. refusePartnerRequest    파트너 요청 거절
   * 8. acceptPartnerRequest    파트너 요청 수락
   * 9. setMeetDt               파트너 만난일 설정
   */

  final PartnerRepository partnerRepository;
  final FlutterSecureStorage storage;
  late ApiResult? partnerRequestListResult;

  PartnerStateNotifier({
    required this.partnerRepository,
    required this.storage,
  }) : super(PartnerInfoEmptyModel()) {
    getPartner();
  }

  Future<void> getPartner() async {
    print('[partnerProvider] >> getPartner :: start');
    final resp = await partnerRepository.getPartner();
    final respData = resp.resultData;

    if (resp.resultCode != "401") {
      if (respData == null) {
        final listInfo = await getMyPartnerRequestQue();
        if (listInfo != null && listInfo.isNotEmpty) {
          // 파트너 요청 목록을 state에 저장
          state = PartnerInfoEmptyModel(
            requestInfoList: listInfo,
          );
        } else {
          state = PartnerInfoEmptyModel();
        }
      } else {
        final partnerInfoMap =
            Map<String, dynamic>.from(resp.resultData as Map);

        print(
            '[partnerProvider] >> getPartner >> partnerInfoMap :: ${partnerInfoMap.toString()}');
        final partnerModel = PartnerInfoModel.fromJson(partnerInfoMap);

        state = partnerModel;
      }
    } else {
      print(
          '[partnerProvider] >> getPartner >> resp.resultMsg :: ${resp.resultMsg}');
      state = PartnerInfoModelError(message: resp.resultMsg);
    }
  }

  // 내 코드 생성하기
  Future<String?> getMyPartnerCode() async {
    print('[partnerProvider] >> getMyPartnerCode :: start');
    final resp = await partnerRepository.getMyPartnerCode();

    if (resp.isSuccess()) {
      // 성공
      final resultData = resp.resultData as Map;
      final code = resultData['ptTempRegCd'];
      print('[partnerProvider] >> code :: ${code}');

      return code;
    } else {
      // 실패
      return null;
    }
  }

  // 코드로 파트너 검색하기
  Future<PartnerSearchInfoBase> searchPartnerWithCode({
    required String ptTempRegCd,
  }) async {
    final model = PartnerSearchModel(ptTempRegCd: ptTempRegCd);
    final partner = model.toJson();

    final result = await partnerRepository.searchPartnerCode(partner: partner);

    if (!result.isSuccess()) {
      print('[partnerProvider] >> searchPartnerWithCode : failed');
      return PartnerSearchResultError(message: '파트너를 찾지 못했습니다');
    } else {
      print('[partnerProvider] >> searchPartnerWithCode : success');
      final resultData = result.resultData as Map<String, dynamic>;
      print('[partnerProvider] >> resultData :  ${resultData}');

      final searchPartner = PartnerSearchInfoModel.fromJson(resultData);
      print('[partnerProvider] >> ${searchPartner.partnerInfo?.userNm}');
      return searchPartner;
    }
  }

  // 파트너에게 요청 보내기
  Future<ApiResult> sendPartnerRequest(String ptTempRegCd) async {
    print('[sendPartnerRequest] >> ptTempRegCd : ${ptTempRegCd}');
    final model = PartnerSearchModel(ptTempRegCd: ptTempRegCd).toJson();
    final resp = await partnerRepository.sendPartnerRequest(reqInfo: model);

    // print('[sendPartnerRequest] >> modelToJson : ${modelToJson.toString()}');
    //

    if (resp.isSuccess()) {
      print('[sendPartnerRequest] >> Success');
    } else {
      print('[sendPartnerRequest] >> Failed : ${resp.resultCode}');
      final divisionCode = resp.getDivisionCode();
      print('[sendPartnerRequest] >> DivisionCode  : ${divisionCode}');
    }
    return resp;
  }

  Future<List<PartnerSearchInfoModel>?> getMyPartnerRequestQue() async {
    print('[partnerProvider] >> selectMyPartnerRequestQue :: 파트너 요청 목록 조회 시작');
    final apiResult = await partnerRepository.selectPartnerRequestList();

    List<PartnerSearchInfoModel>? infoList;

    if (apiResult.isSuccess()) {
      print('[selectMyPartnerRequestQue] 파트너 요청 정보 조회 성공');
      final resultData = apiResult.resultData as List;
      infoList =
          PartnerSearchInfoModel.convertObjectListToModelList(resultData);
    } else {
      print('[selectMyPartnerRequestQue] 파트너 요청 정보 조회 실패');
    }
    print('[partnerProvider] >> selectMyPartnerRequestQue :: 파트너 요청 목록 조회 종료');

    return infoList;
  }

  Future<bool> refusePartnerRequest(PartnerReqQueModel ptRequestQue) async {
    print('[partnerProvider] >> refusePartnerRequest :: 시작');
    final apiResult = await partnerRepository.refusePartnerRequest(
        ptRequestQue: ptRequestQue.toJson());

    if (!apiResult.isSuccess()) {
      print('[partnerProvider] >> refusePartnerRequest :: 실패');
      return false;
    } else {
      print('[partnerProvider] >> refusePartnerRequest :: 성공');
      return true;
    }
  }

  Future<PartnerInfoModelBase> acceptPartnerRequest(
      PartnerReqQueModel ptRequestQue) async {
    print('[partnerProvider] >> acceptPartnerRequest :: 시작');

    final apiResult = await partnerRepository.acceptPartnerRequest(
      ptRequestQue: ptRequestQue.toJson(),
    );

    if (!apiResult.isSuccess()) {
      print('[partnerProvider] >> refusePartnerRequest :: 실패');
      return PartnerInfoModelError(message: '파트너 수락 실패');
    } else {
      final resultData = apiResult.resultData as Map<String, dynamic>;
      print('[partnerProvider] >> resultData :: ${resultData.toString()}');

      final partnerInfo = PartnerInfoModel.fromJson(resultData);

      state = partnerInfo;

      return partnerInfo;
    }
  }

  Future<void> setPartnerMeetDt(DateTime meetDt) async {
    print('[partnerProvider] >> setPartnerMeetDt :: 시작');
    final stringDt = DateTimeUtil.dateTimeToJson(meetDt);
    final result = await partnerRepository.setMeetDt(
      meetDt: stringDt,
    );
    if (result.isSuccess()) {
      print('[partnerProvider] >> setPartnerMeetDt :: 성공');
      Map<String, dynamic> mapData =
          ResultUtil.resultDataToMap(result.resultData);

      // 서버에서 전달 받은 시간을 local 시간대로 변경하여 state에 저장.
      // 전달받은 info를 그대로 state에 저장할 경우, 전달받은 날짜 -1의 값으로 들어옴
      final DateTime localMeeDt = DateTime.parse(mapData['meetDt']).toLocal();
      mapData['meetDt'] = localMeeDt.toString();

      state = PartnerInfoModel.fromJson(mapData);
    } else {
      print('[partnerProvider] >> setPartnerMeetDt :: 실패');
    }
  }
}
