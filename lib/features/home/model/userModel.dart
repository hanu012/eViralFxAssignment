class User {
  String name;
  String phone;
  String city;
  String image;
  int rupee;

  User({
    required this.name,
    required this.phone,
    required this.city,
    required this.image,
    required this.rupee,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      phone: json['phone'],
      city: json['city'],
      image: json['image'],
      rupee: json['rupee'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'city': city,
      'image': image,
      'rupee': rupee,
    };
  }
}
