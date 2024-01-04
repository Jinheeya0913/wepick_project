import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wepick/article/model/estimate_model_base.dart';

import '../repository/estimate_repository.dart';

class EstimateStateNotifier extends StateNotifier<EstimateModelBase?> {
  final EstimateRepository estimateRepository;
  final FlutterSecureStorage secureStorage;

  EstimateStateNotifier({
    required this.estimateRepository,
    required this.secureStorage,
  }) : super(null);

//   EstimateStateNotifier({
//
// }) : super(EstimateModelLoading()){
//
// }
}
