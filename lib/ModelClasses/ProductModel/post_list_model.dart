// To parse this JSON data, do
//
//     final postListModel = postListModelFromJson(jsonString);

import 'dart:convert';

List<PostListModel> postListModelFromJson(String str) => List<PostListModel>.from(json.decode(str).map((x) => PostListModel.fromJson(x)));

String postListModelToJson(List<PostListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PostListModel {
  int? userId;
  int? id;
  String? title;
  String? body;

  PostListModel({
    this.userId,
    this.id,
    this.title,
    this.body,
  });

  factory PostListModel.fromJson(Map<String, dynamic> json) => PostListModel(
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
