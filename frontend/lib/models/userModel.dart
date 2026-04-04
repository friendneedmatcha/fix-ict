class Usermodel {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? role;
  String? tel;

  Usermodel({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.role,
    this.tel,
  });

  factory Usermodel.fromJson(Map<String, dynamic> json) {
    return Usermodel(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      role: json['role'],
      tel: json['tel'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id ?? null,
      'email': email,
      'password': password,
      'firstName': firstName ?? null,
      'lastName': lastName ?? null,
      'tel': tel ?? null,
    };
  }
}
