import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wepick/common/provider/secure_storage.dart';
import 'package:wepick/user/repository/partner_repository.dart';

import '../model/partner_model.dart';

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
    final respResult = resp.result;
    if (resp.resultCode != "401") {
      if (respData == null) {
        print(respResult);
        print(resp.resultCode);
        print('[partnerProvider] >> getPartner :: 파트너 없음');
        state = PartnerInfoEmptyModel();
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

  // Todo 내 코드 생성하기
  Future<void> getMyPartnerCode() async {
    print('[partnerProvider] >> getMyPartnerCode :: start');
    final resp = await partnerRepository.getMyPartnerCode();

    if (resp.isSuccess()) {}
  }
}
