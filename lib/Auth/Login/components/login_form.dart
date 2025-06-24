import 'package:flutter/material.dart';

import '../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../Signup/signup_screen.dart';
import '../../Signup/components/or_divider.dart';
import 'login_google_button.dart';
import '../../../admin_home.dart';
import '../../components/modal_validation.dart';

class LoginForm extends StatelessWidget {

  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? emailVal;
    String? passVal;

    return Form(
      child: Column(
        children: [
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Mohon isi email anda';
              }
              return null;
            },
            cursorColor: kPrimaryColor,
            onChanged: (email) {
              emailVal = email;
            },

            decoration: const InputDecoration(
              hintText: "Email",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.email),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: kPrimaryColor,
              onChanged: (password) {
                passVal = password;
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (password) {
                if (password == null || password.isEmpty) {
                  return 'Mohon isi password anda';
                }
                return null;
              },
              decoration: const InputDecoration(
                hintText: "Password",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          ElevatedButton(
            onPressed: () {
              showLoading(
                context,
                "Memuat",
                "Mohon tunggu sesaat ...",
                "assets/images/clock.png",
                "100",
              );
              Future.delayed(Duration(seconds: 1), () {
                if (emailVal == "admin" && passVal == "admin") {
                  hideLoading(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const AdminHome();
                      },
                    ),
                  );
                } else if (emailVal == "customer" && passVal == "customer") {
                  hideLoading(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const AdminHome();
                      },
                    ),
                  );
                } else {
                  hideLoading(context);
                  showLoading(
                    context,
                    "Gagal",
                    "Email atau password tidak valid",
                    "assets/images/failed.png",
                    "200",
                  );
                }
              });
            },
            child: Text("Login".toUpperCase()),
            style: ButtonStyle(
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  side: BorderSide(color: kPrimaryColor),
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          OrDivider(),
          LoginGoogleButton(),
          AlreadyHaveAnAccountCheck(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const SignUpScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
