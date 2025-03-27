class UserModel {
  String uid;
  String name;
  String email;
  String password;
  String image;
  String token;
  int selectedImage;
  bool isOnline;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.password,
    required this.image,
    required this.selectedImage,
    required this.token,
    required this.isOnline,
  });

  factory UserModel.fromJson(Map<String, dynamic> data) {
    return UserModel(
      uid: data['uid'],
      selectedImage: data['selectedImage'],
      name: data['name'],
      email: data['email'],
      password: data['password'],
      image: data['image'],
      token: data['token'],
      isOnline: data['isOnline'],
    );
  }

  Map<String, dynamic> get toMap => {
        'uid': uid,
        'name': name,
        'email': email,
        'password': password,
        'image': image,
        'selectedImage': selectedImage,
        'token': token,
        'isOnline': isOnline
      };
}
