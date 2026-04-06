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
  // Map<String, dynamic> toJson() {
  //   return {
  //     'id': id ,
  //     'email': email,
  //     'password': password,
  //     'firstName': firstName ?? null,
  //     'lastName': lastName ?? null,
  //     'tel': tel ?? null,
  //     'profileImage': profileImage,
  //   };
  // }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    if (email != null) data['email'] = email;
    if (password != null) data['password'] = password;
    if (firstName != null) data['firstName'] = firstName;
    if (lastName != null) data['lastName'] = lastName;
    if (tel != null) data['tel'] = tel;
    if (profileImage != null) data['profileImage'] = profileImage;
    if (role != null) data['role'] = role;

    return data;
  }
}
