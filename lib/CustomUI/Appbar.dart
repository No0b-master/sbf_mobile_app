
import 'package:flutter/material.dart';
import 'package:sbf_mobile_app/Screens/auth/auth_screen.dart';

import '../Constant.dart';
import '../Screens/login.dart';
import '../preferences/preferences.dart';
import 'CustomWidgets.dart';

Widget appBar(BuildContext context){
  return Container(
    padding: const EdgeInsets.only(right: 10),
    child:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
            Row(
            children: [
              Image.asset('assets/images/SBF_logo.png',scale: 35),
              const SizedBox(
                width: 1,
                height: 40,
                child: Divider(
                    thickness: 40, height: 50, color: Colors.black),
              ),
              const SizedBox(width: 10),
              Image.asset('assets/images/VISION2026.png',scale: 20)

            ],
          ),
          SessionManager.getString(Constant.access_token)==''?
          CustomWidget().basicButton(
            context : context,
              width: 100,
              color: Colors.green,
              text: 'Login', onTap: (){
            SessionManager.cleanPrefrence();
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const AuthScreen()),
                    (Route<dynamic> route) => false);
          }):
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.circle,color: Colors.green,size: 12),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('SBF Id : ${SessionManager.getString(Constant.SBFID)}',style: const TextStyle(
                      fontSize: 12
                  ),),
                  Text('Name : ${SessionManager.getString(Constant.name)}',style: const TextStyle(
                      fontSize: 12
                  ),)
                ],
              ),
            ],
          )
        ]),
  );
}