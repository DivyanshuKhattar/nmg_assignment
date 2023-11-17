import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nmg_assignment/CommonClasses/common_functions.dart';
import 'package:nmg_assignment/CommonClasses/custom_toast.dart';
import 'package:nmg_assignment/Resources/string_constant.dart';
import 'package:nmg_assignment/main.dart';

class Util{

  /// function for GET AUTHOR LIST api calling
  static Future getAuthorList() async {
    try {
      var result = await CommonFunction().checkNetwork();
      if(result == true){
        var response = await http.get(Uri.parse("${baseUrl}users"));
        if(response.statusCode == 200){
          return response.body;
        }
        else{
          CustomToast.showToastMessage(StringConstants().errorMessage);
        }
      }
      else{
        CustomToast.showToastMessage(StringConstants().noNetwork);
      }
    } catch (e) {
      debugPrint('GET AUTHOR LIST failed: $e');
    }
  }

  /// function for GET POST LIST DATA api calling
  static Future getPostListData() async {
    try {
      var result = await CommonFunction().checkNetwork();
      if(result == true){
        var response = await http.get(Uri.parse("${baseUrl}posts"));
        if(response.statusCode == 200){
          return response.body;
        }
        else{
          CustomToast.showToastMessage(StringConstants().errorMessage);
        }
      }
      else{
        CustomToast.showToastMessage(StringConstants().noNetwork);
      }
    } catch (e) {
      debugPrint('GET POST LIST failed: $e');
    }
  }

  /// function for GET POST DETAIL api calling
  static Future getPostDetail(int id) async {
    try {
      var result = await CommonFunction().checkNetwork();
      if(result == true){
        var response = await http.get(Uri.parse("${baseUrl}posts/$id"));
        if(response.statusCode == 200){
          return response.body;
        }
        else{
          CustomToast.showToastMessage(StringConstants().errorMessage);
        }
      }
      else{
        CustomToast.showToastMessage(StringConstants().noNetwork);
      }
    } catch (e) {
      debugPrint('GET POST DETAIL failed: $e');
    }
  }

}