import 'dart:math';

import '../models/cloud_model.dart';

class GeneratedId {
  
  static String generateId(List<Cloud> list) {
    int id1 = Random().nextInt(9999) * 92;
    int id2 = Random().nextInt(9999) * 92;
    int id3 = Random().nextInt(9999) * 92;
    int id4 = Random().nextInt(9999) * 92;
    String idComplete = '$id1-$id2-$id3-$id4';
    var index = list.indexWhere((element) => element.id == idComplete);
    if (index >= 0) {
      return generateId(list);
    } else {
      return idComplete;
    }
  }
}
