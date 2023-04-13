class User
{
  User({
    this.email,
    this.id,
    this.name,
    this.photo,
    this.toUserId,
    this.type,
    this.userLogo,
    this.userName,
  });

  String? email;
  String? id;
  String? name;
  String? photo;
  String? toUserId;
  String? type;
  String? userLogo;
  String? userName;

  factory User.fromJson(Map<String, dynamic> json) => User(
    email: json["email"],
    id: json["id"],
    name: json["name"],
    photo: json["photo"],
    toUserId: json["toUserId"],
    type: json["type"],
    userLogo: json["userLogo"],
    userName: json["userName"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "id": id,
    "name": name,
    "photo": photo,
    "toUserId": toUserId,
    "type": type,
    "userLogo": userLogo,
    "userName": userName,
  };
}