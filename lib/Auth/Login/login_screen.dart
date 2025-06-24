import 'package:flutter/material.dart';
import '../../../responsive.dart';

import '../components/background_auth.dart';
import 'components/login_form.dart';
import 'components/login_screen_top_image.dart';
import '../components/modal_validation.dart';

class LoginScreen extends StatefulWidget {
  final String? successRegister;
  const LoginScreen({Key? key, this.successRegister}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    print('test');
   
    // Delay to show snackbar after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print(widget.successRegister);
      if (widget.successRegister != null) {
        showLoading(
          context,
          "Berhasil daftar!",
          "Silahkan login dengan akun anda",
          "assets/images/check.png",
          "200",
        );
      }
    });
  } 

  @override
  Widget build(BuildContext context) {
    return const BackgroundAuth(
      child: SingleChildScrollView(
        child: Responsive(
          mobile: MobileLoginScreen(),
          desktop: Row(
            children: [
              Expanded(child: LoginScreenTopImage()),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [SizedBox(width: 450, child: LoginForm())],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MobileLoginScreen extends StatelessWidget {
  const MobileLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        LoginScreenTopImage(),
        Row(
          children: [
            Spacer(),
            Expanded(flex: 8, child: LoginForm()),
            Spacer(),
          ],
        ),
      ],
    );
  }
}
