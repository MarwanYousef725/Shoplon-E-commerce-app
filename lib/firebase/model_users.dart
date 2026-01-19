class UserInfo {
  final String name;
  final String email;
  UserInfo({required this.name, required this.email});
  Map<String, dynamic> toJson() {
    return {"name": name, 'email': email};
  }

  factory UserInfo.fromJson(json) =>
      UserInfo(name: json['name'] ?? '', email: json['email'] ?? '');
}
