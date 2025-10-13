
import 'package:flutter/material.dart';

void showSnackBar({required BuildContext context,required String text}){
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        margin: const EdgeInsets.all(5),
      behavior: SnackBarBehavior.floating,
      content: Text(text)));
}