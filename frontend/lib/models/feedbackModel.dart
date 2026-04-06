class Feedbackmodel {
  int? id;
  int? reportId;
  int? userId;
  int? rating;
  String? comment;
  String? createdAt;

  Feedbackmodel({
    this.id,
    this.reportId,
    this.userId,
    this.rating,
    this.comment,
    this.createdAt,
  });

  factory Feedbackmodel.fromJson(Map<String, dynamic> json) {
    return Feedbackmodel(
      id: json['id'],
      reportId: json['reportId'],
      userId: json['userId'],
      rating: json['rating'],
      comment: json['comment'],
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'reportId': reportId,
      'userId': userId,
      'rating': rating,
      'comment': comment,
      'createdAt': createdAt,
    };
  }
}
