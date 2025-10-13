// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_signin_button/button_list.dart';
// import 'package:flutter_signin_button/button_view.dart';
// import 'package:sbf_mobile_app/Constant.dart';
// import 'package:sbf_mobile_app/CustomUI/nav_bar.dart';
// import 'package:sbf_mobile_app/CustomUI/nav_bar_admin.dart';
// import 'package:sbf_mobile_app/CustomUI/snackBar.dart';
// import 'package:sbf_mobile_app/Home.dart';
// import 'package:sbf_mobile_app/CustomUI/CustomWidgets.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:sbf_mobile_app/Screens/forgotPassword.dart';
// import 'package:sbf_mobile_app/preferences/preferences.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import '../Util/http_request.dart';
// import '../webservices.dart';
//
// class Login extends StatefulWidget {
//   const Login({Key? key}) : super(key: key);
//
//   @override
//   State<Login> createState() => _LoginState();
// }
//
// class _LoginState extends State<Login> with TickerProviderStateMixin {
//   late TabController _tabController;
//   final TextEditingController _identifier = TextEditingController();
//
//   final TextEditingController _pswrd = TextEditingController();
//   final TextEditingController _RName = TextEditingController();
//   final TextEditingController _Remail = TextEditingController();
//   final TextEditingController _Rphone = TextEditingController();
//
//   final TextEditingController _otp = TextEditingController();
//
//   final TextEditingController _Rpswrd = TextEditingController();
//   final TextEditingController _Rconfirmpswrd = TextEditingController();
//
//   bool email = false;
//   bool _passwordVisible = false;
//   bool _RpasswordVisible = false;
//   bool _RCpasswordVisible = false;
//   bool isEmailValidated = false;
//   bool isOtpSent = false;
//
//   // Registration type toggle
//   bool registerWithEmail = true; // true = email, false = phone
//
//   // Firebase Auth
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   String _verificationId = '';
//
//   final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
//   late GoogleSignInAccount _userObj;
//
//   @override
//   void initState() {
//     _tabController = TabController(length: 2, vsync: this);
//
//     _googleSignIn.initialize(
//       serverClientId: '709561051398-vjft9155fjd8jr8878r363qaafdsv69o.apps.googleusercontent.com',
//     );
//
//     super.initState();
//
//     _tabController.addListener(() {
//       if (_tabController.indexIsChanging) {
//         _clearFields();
//       } else if (_tabController.index != _tabController.previousIndex) {
//         _clearFields();
//       }
//     });
//
//     _passwordVisible = true;
//     _RpasswordVisible = true;
//     _RCpasswordVisible = true;
//   }
//
//   void _clearFields() {
//     _identifier.clear();
//     _pswrd.clear();
//     _Remail.clear();
//     _Rphone.clear();
//     _RName.clear();
//     _otp.clear();
//     _Rconfirmpswrd.clear();
//     _Rpswrd.clear();
//     setState(() {
//       isEmailValidated = false;
//       isOtpSent = false;
//       registerWithEmail = true;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       child: SafeArea(
//         child: Scaffold(
//           body: Column(
//             children: [
//               const Image(
//                 image: AssetImage('assets/images/SBF_logo.png'),
//                 width: 200,
//                 height: 200,
//               ),
//               TabBar(
//                 unselectedLabelColor: const Color(0xffd7d6d6),
//                 labelColor: Colors.green,
//                 labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
//                 unselectedLabelStyle: const TextStyle(fontSize: 12),
//                 indicator: const UnderlineTabIndicator(
//                     borderSide: BorderSide(color: Colors.green)),
//                 padding: EdgeInsets.zero,
//                 controller: _tabController,
//                 tabs: const <Widget>[
//                   Tab(text: "Sign in"),
//                   Tab(text: "Sign Up"),
//                 ],
//               ),
//               Expanded(
//                 child: TabBarView(controller: _tabController, children: [
//                   _buildSignInTab(),
//                   _buildSignUpTab(),
//                 ]),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSignInTab() {
//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.only(left: 18.0, right: 18),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 30),
//             Row(
//               children: [
//                 const Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Text(
//                     "Login in Your Account",
//                     style: TextStyle(color: Color(0xff757575), fontSize: 15),
//                   ),
//                 ),
//                 Switch(
//                     value: email,
//                     onChanged: (val) {
//                       setState(() {
//                         email = !email;
//                       });
//                     }),
//               ],
//             ),
//             const SizedBox(height: 30),
//             CustomWidget().inputBox(
//                 heading: email == true ? "Email" : "Phone",
//                 Controller: _identifier,
//                 type: email == true
//                     ? TextInputType.emailAddress
//                     : TextInputType.number,
//                 icon: email == true ? Icons.email : Icons.phone,
//                 iconColor: Colors.grey),
//             const SizedBox(height: 25),
//             CustomWidget().inputBox(
//                 heading: "Password",
//                 Controller: _pswrd,
//                 icon: Icons.lock,
//                 iconColor: Colors.grey,
//                 obscureText: _passwordVisible,
//                 ic2: IconButton(
//                   onPressed: () {
//                     setState(() {
//                       _passwordVisible = !_passwordVisible;
//                     });
//                   },
//                   icon: Icon(
//                     _passwordVisible ? Icons.visibility : Icons.visibility_off,
//                     color: Theme.of(context).primaryColorDark,
//                   ),
//                 )),
//             const SizedBox(height: 10),
//             GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => Forgotpassword()));
//               },
//               child: Align(
//                 alignment: Alignment.centerRight,
//                 child: Text(
//                   "Forgot Password ?",
//                   style: TextStyle(
//                       color: Colors.grey,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 10),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 25),
//             Align(
//               alignment: Alignment.center,
//               child: CustomWidget().basicButton(
//                   text: "Login",
//                   color: Colors.green,
//                   textColor: Colors.white,
//                   onTap: () {
//                     _identifier.text.isEmpty
//                         ? ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(
//                             content: Text(
//                                 "Please enter email/phone and password")))
//                         : login();
//                   },
//                   context: context),
//             ),
//             const SizedBox(height: 20),
//             Container(
//               width: 500,
//               child: const Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SizedBox(
//                       width: 70,
//                       child:
//                       Divider(thickness: 1.0, color: Colors.black)),
//                   SizedBox(width: 10),
//                   Text('or connect with'),
//                   SizedBox(width: 10),
//                   SizedBox(
//                       width: 70,
//                       child:
//                       Divider(thickness: 1.0, color: Colors.black)),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 10),
//             Center(
//               child: SignInButton(
//                 text: "Login with Google",
//                 Buttons.Google,
//                 onPressed: () {
//                   _handleGoogleSignInForLogin();
//                 },
//               ),
//             ),
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSignUpTab() {
//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.only(left: 18.0, right: 18),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 30),
//             const Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Text(
//                 "Become part of the future",
//                 style: TextStyle(color: Color(0xff757575), fontSize: 15),
//               ),
//             ),
//             const SizedBox(height: 30),
//             Column(
//               children: [
//                 CustomWidget().inputBox(
//                     disabled: isEmailValidated,
//                     heading: "Name",
//                     Controller: _RName,
//                     icon: Icons.person,
//                     iconColor: Colors.grey),
//                 const SizedBox(height: 25),
//
//                 // Toggle between Email and Phone
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       registerWithEmail ? "Register with Email" : "Register with Phone",
//                       style: TextStyle(
//                           color: Colors.grey[700],
//                           fontWeight: FontWeight.bold,
//                           fontSize: 14),
//                     ),
//                     Switch(
//                       value: !registerWithEmail,
//                       onChanged: isEmailValidated
//                           ? null
//                           : (val) {
//                         setState(() {
//                           registerWithEmail = !registerWithEmail;
//                           isOtpSent = false;
//                           _Remail.clear();
//                           _Rphone.clear();
//                           _otp.clear();
//                         });
//                       },
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 15),
//
//                 // Email or Phone input
//                 if (registerWithEmail)
//                   CustomWidget().inputBox(
//                     disabled: isEmailValidated,
//                     heading: "E-mail",
//                     Controller: _Remail,
//                     icon: Icons.mail,
//                     iconColor: Colors.grey,
//                   )
//                 else
//                   CustomWidget().inputBox(
//                     disabled: isEmailValidated,
//                     heading: "Phone Number",
//                     Controller: _Rphone,
//                     type: TextInputType.phone,
//                     icon: Icons.phone,
//                     iconColor: Colors.grey,
//                   ),
//                 const SizedBox(height: 10),
//
//                 // OTP Input
//                 isOtpSent && !isEmailValidated
//                     ? CustomWidget().inputBox(
//                   heading: "OTP",
//                   Controller: _otp,
//                   type: TextInputType.number,
//                   icon: Icons.password,
//                   iconColor: Colors.grey,
//                 )
//                     : Container(),
//
//                 // Verify Button
//                 isOtpSent && !isEmailValidated
//                     ? Align(
//                   alignment: Alignment.center,
//                   child: CustomWidget().basicButton(
//                       text: "Verify",
//                       color: Colors.green,
//                       textColor: Colors.white,
//                       onTap: () {
//                         registerWithEmail
//                             ? validateEmailOtp()
//                             : validatePhoneOtp();
//                       },
//                       context: context),
//                 )
//                     : Container(),
//
//                 // Send OTP Button
//                 isOtpSent == false
//                     ? Align(
//                   alignment: Alignment.center,
//                   child: CustomWidget().basicButton(
//                       isConfirmation: true,
//                       text: "Send OTP",
//                       color: Colors.green,
//                       textColor: Colors.white,
//                       width: 200,
//                       height: 40,
//                       onTap: () {
//                         if (_RName.text.isEmpty) {
//                           showSnackBar(
//                               context: context,
//                               text: "Please enter your name");
//                           return;
//                         }
//                         if (registerWithEmail &&
//                             _Remail.text.isEmpty) {
//                           showSnackBar(
//                               context: context,
//                               text: "Please enter your email");
//                           return;
//                         }
//                         if (!registerWithEmail &&
//                             _Rphone.text.isEmpty) {
//                           showSnackBar(
//                               context: context,
//                               text: "Please enter your phone number");
//                           return;
//                         }
//                         registerWithEmail
//                             ? sendEmailOtp()
//                             : sendPhoneOtp();
//                       },
//                       context: context),
//                 )
//                     : Container(),
//               ],
//             ),
//
//             // Password fields after verification
//             isEmailValidated
//                 ? Column(
//               children: [
//                 const SizedBox(height: 25),
//                 CustomWidget().inputBox(
//                     heading: "Create Password",
//                     Controller: _Rpswrd,
//                     icon: Icons.lock,
//                     iconColor: Colors.grey,
//                     obscureText: _RpasswordVisible,
//                     ic2: IconButton(
//                       onPressed: () {
//                         setState(() {
//                           _RpasswordVisible = !_RpasswordVisible;
//                         });
//                       },
//                       icon: Icon(
//                         _RpasswordVisible
//                             ? Icons.visibility
//                             : Icons.visibility_off,
//                         color: Theme.of(context).primaryColorDark,
//                       ),
//                     )),
//                 const SizedBox(height: 25),
//                 CustomWidget().inputBox(
//                     heading: "Confirm Password",
//                     Controller: _Rconfirmpswrd,
//                     icon: Icons.lock,
//                     iconColor: Colors.grey,
//                     obscureText: _RCpasswordVisible,
//                     ic2: IconButton(
//                       onPressed: () {
//                         setState(() {
//                           _RCpasswordVisible = !_RCpasswordVisible;
//                         });
//                       },
//                       icon: Icon(
//                         _RCpasswordVisible
//                             ? Icons.visibility
//                             : Icons.visibility_off,
//                         color: Theme.of(context).primaryColorDark,
//                       ),
//                     )),
//                 const SizedBox(height: 25),
//                 Align(
//                   alignment: Alignment.center,
//                   child: CustomWidget().basicButton(
//                       isConfirmation: true,
//                       text: "Join in Community",
//                       color: Colors.green,
//                       textColor: Colors.white,
//                       onTap: () {
//                         _Rpswrd.text == _Rconfirmpswrd.text &&
//                             _RName.text.isNotEmpty &&
//                             _Rpswrd.text.isNotEmpty &&
//                             (registerWithEmail
//                                 ? _Remail.text.isNotEmpty
//                                 : _Rphone.text.isNotEmpty)
//                             ? register()
//                             : ScaffoldMessenger.of(context)
//                             .showSnackBar(const SnackBar(
//                             content: Text(
//                                 'Please enter all details correctly')));
//                       },
//                       context: context),
//                 ),
//                 const SizedBox(height: 20),
//               ],
//             )
//                 : Container(),
//             const SizedBox(height: 15),
//             Container(
//               width: 500,
//               child: const Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SizedBox(
//                       width: 70,
//                       child: Divider(thickness: 1.0, color: Colors.black)),
//                   SizedBox(width: 10),
//                   Text('or connect with'),
//                   SizedBox(width: 10),
//                   SizedBox(
//                       width: 70,
//                       child: Divider(thickness: 1.0, color: Colors.black)),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 15),
//             Center(
//               child: SignInButton(
//                 width: MediaQuery.of(context).size.width / 1.5,
//                 Buttons.Google,
//                 text: "Signup with Google",
//                 onPressed: () {
//                   _handleGoogleSignInForSignup(autoLogin: true);
//                 },
//               ),
//             ),
//             const SizedBox(height: 50)
//           ],
//         ),
//       ),
//     );
//   }
//
//   // ========== EMAIL OTP METHODS ==========
//   Future<void> sendEmailOtp() async {
//     Map<String, dynamic> payload = {
//       'email': _Remail.text,
//       'name': _RName.text
//     };
//     await postRequest(
//       payload: payload,
//       context: context,
//       onSuccess: (res) {
//         final data = res;
//         if (data['status'] == true) {
//           showSnackBar(context: context, text: data["message"]);
//           setState(() {
//             isOtpSent = true;
//           });
//         } else {
//           showSnackBar(context: context, text: data["message"]);
//         }
//       },
//       onError: (res) {
//         showSnackBar(context: context, text: res["message"]);
//       },
//       endPoint: Webservices.sendOtp,
//     );
//   }
//
//   Future<void> validateEmailOtp() async {
//     Map<String, dynamic> payload = {
//       'email': _Remail.text,
//       'otp': _otp.text
//     };
//     await postRequest(
//       payload: payload,
//       context: context,
//       onSuccess: (res) {
//         final data = res;
//         if (data['status'] == true) {
//           showSnackBar(context: context, text: data["message"]);
//           setState(() {
//             isEmailValidated = true;
//           });
//         } else {
//           showSnackBar(context: context, text: data["message"]);
//         }
//       },
//       onError: (res) {
//         showSnackBar(context: context, text: res["message"]);
//       },
//       endPoint: Webservices.verifyOtp,
//     );
//   }
//
//   // ========== PHONE OTP METHODS (Firebase) ==========
//   Future<void> sendPhoneOtp() async {
//     String phoneNumber = _Rphone.text.trim();
//
//     // Add country code if not present
//     if (!phoneNumber.startsWith('+')) {
//       phoneNumber = '+91$phoneNumber'; // Change +91 to your country code
//     }
//
//     try {
//       await _auth.verifyPhoneNumber(
//         phoneNumber: phoneNumber,
//         timeout: const Duration(seconds: 60),
//         verificationCompleted: (PhoneAuthCredential credential) async {
//           // Auto-verification (Android only)
//           await _signInWithPhoneCredential(credential);
//         },
//         verificationFailed: (FirebaseAuthException e) {
//           showSnackBar(
//               context: context,
//               text: "Verification failed: ${e.message}");
//         },
//         codeSent: (String verificationId, int? resendToken) {
//           setState(() {
//             _verificationId = verificationId;
//             isOtpSent = true;
//           });
//           showSnackBar(
//               context: context,
//               text: "OTP sent to $phoneNumber");
//         },
//         codeAutoRetrievalTimeout: (String verificationId) {
//           setState(() {
//             _verificationId = verificationId;
//           });
//         },
//       );
//     } catch (e) {
//       showSnackBar(
//           context: context,
//           text: "Failed to send OTP: $e");
//     }
//   }
//
//   Future<void> validatePhoneOtp() async {
//     try {
//       PhoneAuthCredential credential = PhoneAuthProvider.credential(
//         verificationId: _verificationId,
//         smsCode: _otp.text.trim(),
//       );
//
//       await _signInWithPhoneCredential(credential);
//     } catch (e) {
//       showSnackBar(
//           context: context,
//           text: "Invalid OTP. Please try again.");
//     }
//   }
//
//   Future<void> _signInWithPhoneCredential(
//       PhoneAuthCredential credential) async {
//     try {
//       await _auth.signInWithCredential(credential);
//
//       setState(() {
//         isEmailValidated = true;
//       });
//
//       showSnackBar(
//           context: context,
//           text: "Phone number verified successfully!");
//     } catch (e) {
//       showSnackBar(
//           context: context,
//           text: "Verification failed. Please try again.");
//     }
//   }
//
//   // ========== REGISTER METHOD ==========
//   Future<void> register({bool autoLogin = false}) async {
//     Map<String, dynamic> payload = {
//       'name': _RName.text,
//       'password': _Rpswrd.text,
//     };
//
//     if (registerWithEmail) {
//       payload['email'] = _Remail.text;
//     } else {
//       String phone = _Rphone.text.trim();
//       if (!phone.startsWith('+')) {
//         phone = '+91$phone'; // Add country code
//       }
//       payload['phoneNumber'] = phone;
//     }
//
//     await postRequest(
//       payload: payload,
//       context: context,
//       onSuccess: (res) {
//         final data = res;
//         if (data['status'] == true) {
//           showSnackBar(context: context, text: data["message"]);
//
//           if (autoLogin) {
//             _identifier.text =
//             registerWithEmail ? _Remail.text : _Rphone.text;
//             _pswrd.text = _Rpswrd.text;
//             login();
//           } else {
//             setState(() {
//               _tabController.animateTo(0);
//             });
//           }
//         } else {
//           showSnackBar(context: context, text: data["message"]);
//         }
//       },
//       onError: (res) {
//         showSnackBar(context: context, text: res["message"]);
//       },
//       endPoint: Webservices.register,
//     );
//   }
//
//   // ========== LOGIN METHOD ==========
//   Future<void> login() async {
//     Map<String, dynamic> payload = {
//       'identifier': _identifier.text,
//       'password': _pswrd.text
//     };
//     await postRequest(
//       payload: payload,
//       context: context,
//       onSuccess: (res) {
//         final data = res;
//         if (data['status'] == true) {
//           SessionManager.setString(Constant.SBFID, data["user"]["SBF_id"]);
//           SessionManager.setString(Constant.name, data["user"]["name"]);
//           SessionManager.setString(
//               Constant.email, data["user"]["email"] ?? '');
//           SessionManager.setString(
//               Constant.userType, data["user"]["userType"].toString());
//           SessionManager.setString(Constant.access_token, data["token"]);
//           SessionManager.setString(
//               Constant.state, data['user']["state"].toString());
//
//           if (data["user"]["userType"] == 4) {
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => const NavBar(initialPage: 0)));
//           } else {
//             Navigator.push(context,
//                 MaterialPageRoute(builder: (context) => const NavBarAdmin()));
//           }
//         } else {
//           showSnackBar(context: context, text: data["message"]);
//         }
//       },
//       endPoint: Webservices.login,
//     );
//   }
//
//   // ========== GOOGLE SIGN-IN METHODS ==========
//   String _genPwd(String email) => '${email}sbf_231@3451';
//
//   Future<void> _handleGoogleSignInForLogin() async {
//     try {
//       final user = await _googleSignIn.authenticate();
//
//       setState(() {
//         _identifier.text = user.email;
//         _pswrd.text = _genPwd(user.email);
//       });
//
//       await login();
//     } catch (e) {
//       debugPrint('Google login error: $e');
//       showSnackBar(
//           context: context,
//           text: "Google sign-in failed. Please try again.");
//     }
//   }
//
//   Future<void> _handleGoogleSignInForSignup({bool autoLogin = true}) async {
//     try {
//       final user = await _googleSignIn.authenticate();
//
//       final nameFromEmail = user.email.split('@').first;
//
//       setState(() {
//         _RName.text = user.displayName?.trim().isNotEmpty == true
//             ? user.displayName!.trim()
//             : nameFromEmail;
//         _Remail.text = user.email;
//         _Rpswrd.text = _genPwd(user.email);
//         _Rconfirmpswrd.text = _Rpswrd.text;
//
//         registerWithEmail = true;
//         isEmailValidated = true;
//         isOtpSent = false;
//       });
//
//       await register(autoLogin: autoLogin);
//     } catch (e) {
//       debugPrint('Google signup error: $e');
//       showSnackBar(
//           context: context,
//           text: "Google sign-up failed. Please try again.");
//     }
//   }
// }