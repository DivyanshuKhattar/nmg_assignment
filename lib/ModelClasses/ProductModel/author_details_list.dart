// To parse this JSON data, do
//
//     final authorDetailModel = authorDetailModelFromJson(jsonString);

import 'dart:convert';

List<AuthorDetailModel> authorDetailModelFromJson(String str) => List<AuthorDetailModel>.from(json.decode(str).map((x) => AuthorDetailModel.fromJson(x)));

String authorDetailModelToJson(List<AuthorDetailModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AuthorDetailModel {
  int? id;
  String? name;
  String? username;
  String? email;
  Address? address;
  String? phone;
  String? website;
  Company? company;

  AuthorDetailModel({
    this.id,
    this.name,
    this.username,
    this.email,
    this.address,
    this.phone,
    this.website,
    this.company,
  });

  factory AuthorDetailModel.fromJson(Map<String, dynamic> json) => AuthorDetailModel(
    id: json["id"] ?? 0,
    name: json["name"] ?? "",
    username: json["username"] ?? "",
    email: json["email"] ?? "",
    address: json.containsKey("address") ? json["address"] != null ? Address.fromJson(json["address"]) :null :null,
    phone: json["phone"] ?? "",
    website: json["website"] ?? "",
    company: json.containsKey("company") ? json["company"] != null ? Company.fromJson(json["company"]) :null :null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "username": username,
    "email": email,
    "address": address!.toJson(),
    "phone": phone,
    "website": website,
    "company": company!.toJson(),
  };
}

class Address {
  String? street;
  String? suite;
  String? city;
  String? zipcode;
  Geo? geo;

  Address({
    this.street,
    this.suite,
    this.city,
    this.zipcode,
    this.geo,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    street: json["street"] ?? "",
    suite: json["suite"] ?? "",
    city: json["city"] ?? "",
    zipcode: json["zipcode"] ?? "",
    geo: json.containsKey("geo") ? json["geo"] != null ? Geo.fromJson(json["geo"]) :null :null,
  );

  Map<String, dynamic> toJson() => {
    "street": street,
    "suite": suite,
    "city": city,
    "zipcode": zipcode,
    "geo": geo!.toJson(),
  };
}

class Geo {
  String? lat;
  String? lng;

  Geo({
    this.lat,
    this.lng,
  });

  factory Geo.fromJson(Map<String, dynamic> json) => Geo(
    lat: json["lat"] ?? "",
    lng: json["lng"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lng": lng,
  };
}

class Company {
  String? name;
  String? catchPhrase;
  String? bs;

  Company({
    this.name,
    this.catchPhrase,
    this.bs,
  });

  factory Company.fromJson(Map<String, dynamic> json) => Company(
    name: json["name"] ?? "",
    catchPhrase: json["catchPhrase"] ?? "",
    bs: json["bs"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "catchPhrase": catchPhrase,
    "bs": bs,
  };
}
