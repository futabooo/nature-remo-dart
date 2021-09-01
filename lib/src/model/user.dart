class User {
  final String id;
  final String nickname;

  User({required this.id, required this.nickname});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      nickname: json['nickname'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'id': id, 'nickname': nickname};
  }
}
