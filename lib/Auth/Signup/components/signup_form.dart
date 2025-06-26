import 'package:flutter/material.dart';

import '../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../Login/login_screen.dart';
import '../../components/modal_validation.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    String? emailVal;
    String? nameVal;
    String? passVal;
    String? confPassVal;
    String? isValid;

    return Form(
      child: Column(
        children: [
          TextFormField(
            validator: (email) {
              if (email == null || email.isEmpty) {
                return 'Mohon isi password anda';
              }
              return null;
            },
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
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
          Container(
            margin: const EdgeInsets.only(top: 15.0),
            child: TextFormField(
              validator: (name) {
                if (name == null || name.isEmpty) {
                  return 'Mohon isi password anda';
                }
                nameVal = name;
                return null;
              },
              onChanged: (name) {
                nameVal = name;
              },
              textInputAction: TextInputAction.done,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "Nama lengkap",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.person),
                ),
              ),
            ),
          ),

          Container(
            margin: const EdgeInsets.only(top: 15.0),
            child: TextFormField(
              validator: (password) {
                if (password == null || password.isEmpty) {
                  return 'Mohon isi password anda';
                }
                passVal = password;
                return null;
              },
              onChanged: (pass) {
                passVal = pass;
              },
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "Password",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              validator: (confPass) {
                if (confPass == null || confPass.isEmpty) {
                  return 'Mohon isi password anda';
                }
                return null;
              },
              onChanged: (confPass) {
                confPassVal = confPass;
              },
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "Ketik ulang password",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock_clock),
                ),
              ),
            ),
          ),

          const SizedBox(height: defaultPadding / 2),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
            ),
            onPressed: () {
              isValid = "yes";
              showLoading(
                context,
                "Memuat",
                "Mohon tunggu sesaat ...",
                "assets/images/clock.png",
                "100",
              );
              Future.delayed(Duration(seconds: 1), () {
                hideLoading(context);
                if (passVal != confPassVal) {
                  isValid = "no";
                  showLoading(
                    context,
                    "Gagal",
                    "Mohon konfirmasi ulang password anda",
                    "assets/images/failed.png",
                    "200",
                  );
                  return null;
                }

                if (emailVal == null) {
                  isValid = "no";
                  showLoading(
                    context,
                    "Gagal",
                    "Email tidak boleh kosong!",
                    "assets/images/failed.png",
                    "200",
                  );
                  return null;
                }

                if (nameVal == null) {
                  isValid = "no";
                  showLoading(
                    context,
                    "Gagal",
                    "Nama tidak boleh kosong!",
                    "assets/images/failed.png",
                    "200",
                  );
                  return null;
                }
                if (passVal == null) {
                  isValid = "no";
                  showLoading(
                    context,
                    "Gagal",
                    "Mohon isi password anda!",
                    "assets/images/failed.png",
                    "200",
                  );
                  return null;
                }

                if (isValid == "yes") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(
                        successRegister: 'Registration successful!',
                      ),
                    ),
                  );
                }
              });
            },
            child: Text("Sign Up".toUpperCase()),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
