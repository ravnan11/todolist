class TodoModel {
  String title;
  String description;
  bool check;

  TodoModel({
    this.title = "",
    this.description = "",
    this.check = false,
  });

  TodoModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        description = json['description'],
        check = json['check'];

  Map<String, dynamic> mapTodoModel(TodoModel todoModel) {
    return {
      'title': todoModel.title,
      'description': todoModel.description,
      'check': todoModel.check
    };
  }
}
