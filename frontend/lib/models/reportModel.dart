import 'package:frontend/models/feedbackModel.dart';

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
  Feedbackmodel? feedback;

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
    this.feedback,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    String? imageAfter;

    final updates = json['updates'] as List?;
    if (updates != null && updates.isNotEmpty) {
      imageAfter = updates.last['imageAfter'];
    }

    final feedbackJson = json['feedback'];

    return ReportModel(
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
      imageAfter: imageAfter,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,

      feedback: feedbackJson != null
          ? Feedbackmodel.fromJson(feedbackJson)
          : null,
    );
  }
}
