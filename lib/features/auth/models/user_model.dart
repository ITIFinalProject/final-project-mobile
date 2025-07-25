class UserModel {
  String? name;
  String? email;
  String? address;
  String? imagePath;
  String? phone;

  UserModel({this.name, this.email, this.address, this.imagePath, this.phone});

  UserModel.fromFireStore(Map<String, dynamic> user)
    : this(
        name: user['name'],
        email: user['email'],
        address: user['address'],
        phone: user['phone'],
        imagePath: user['imagePath'],
      );

  Map<String, dynamic> toFireStore() {
    return {
      'name': name,
      'email': email,
      'address': address,
      'phone': phone,
      'imagePath': imagePath,
    };
  }
}
