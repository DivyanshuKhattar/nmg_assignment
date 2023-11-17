// To parse this JSON data, do
//
//     final productContentModel = productContentModelFromJson(jsonString);

import 'dart:convert';

ProductContentModel productContentModelFromJson(String str) => ProductContentModel.fromJson(json.decode(str));

String productContentModelToJson(ProductContentModel data) => json.encode(data.toJson());

class ProductContentModel {
  int? userId;
  int? id;
  String? title;
  String? body;

  ProductContentModel({
    this.userId,
    this.id,
    this.title,
    this.body,
  });

  factory ProductContentModel.fromJson(Map<String, dynamic> json) => ProductContentModel(
    userId: json["userId"] ?? 0,
    id: json["id"] ?? 0,
    title: json["title"] ?? "",
    body: json["body"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "id": id,
    "title": title,
    "body": body,
  };
}
