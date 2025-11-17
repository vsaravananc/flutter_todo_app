class TodoModel {
  final int id;
  final String title;
  final String description;
  final int categoryId;
  final bool isDone;
  final String createdAt;
  final String closedAt;
  final int sortOrder;

  const TodoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.categoryId,
    required this.isDone,
    required this.createdAt,
    required this.closedAt,
    required this.sortOrder,
  });

  factory TodoModel.fromJson({required Map<String,dynamic> json}){
    return TodoModel(
      id: json['id'],
      title: json['title'],
      description: json['description'] ?? '',
      categoryId: json['categoryId'] ?? 0,
      isDone: (json['isDone'] as int) == 1,
      createdAt: json['createdAt'],
      closedAt: json['closedAt'] ?? '',
      sortOrder: json['sortOrder'] ?? 0
    );
  }
}