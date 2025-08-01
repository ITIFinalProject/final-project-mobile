class UserModel {
  String? uid;
  String? name;
  String? email;
  String? address;
  String? imagePath;
  String? phone;
  final String? fcmToken;

  UserModel({
    this.name,
    this.email,
    this.address,
    this.imagePath,
    this.phone,
    this.uid,
    this.fcmToken,
  });

  UserModel.fromFireStore(Map<String, dynamic> user)
    : this(
        uid: user['uid'],
        name: user['name'],
        email: user['email'],
        address: user['address'],
        phone: user['phone'],
        imagePath: user['imagePath'],
        fcmToken: user['fcmToken'],
      );

  Map<String, dynamic> toFireStore() {
    return {
      'uid':uid,
      'name': name,
      'email': email,
      'address': address,
      'phone': phone,
      'imagePath': imagePath,
      'fcmToken': fcmToken,
    };
  }
}
