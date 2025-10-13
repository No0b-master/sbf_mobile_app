import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import '../../CustomUI/CustomWidgets.dart';
import '../../CustomUI/snackBar.dart';
import '../../Util/http_request.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../webservices.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _otp = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirm = TextEditingController();

  bool registerWithEmail = true;
  bool otpSent = false;
  bool verified = false;
  bool showPassword = false;
  bool showConfirm = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String verificationId = '';
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  @override
  void initState() {
    super.initState();
    _googleSignIn.initialize();
  }

  // ========================= EMAIL OTP =========================
  Future<void> sendEmailOtp() async {
    if (_email.text.isEmpty) {
      showSnackBar(context: context, text: "Enter your email");
      return;
    }
    final payload = {'email': _email.text, 'name': _name.text};
    await postRequest(
      payload: payload,
      context: context,
      endPoint: Webservices.sendOtp,
      onSuccess: (res) {
        if (res['status']) {
          otpSent = true;
          showSnackBar(context: context, text: res['message']);
          setState(() {});
        }
      },
    );
  }

  Future<void> verifyEmailOtp() async {
    final payload = {'email': _email.text, 'otp': _otp.text};
    await postRequest(
      payload: payload,
      context: context,
      endPoint: Webservices.verifyOtp,
      onSuccess: (res) {
        if (res['status']) {
          verified = true;
          showSnackBar(context: context, text: "Email verified!");
          setState(() {});
        }
      },
    );
  }

  // ========================= PHONE OTP =========================
  Future<void> sendPhoneOtp() async {
    String phone = _phone.text.trim();
    if (!phone.startsWith('+')) phone = '+91$phone';

    await _auth.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (cred) async {
        await _auth.signInWithCredential(cred);
        verified = true;
        showSnackBar(context: context, text: "Phone verified!");
        setState(() {});
      },
      verificationFailed: (e) => showSnackBar(context: context, text: e.message ?? "Failed"),
      codeSent: (id, _) {
        verificationId = id;
        otpSent = true;
        setState(() {});
      },
      codeAutoRetrievalTimeout: (_) {},
    );
  }

  Future<void> verifyPhoneOtp() async {
    final cred = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: _otp.text,
    );
    await _auth.signInWithCredential(cred);
    verified = true;
    showSnackBar(context: context, text: "Phone verified!");
    setState(() {});
  }

  // ========================= REGISTER =========================
  Future<void> register() async {
    if (!verified) {
      showSnackBar(context: context, text: "Please verify first");
      return;
    }
    if (_password.text != _confirm.text) {
      showSnackBar(context: context, text: "Passwords do not match");
      return;
    }

    final payload = {
      'name': _name.text,
      'password': _password.text,
      if (registerWithEmail) 'email': _email.text else 'phone': _phone.text
    };

    await postRequest(
      payload: payload,
      context: context,
      endPoint: Webservices.register,
      onSuccess: (res) {
        if (res['status']) {
          showSnackBar(context: context, text: "Registered successfully!");
        }
      },
    );
  }

  // ========================= BUILD UI =========================
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          CustomWidget().inputBox(
            heading: "Full Name",
            Controller: _name,
            icon: Icons.person,
            iconColor: Colors.grey,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(registerWithEmail ? "Register via Email" : "Register via Phone"),
              Switch(
                value: !registerWithEmail,
                onChanged: (val) => setState(() {
                  registerWithEmail = !registerWithEmail;
                  otpSent = false;
                  verified = false;
                }),
              ),
            ],
          ),
          if (registerWithEmail)
            CustomWidget().inputBox(
              heading: "Email",
              Controller: _email,
              icon: Icons.email,
              iconColor: Colors.grey,
            )
          else
            CustomWidget().inputBox(
              heading: "Phone Number",
              Controller: _phone,
              type: TextInputType.phone,
              icon: Icons.phone,
              iconColor: Colors.grey,
            ),
          const SizedBox(height: 15),
          if (!otpSent)
            Center(
              child: CustomWidget().basicButton(
                text: "Send OTP",
                color: Colors.green,
                textColor: Colors.white,
                onTap: registerWithEmail ? sendEmailOtp : sendPhoneOtp,
                context: context,
              ),
            ),
          if (otpSent && !verified) ...[
            const SizedBox(height: 20),
            CustomWidget().inputBox(
              heading: "Enter OTP",
              Controller: _otp,
              icon: Icons.password,
              iconColor: Colors.grey,
              type: TextInputType.number,
            ),
            const SizedBox(height: 10),
            Center(
              child: CustomWidget().basicButton(
                text: "Verify",
                color: Colors.green,
                textColor: Colors.white,
                onTap: registerWithEmail ? verifyEmailOtp : verifyPhoneOtp,
                context: context,
              ),
            ),
          ],
          if (verified) ...[
            const SizedBox(height: 25),
            CustomWidget().inputBox(
              heading: "Create Password",
              Controller: _password,
              icon: Icons.lock,
              iconColor: Colors.grey,
              obscureText: !showPassword,
              ic2: IconButton(
                onPressed: () => setState(() => showPassword = !showPassword),
                icon: Icon(showPassword ? Icons.visibility : Icons.visibility_off),
              ),
            ),
            const SizedBox(height: 20),
            CustomWidget().inputBox(
              heading: "Confirm Password",
              Controller: _confirm,
              icon: Icons.lock,
              iconColor: Colors.grey,
              obscureText: !showConfirm,
              ic2: IconButton(
                onPressed: () => setState(() => showConfirm = !showConfirm),
                icon: Icon(showConfirm ? Icons.visibility : Icons.visibility_off),
              ),
            ),
            const SizedBox(height: 25),
            Center(
              child: CustomWidget().basicButton(
                text: "Register",
                color: Colors.green,
                textColor: Colors.white,
                onTap: register,
                context: context,
              ),
            ),
          ],
          const SizedBox(height: 25),
          _divider(),
          Center(
            child: SignInButton(
              Buttons.Google,
              text: "Sign up with Google",
              onPressed: () async {
                final user = await _googleSignIn.authenticate();
                _name.text = user.displayName ?? '';
                _email.text = user.email;
                _password.text = "${user.email}sbf_231@3451";
                _confirm.text = _password.text;
                verified = true;
                registerWithEmail = true;
                register();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const [
      SizedBox(width: 70, child: Divider(color: Colors.black)),
      SizedBox(width: 10),
      Text('or connect with'),
      SizedBox(width: 10),
      SizedBox(width: 70, child: Divider(color: Colors.black)),
    ],
  );
}
