class User{
 final int index;
 final String about;
 final String picture;
 final String email;
 final String name;
  User(this.index,this.about,this.picture,this.email,this.name);
}



// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

//import 'dart:convert';
//
//List<User> userFromJson(String str) => List<User>.from(json.decode(str).map((x) => User.fromJson(x)));
//
//String userToJson(List<User> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
//class User {
// int index;
// String about;
// String picture;
// String email;
// String name;
//
// User({
//  this.index,
//  this.about,
//  this.picture,
//  this.email,
//  this.name,
// });
//
// factory User.fromJson(Map<String, dynamic> json) => User(
//  index: json["index"],
//  about: json["about"],
//  picture: json["picture"],
//  email: json["email"],
//  name: json["name"],
// );
//
// Map<String, dynamic> toJson() => {
//  "index": index,
//  "about": about,
//  "picture": picture,
//  "email": email,
//  "name": name,
// };
//}
