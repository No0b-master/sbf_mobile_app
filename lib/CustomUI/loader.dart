import 'package:flutter/material.dart';
import 'package:logo_n_spinner/logo_n_spinner.dart';

Future<void> customLoader(context){
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return const Center(
          child: LogoandSpinner(
            imageAssets: 'assets/images/SBF_logo.png',
            reverse: true,
            arcColor: Colors.orange,
            spinSpeed: Duration(milliseconds: 500),
          ),
        );
      }) ;
}