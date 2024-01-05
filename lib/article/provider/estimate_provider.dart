import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wepick/article/model/estimate_model_base.dart';
import 'package:wepick/article/model/hall_estimate_model.dart';
import 'package:wepick/common/provider/secure_storage.dart';

import '../repository/estimate_repository.dart';

final estimateProvider =
    StateNotifierProvider<EstimateStateNotifier, EstimateModelBase?>((ref) {
  final estimateRepository = ref.watch(estimateRepositoryProvider);
  final storage = ref.watch(secureStorageProvider);

  return EstimateStateNotifier(
      estimateRepository: estimateRepository, storage: storage);
});

class EstimateStateNotifier extends StateNotifier<EstimateModelBase?> {
  final EstimateRepository estimateRepository;
  final FlutterSecureStorage storage;

  EstimateStateNotifier({
    required this.estimateRepository,
    required this.storage,
  }) : super(EstimateModelLoading());

  Future<String?> writeHallEstimate({
    required HallEstimateModel hallEstimateModel,
  }) async {
    final resp =
        await estimateRepository.writeHallEstimate(hallEstimateModel.toJson());

    if (resp.isSuccess()) {
      print('[estimateProvider] >> writeHallEstimate : success');
      return null;
    } else {
      return resp.resultMsg;
    }
  }
}
