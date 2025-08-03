import 'package:software_quality/scenery/model/pace.dart';

class Scenery {
  int? id;
  String? description;
  List<Pace> paces = [];
  String? expectedResult;
  String? acceptanceCriteria;
  bool select;

  Scenery({
    this.id,
    this.description,
    required this.paces,
    this.expectedResult,
    this.acceptanceCriteria,
    this.select = false,
  });
}
