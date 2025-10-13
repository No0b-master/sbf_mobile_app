import 'package:flutter/material.dart';
import '../../CustomUI/CustomWidgets.dart';
import '../../CustomUI/nav_bar.dart';
import '../../CustomUI/nav_bar_admin.dart';
import '../../CustomUI/snackBar.dart';
import '../../Util/http_request.dart';
import '../../preferences/preferences.dart';
import '../../Constant.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../webservices.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _identifier = TextEditingController();
  final TextEditingController _password = TextEditingController();

  bool _passwordVisible = false;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  @override
  void initState() {
    super.initState();
    _passwordVisible = true;
    _googleSignIn.initialize(
      serverClientId:
      '709561051398-vjft9155fjd8jr8878r363qaafdsv69o.apps.googleusercontent.com',
    );
  }

  Future<void> _login() async {
    if (_identifier.text.isEmpty || _password.text.isEmpty) {
      showSnackBar(context: context, text: "Please enter all fields");
      return;
    }

    final payload = {
      'identifier': _identifier.text,
      'password': _password.text,
    };

    await postRequest(
      payload: payload,
      context: context,
      endPoint: Webservices.login,
      onSuccess: (res) {
        if (res['status'] == true) {
          final user = res['user'];
          SessionManager.setString(Constant.name, user["name"]);
          SessionManager.setString(Constant.email, user["email"] ?? '');
          SessionManager.setString(Constant.userType, user["userType"].toString());
          SessionManager.setString(Constant.access_token, res["token"]);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => user["userType"] == 4
                  ? const NavBar(initialPage: 0)
                  : const NavBarAdmin(),
            ),
          );
        } else {
          showSnackBar(context: context, text: res["message"]);
        }
      },
    );
  }

  Future<void> _loginWithGoogle() async {
    try {
      final user = await _googleSignIn.authenticate();
      _identifier.text = user.email;
      _password.text = "${user.email}sbf_231@3451";
      await _login();
    } catch (e) {
      showSnackBar(context: context, text: "Google sign-in failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          const Text("Login to your account",
              style: TextStyle(color: Colors.grey, fontSize: 15)),
          const SizedBox(height: 30),
          CustomWidget().inputBox(
            heading: "Email or Phone",
            Controller: _identifier,
            icon: Icons.person,
            iconColor: Colors.grey,
          ),
          const SizedBox(height: 20),
          CustomWidget().inputBox(
            heading: "Password",
            Controller: _password,
            icon: Icons.lock,
            iconColor: Colors.grey,
            obscureText: _passwordVisible,
            ic2: IconButton(
              onPressed: () => setState(() => _passwordVisible = !_passwordVisible),
              icon: Icon(
                _passwordVisible ? Icons.visibility : Icons.visibility_off,
              ),
            ),
          ),
          const SizedBox(height: 30),
          Align(
            alignment: Alignment.center,
            child: CustomWidget().basicButton(
              text: "Login",
              color: Colors.green,
              textColor: Colors.white,
              onTap: _login,
              context: context,
            ),
          ),
          const SizedBox(height: 20),
          _divider(),
          Center(
            child: SignInButton(
              Buttons.Google,
              text: "Login with Google",
              onPressed: _loginWithGoogle,
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
