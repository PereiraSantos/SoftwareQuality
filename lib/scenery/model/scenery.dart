class Scenery {
  int? id;
  String? description;
  String? expectedResult;
  String? acceptanceCriteria;
  bool select;

  Scenery({
    this.id,
    this.description,
    this.expectedResult,
    this.acceptanceCriteria,
    this.select = false,
  });
}
