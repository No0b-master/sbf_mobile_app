import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sbf_mobile_app/CustomUI/Appbar.dart';
import 'package:sbf_mobile_app/Screens/auth/auth_screen.dart';
import 'package:sbf_mobile_app/preferences/preferences.dart';

import 'login.dart';
class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      
      
      body: Column(

      children: [
        appBar(context),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: (){
                  AwesomeDialog(
                    context: context,
                    transitionAnimationDuration:
                    const Duration(milliseconds: 100),
                    dialogType: DialogType.warning,
                    animType: AnimType.scale,
                    title: 'Confirm ',
                    desc: 'Are you sure you wanted to proceed further ?',
                    btnCancelOnPress: () {},
                    btnOkOnPress: (){
                      SessionManager.cleanPrefrence();
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => const AuthScreen()),
                              (Route<dynamic> route) => false);
                    },
                  ).show();

                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Logout"),
                    Icon(Icons.logout,size: 30,color: Colors.orangeAccent)
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Divider(thickness: 1),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: (){

                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Help"),
                    Icon(Icons.help,size: 30,color: Colors.orangeAccent)
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Divider(thickness: 1),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: (){

                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("FAQ"),
                    Icon(Icons.question_answer_outlined,size: 30,color: Colors.orangeAccent)
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Divider(thickness: 1)
            ],
          ),
        ),
      Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<PackageInfo>(
            future: PackageInfo.fromPlatform(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  return Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      'Version: ${snapshot.data!.version}',
                    ),
                  );
                default:
                  return const SizedBox();
              }
            },
          ),
        ),
      )

      ],
    ),));
  }
}
