import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sbf_mobile_app/Screens/auth/auth_screen.dart';
import 'package:sbf_mobile_app/Screens/login.dart';
import '../CustomUI/loader.dart';
import '../preferences/preferences.dart';

Future<void> postRequest(
    {required Map<String, dynamic> payload,
      required String endPoint,
      String? bearerToken,
      required Function onSuccess,
      Function? onError,
      required BuildContext context}) async {
  final dio = Dio();
  try {
    print(payload);
    print(endPoint);
    customLoader(context);
    Response response = bearerToken != null
        ? await dio.post(endPoint,
        data: payload,
        options: Options(headers: {
          'Content-Type' : 'application/json',
          'Authorization': 'Bearer $bearerToken'}))
        : await dio.post(endPoint, data: payload);
    Navigator.pop(context);
    if (response.statusCode == 200 || response.statusCode == 201) {
      // final jsonData = jsonDecode(response.data);
      onSuccess(response.data);
    } else {
      onError!(response.data);
    }
  }
  on DioException catch (e) {
    Navigator.pop(context);

    if(e.response?.statusCode==401){
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
              'Logged Out',
              style: TextStyle(color: Colors.red),
            )));
        SessionManager.cleanPrefrence();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const AuthScreen()),
                (Route<dynamic> route) => false);
      }
    }
    else {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }

  }
}

Future<void> getRequest(
    {required String endPoint,
      Map<String, dynamic>? payload,
      required Function onSuccess,
      String? bearerToken,
      Function? onError,
      required BuildContext context}) async {
  final dio = Dio();
  try {
    customLoader(context);
    Response response = bearerToken != null
        ? await dio.get(endPoint,
        data: payload,
        options: Options
          (
            headers: {
              "Content-Type": "application/json",
              'Authorization': 'Bearer $bearerToken'}))
        : await dio.get(endPoint, data: payload);
    if (response.statusCode == 200) {
      final jsonData = response.data;
      onSuccess(jsonData);
    } else {
      onError!(response.data);
    }
    if (context.mounted) {
      Navigator.pop(context);
    }
  }
  on DioException catch (e) {
    if (context.mounted) {
      Navigator.pop(context);
    }
    if(e.response?.statusCode==401){
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
              'Logged Out',
              style: TextStyle(color: Colors.red),
            )));
        SessionManager.cleanPrefrence();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const AuthScreen()),
                (Route<dynamic> route) => false);
      }
    }
    else {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }

  }
}
