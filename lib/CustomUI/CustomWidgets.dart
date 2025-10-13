import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class CustomWidget {
  void hidProgress({required BuildContext context}) {
    return Navigator.pop(context);
  }

  Future showProgress({
    required BuildContext context,
  }) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: const SizedBox(
              width: 100,
              height: 100,
              child: CircleAvatar(
                radius: 100,
                backgroundColor: Colors.transparent,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 30,
                  child: CircularProgressIndicator(
                    color: Colors.orange,
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget basicButton(
      {required String text,
      required BuildContext context,
      required Function() onTap,
      double? borderRadius,
      Color? color,
      Color? textColor,
      double? textSize,
      double? width,
      double? height,
      bool? isConfirmation,
      bool? disabled

      }) {
    if (disabled==true) {
      return Container(
        width: width ?? 200,
        height: height ?? 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 25)),
            color: Colors.grey),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: textColor ?? Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: textSize ?? 10),
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: isConfirmation != null
            ? () {
                if (isConfirmation) {
                  AwesomeDialog(
                    context: context,
                    transitionAnimationDuration:
                        const Duration(milliseconds: 100),
                    dialogType: DialogType.warning,
                    animType: AnimType.scale,
                    title: 'Confirm ',
                    desc: 'Are you sure you wanted to proceed further ?',
                    btnCancelOnPress: () {},
                    btnOkOnPress: onTap,
                  ).show();
                }
              }
            : onTap,
        child: Container(
          width: width ?? 250,
          height: height ?? 50,
          decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.all(Radius.circular(borderRadius ?? 25)),
              color: color ?? Colors.orange),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                  color: textColor ?? Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: textSize ?? 10),
            ),
          ),
        ),
      );
    }
  }

  Widget FormField(
      {required String label,
      required TextEditingController controller,
      TextInputType? type}) {
    return TextFormField(
      controller: controller,
      keyboardType: type ?? TextInputType.text,
      decoration: InputDecoration(
          label: RichText(
            text: TextSpan(
                text: label,
                style: const TextStyle(color: Colors.black),
                children: const [
                  TextSpan(text: ' *', style: TextStyle(color: Colors.red))
                ]),
            textScaleFactor: 1,
            maxLines: 1,
            overflow: TextOverflow.fade,
            textAlign: TextAlign.start,
          ),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.green))),
    );
  }

  Widget FormField2(
      {required String label,
      required TextEditingController controller,
      TextInputType? type}) {
    return TextFormField(
      controller: controller,
      keyboardType: type ?? TextInputType.text,
      decoration: InputDecoration(
          label: Text(label),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.green))),
    );
  }

  Widget inputBox(
      {String? label,
      double? containerHeight,
      double? containerWidth,
      int? maxLine,
      required String heading,
      bool? Suffix,
      IconData? icon,
      TextInputType? type,
      Function? validator,
      // ignore: non_constant_identifier_names
      TextEditingController? Controller,
      bool? obscureText,
      Color? iconColor,
      double? iconSize,
      double? borderRadius,
      Color? backgroundColor,
      String? hint,
      IconButton? ic2,
        bool? disabled ,
      String? initialValue}) {
    return Suffix == true
        ? Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(25)),
              boxShadow: [
                BoxShadow(
                  color: Color(0xffcdcdcd),
                  blurRadius: 20.0, // soften the shadow
                  spreadRadius: 2.0, //extend the shadow
                  offset: Offset(
                    10.0, // Move to right 10  horizontally
                    10.0, // Move to bottom 10 Vertically
                  ),
                )
              ],
            ),
            child: Column(
              children: [
                Text(
                  heading,
                  style: const TextStyle(
                      // fontFamily: "tcb",
                      fontSize: 10,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  enabled: disabled==true ? false : true,
                  keyboardType: type,

                  obscureText: obscureText ?? false,
                  controller: Controller,
                  decoration: InputDecoration(

                    disabledBorder: InputBorder.none,
                      filled: true,
                      fillColor: backgroundColor ?? Colors.white,
                      contentPadding:
                          const EdgeInsets.only(top: 10, bottom: 10, left: 10),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: const BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 2.0,
                        ),
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Icon(
                          icon,
                          color: iconColor,
                          size: iconSize,
                        ),
                      ),
                      labelText: label,
                      labelStyle: const TextStyle(
                        fontFamily: "tcb",
                      ),
                      hintText: hint,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(borderRadius ?? 35),
                      )),
                ),
              ],
            ),
          )
        : Container(
            height: containerHeight,
            width: containerWidth,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                  Radius.circular(borderRadius == null ? 25 : borderRadius)),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xffcdcdcd),
                  blurRadius: 20.0, // soften the shadow
                  spreadRadius: 2.0, //extend the shadow
                  offset: Offset(
                    10.0, // Move to right 10  horizontally
                    10.0, // Move to bottom 10 Vertically
                  ),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 18.0, top: 10),
                  child: Text(
                    heading,
                    style: const TextStyle(
                        fontFamily: "tcb",
                        fontSize: 10,
                        color: Color(0xffb7b7b7),
                        fontWeight: FontWeight.w500),
                  ),
                ),
                TextFormField(
                  enabled: disabled==true ? false : true,
                  maxLines: maxLine ?? 1,
                  // initialValue:
                  //initialValue==null?"":initialValue,

                  obscureText: obscureText ?? false,
                  controller: Controller,
                  keyboardType: type,
                  decoration: InputDecoration(
                      disabledBorder: InputBorder.none,

                      filled: true,
                      fillColor: backgroundColor ?? Colors.white,
                      contentPadding:
                          const EdgeInsets.only(top: 10, bottom: 10),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Icon(
                          icon,
                          color: iconColor,
                          size: iconSize,
                        ),
                      ),
                      suffixIcon: ic2,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: const BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 2.0,
                        ),
                      ),
                      labelText: label,
                      hintText: hint,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            borderRadius ?? 35),
                      )),
                ),
              ],
            ),
          );
  }

  Widget basicButtonWiImage(
      {required String text,
      required Function() onTap,
      required ImageProvider image,
      double? borderRadius,
      Color? color,
      Color? textColor,
      double? textSize,
      double? width,
      double? height}) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: width ?? 250,
            height: height ?? 50,
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.all(Radius.circular(borderRadius ?? 25)),
                color: color ?? Colors.orange),
            child: Center(
              child: Text(
                text,
                style: TextStyle(

                    color: textColor ?? Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: textSize ?? 10),
              ),
            ),
          ),
          Positioned(
              top: -5,
              left: -5,
              child: Image(
                image: image,
                width: 60,
                height: 60,
              )),
        ],
      ),
    );
  }
}
