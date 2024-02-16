class ModelsModel {
  final String id;
  final String root;
  final int created;

  ModelsModel({
    required this.id,
    required this.root,
    required this.created,
  });

  factory ModelsModel.fromJson(Map<String, dynamic> json) {
    return ModelsModel(
      id: json['id'],
      root: json["root"],
      created: json['created'],
    );
  }

  static List<ModelsModel> modelsFromSnapshot(List modelSnapshot) {
    return modelSnapshot.map((item) => ModelsModel.fromJson(item)).toList();
  }
}
