class LoginAuth {
  String message;
  TokenAuth data;

  LoginAuth({this.message, this.data});
  LoginAuth.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = TokenAuth.fromJson(json['data']);
  }
}

class TokenAuth {
  String token;
  TokenAuth({this.token});

  TokenAuth.fromJson(Map<String, dynamic> data) {
    token = data['token'];
  }
}

class User {
  String name;
  String email;
  String adr;
  String secteur;
  String description;
  String siteWeb;

  int id;
  String phone;
  User(
      {this.name,
      this.email,
      this.id,
      this.phone,
      this.description,
      this.siteWeb,
      this.adr,
      this.secteur});

  User.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      name = json['data']['name'];
      description = json['data']['secteur'];
      siteWeb = json['data']['siteWeb'];
      adr = json['data']['adr'];
      secteur = json['data']['secteur'];


      id = json['data']['id'];
      phone = json['data']['phone'];
      print(phone);
      email = json['data']['email'];
    } else {
      name = "";
      email = "";
    }
  }
}

class Logout {
  String message;

  Logout({this.message});

  Logout.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }
}
