import 'package:flutter/material.dart';
import 'package:sbf_mobile_app/Constant.dart';
import 'package:sbf_mobile_app/CustomUI/nav_bar.dart';
import 'package:sbf_mobile_app/CustomUI/nav_bar_admin.dart';
import 'package:sbf_mobile_app/Home.dart';
import 'package:sbf_mobile_app/preferences/preferences.dart';


Widget getInitialRoute(){
  String token = SessionManager.getString(Constant.access_token);
  if(token==''){
    return const Home();
  }
  else if(SessionManager.getString(Constant.userType)=='4'){
     return const NavBar(initialPage: 0,);
  }
  else {
    return const NavBarAdmin();

  }
}