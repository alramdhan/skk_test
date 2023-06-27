class User {
  final int userId;
  final String name;
  final String email;
  final String token;
  final String profilepicture;

  User(this.userId, this.name, this.email, this.token, this.profilepicture);

  User.fromJson(Map<String, dynamic> json) :
    userId = json['Id'] != null ? json['Id'] : json['id'],
    name = json['Name'] != null ? json['Name'] : json['name'],
    email = json['Email'] != null ? json['Email'] : json['email'],
    token = json['Token'] != null ? json['Token'] : "",
    profilepicture = json['profilepicture'] != null ? json['profilepicture'] : "";

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'name': name,
    'email': email,
    'token': token
  };
}