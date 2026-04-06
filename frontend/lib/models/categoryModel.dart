class Categorymodel {
  int? id;
  String? name;

  Categorymodel({this.id, this.name});

  factory Categorymodel.fromJson(Map<String, dynamic> json) {
    return Categorymodel(id: json['id'], name: json['name']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    if (id != null) data['id'] = id;
    if (name != null) data['name'] = name;

    return data;
  }
}
