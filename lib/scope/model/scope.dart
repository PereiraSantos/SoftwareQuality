class Scope {
  int? id;
  String? description;
  String? observation;
  String? expectedResult;
  String? acceptanceCriteriy;
  String? functionalityDescription;
  bool select;

  Scope({
    this.id,
    this.description,
    this.observation,
    this.expectedResult,
    this.acceptanceCriteriy,
    this.select = false,
    this.functionalityDescription,
  });
}
