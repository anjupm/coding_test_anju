class RegisterModel {
  RegisterModel({
    required this.id,
    required this.token,
  });

  int id;
  String token;

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
    id: json["id"] ?? "",
    token: json["token"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "token": token,
  };
}
