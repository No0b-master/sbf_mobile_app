import 'package:flutter/material.dart';
import 'package:sbf_mobile_app/Constant.dart';
import 'package:sbf_mobile_app/Util/get_initial_route.dart';
import 'package:sbf_mobile_app/preferences/preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SessionManager.init();
  await Firebase.initializeApp();

  runApp(const  MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override

  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    //SessionManager.cleanPrefrence();
 return MaterialApp(
      title: 'SBF India',
      theme: ThemeData(
        // textTheme: GoogleFonts.laBelleAuroreTextTheme(textTheme).copyWith(
        //   bodyMedium: GoogleFonts.actor(textStyle: textTheme.bodyLarge),
        // ),
        primarySwatch: Colors.blue,
      ),
      home: getInitialRoute(),
    );
  }
}
