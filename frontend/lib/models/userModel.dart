class Usermodel {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? role;
  String? tel;
  String? profileImage;

  Usermodel({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.role,
    this.tel,
    this.profileImage,
  });

  factory Usermodel.fromJson(Map<String, dynamic> json) {
    return Usermodel(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      role: json['role'],
      tel: json['tel'],
      profileImage: json['profileImage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'firstName': firstName ?? null,
      'lastName': lastName ?? null,
      'tel': tel ?? null,
      'profileImage': profileImage,
    };
  }
}
