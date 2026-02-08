class TaskModel {
  String id;
  String title;
  String description;
  String category;
  int date;
  bool isFavorite;
  String userId;


  TaskModel({
    this.id = "",
    required this.title,
    required this.description,
    required this.category,
    required this.date,
    this.isFavorite = false,
    required this.userId,
  });

  TaskModel.fromJson(Map<String, dynamic> json):this (
      title: json["title"],
      id: json["id"],
      isFavorite: json["isFavorite"],
      description: json["description"],
      category: json["category"],
      date: json["date"],
      userId: json["userId"],
  );

  Map<String,dynamic> toJson() {
    return {
      "title": title,
      "id": id,
      "isFavorite": isFavorite,
      "description": description,
      "category": category,
      "date": date,
      "userId": userId,
    };
  }
}

