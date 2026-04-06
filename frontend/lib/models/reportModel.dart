class ReportModel {
  int? id;
  String? title;
  String? description;
  String? location;
  String? priority;
  String? status;
  String? imageBefore;
  int? userId;
  int? categoryId;
  DateTime? createdAt;
  String? userFirstName;
  String? userLastName;
  String? imageAfter;

  ReportModel({
    this.id,
    this.title,
    this.description,
    this.location,
    this.priority,
    this.status,
    this.imageBefore,
    this.userId,
    this.categoryId,
    this.createdAt,
    this.userFirstName,
    this.userLastName,
    this.imageAfter,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    String? imageAfter;
    final updates = json['updates'] as List?;
    if (updates != null && updates.isNotEmpty) {
      imageAfter = updates.last['imageAfter'];
    }
    return ReportModel(
      imageAfter: imageAfter,
      id: json['id'],
      title: json['title'],
      description: json['description'],
      location: json['location'],
      priority: json['priority'],
      status: json['status'],
      imageBefore: json['imageBefore'],
      userId: json['userId'],
      categoryId: json['categoryId'],
      userFirstName: json['user']?['firstName'],
      userLastName: json['user']?['lastName'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
    );
  }
}
