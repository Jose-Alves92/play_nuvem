
import 'package:play_nuvem/src/shared/models/reproduction_items.dart';

import '../../models/cloud_model.dart';

abstract class IConnectionsClouds {
  Future<List<ReproductionItems>> getAllObjectos({required List<Cloud> listCloud, required String mediaType,required String object});

  Future<String> getUrl({required Cloud cloud, required String object, required String mediaType, int? expires,});
}