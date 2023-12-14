import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wepick/common/model/api_result_model.dart';
import 'package:wepick/common/provider/secure_storage.dart';
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
        final listInfo = await selectMyPartnerRequestQue();
        if (listInfo != null && listInfo.isNotEmpty) {
          print('[partnerProvider] >> getPartner :: 파트너 요청 목록을 state 저장');
          state = PartnerInfoEmptyModel(
            requestInfoList: listInfo,
          );
        } else {
          state = PartnerInfoEmptyModel();
        }
      } else {
        final partnerInfoMap =
            Map<String, dynamic>.from(resp.resultData as Map);
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

  // Todo 파트너 요청 조회하기

  Future<List<PartnerSearchInfoModel>?> selectMyPartnerRequestQue() async {
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
}