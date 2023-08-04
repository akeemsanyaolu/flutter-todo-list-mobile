class TaskDataUiModel {
  int id;
  String title;
  String description;
  bool complete;

  TaskDataUiModel({
    required this.id,
    required this.title,
    required this.description,
    required this.complete,
  });

  factory TaskDataUiModel.fromJson(Map<String, dynamic> json) =>
      TaskDataUiModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        complete: json["complete"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "complete": complete,
      };
}
