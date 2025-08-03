import 'package:software_quality/scenery/model/scenery.dart';

class Execution {
  int? id;
  String? description;
  String? observation;
  List<Scenery>? scenerys = [];

  Execution({this.id, this.description, this.observation, this.scenerys});
}
