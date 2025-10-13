import 'package:flutter/material.dart';
import 'package:sbf_mobile_app/Screens/auth/auth_screen.dart';
import 'package:sbf_mobile_app/Screens/login.dart';

import '../CustomUI/CustomWidgets.dart';
import '../CustomUI/snackBar.dart';
import '../Util/http_request.dart';
import '../webservices.dart';


class Forgotpassword extends StatefulWidget {
  const Forgotpassword({super.key});

  @override
  State<Forgotpassword> createState() => _ForgotpasswordState();
}

class _ForgotpasswordState extends State<Forgotpassword> {

  final TextEditingController _Rpswrd = TextEditingController();
  final TextEditingController _Rconfirmpswrd = TextEditingController();
  final TextEditingController _Remail = TextEditingController();
  final TextEditingController _otp = TextEditingController();
  bool _RpasswordVisible = false;
  bool _RCpasswordVisible = false;
  bool isEmailValidated = false ;
  bool isOtpSent = false ;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,

        child: Scaffold(
          appBar: AppBar(title: Text("Forgot Password", style: TextStyle(fontSize: 13),),),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: const Image(
                    image: AssetImage('assets/images/SBF_logo.png'),
                    width: 200,
                    height: 200,
                  ),
                ),

               Padding(
                    padding: const EdgeInsets.only(left: 18.0, right: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 30),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Reset your password",
                            style: TextStyle(
                                color: Color(0xff757575), fontSize: 15),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Column(
                          children: [
                            CustomWidget().inputBox(

                              disabled: isEmailValidated,

                              heading: "E-mail",
                              Controller: _Remail,
                              icon: Icons.mail,
                              iconColor: Colors.grey,


                            ),

                            isOtpSent && !isEmailValidated ?
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0,bottom: 10),
                              child: CustomWidget().inputBox(

                                heading: "OTP",
                                Controller: _otp,
                                icon: Icons.password,
                                iconColor: Colors.grey,


                              ),
                            ) : Container(),



                            isOtpSent && !isEmailValidated?
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0,bottom: 10),
                              child: Align(
                                alignment: Alignment.center,
                                child: CustomWidget().basicButton(
                                    text: "Verify",
                                    color: Colors.green,
                                    textColor: Colors.white,
                                    onTap: () {
                                      validate() ;

                                    }, context: context),
                              ),
                            ): Container() ,

                            isOtpSent == false ?
                            Padding(
                              padding: const EdgeInsets.only(top: 30.0,bottom: 10),
                              child: Align(
                                alignment: Alignment.center,
                                child: CustomWidget().basicButton(
                                    isConfirmation: true,
                                    text: "Send OTP",
                                    color: Colors.green,
                                    textColor: Colors.white,
                                    width: 200,
                                    height: 40,
                                    onTap: () {
                                      sendOtp() ;

                                    }, context: context),
                              ),
                            ) : Container(),
                          ],
                        ),

                        isEmailValidated ? Column(
                          children: [
                            const SizedBox(height: 25),
                            CustomWidget().inputBox(
                                heading: "Re-Create Password",
                                Controller: _Rpswrd,
                                icon: Icons.lock,
                                iconColor: Colors.grey,
                                obscureText: _RpasswordVisible,
                                ic2: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (_RpasswordVisible == false) {
                                        _RpasswordVisible = true;
                                      } else {
                                        _RpasswordVisible = false;
                                      }
                                    });
                                  },
                                  icon: Icon(
                                    // Based on passwordVisible state choose the icon
                                    _RpasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                )),
                            const SizedBox(height: 25),
                            CustomWidget().inputBox(
                                heading: "Confirm Password",
                                Controller: _Rconfirmpswrd,
                                icon: Icons.lock,
                                iconColor: Colors.grey,
                                obscureText: _RCpasswordVisible,
                                ic2: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (_RCpasswordVisible == false) {
                                        _RCpasswordVisible = true;
                                      } else {
                                        _RCpasswordVisible = false;
                                      }
                                    });
                                  },
                                  icon: Icon(
                                    // Based on passwordVisible state choose the icon
                                    _RCpasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                )),
                            const SizedBox(height: 25),
                            Align(
                              alignment: Alignment.center,
                              child: CustomWidget().basicButton(
                                  isConfirmation: true,
                                  text: "Reset Password",

                                  color: Colors.green,
                                  textColor: Colors.white,
                                  onTap: () {
                                    _Rpswrd.text == _Rconfirmpswrd.text &&
                                        _Rpswrd.text.isNotEmpty &&
                                        _Remail.text.isNotEmpty
                                        ? resetPassword()
                                        : ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                        content: Text(
                                            'Please enter all details correctly')));
                                  }, context: context),
                            ),
                            const SizedBox(height: 20),

                          ],
                        ) : Container() ,
                        const SizedBox(height: 15),

                      ],
                    ),
                  ),






              ],
            ),
          ),
        ));
  }

  Future<void> resetPassword() async {
    Map<String,dynamic> payload= {
      'email': _Remail.text,
      'newPassword' : _Rpswrd.text,
    };

    await postRequest(
      payload: payload,
      context: context,
      onSuccess: (res){
        final data = res;
        if (data['status'] == true ) {
          showSnackBar(context: context, text: data["message"]);
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => AuthScreen(),
            ),
                (Route<dynamic> route) => false,
          );

        } else {
          showSnackBar(context: context, text: data["message"]);
        }
      },
      onError: (res){
        showSnackBar(context: context, text: res["message"]);
      },
      endPoint: Webservices.resetPassword,
    );
  }


  Future<void> sendOtp() async {
    Map<String,dynamic> payload= {
      'email': _Remail.text,
      'name' : "User"
    };
    await postRequest(
      payload: payload,
      context: context,
      onSuccess: (res){
        final data = res;
        if (data['status'] == true ) {
          showSnackBar(context: context, text: data["message"]);
          setState(() {
            isOtpSent=true ;
          });
        } else {
          showSnackBar(context: context, text: data["message"]);

        }
      },
      onError: (res){
        showSnackBar(context: context, text: res["message"]);
      },
      endPoint: Webservices.sendOtp,
    );
  }

  Future<void> validate() async {
    Map<String,dynamic> payload= {
      'email': _Remail.text,
      'otp' : _otp.text
    };
    await postRequest(
      payload: payload,
      context: context,
      onSuccess: (res){
        final data = res;
        if (data['status'] == true ) {
          showSnackBar(context: context, text: data["message"]);
          setState(() {
            isEmailValidated=true ;
          });
        } else {
          showSnackBar(context: context, text: data["message"]);

        }
      },
      onError: (res){
        showSnackBar(context: context, text: res["message"]);
      },
      endPoint: Webservices.verifyOtp,
    );
  }
}
