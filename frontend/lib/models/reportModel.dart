class ReportModel {
  String? title;
  String? location;
  String? priority;
  String? description;
  String? imageBefore;
  String? userId;
  String? categoryId;
  String? createdAt;

  ReportModel({
    this.title,
    this.location,
    this.priority,
    this.description,
    this.imageBefore,
    this.userId,
    this.categoryId,
    this.createdAt,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      title: json['title'],
      location: json['location'],
      priority: json['priority'],
      description: json['description'],
      imageBefore: json['imageBefore'],
      userId: json['userId']?.toString(),
      categoryId: json['categoryId']?.toString(),
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    if (title != null) data['title'] = title;
    if (location != null) data['location'] = location;
    if (priority != null) data['priority'] = priority;
    if (description != null) data['description'] = description;
    if (imageBefore != null) data['imageBefore'] = imageBefore;
    if (userId != null) data['userId'] = userId;
    if (categoryId != null) data['categoryId'] = categoryId;

    return data;
  }
}
