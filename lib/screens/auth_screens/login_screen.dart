import 'package:flutter/material.dart';
import 'package:marvel/helpers/constants.dart';
import 'package:marvel/main.dart';
import 'package:marvel/providers/auth_provider.dart';
import 'package:marvel/screens/auth_screens/signup_screen.dart';
import 'package:marvel/widgets/buttons/main_button.dart';
import 'package:marvel/widgets/custome_text_form_filde.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController phoneController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    GlobalKey<FormState> formkey = GlobalKey<FormState>();

    return Consumer<AuthProvider>(builder: (context, authConsumer, _) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Log In Screen"),
        ),
        body: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 70),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/marvelLogo.png"),
                SizedBox(
                  height: 40,
                ),
                CustomeTextFormFiled(
                    label: "phone",
                    textEditingController: phoneController,
                    validate: (v) {
                      if (v!.isEmpty) {
                        return "phone cant be empty ";
                      }
                      if (v.length != 10) {
                        return " phone mut be only in 10 characters ";
                      }
                      return null;
                    }),
                SizedBox(
                  height: 25,
                ),
                CustomeTextFormFiled(
                    label: "password",
                    textEditingController: passwordController,
                    validate: (v) {
                      if (v!.isEmpty) {
                        return "password Cant be empty ";
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: MainButton(
                    text: "LogIn",
                    onTap: () {
                      if (formkey.currentState!.validate()) {
                        Provider.of<AuthProvider>(context, listen: false)
                            .login({
                          "phone": "${phoneController.text}",
                          "password": "${passwordController.text}"
                        }).then((logedIn){
                          if (logedIn) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (contex) => ScreenRouter()));
                          }
                        });
                      }
                      
                    },
                    borderRadius: 10,
                    btnColor: mainColor,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextButton(
                  child: Text(" dont Have An account ? creat new Account "),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (contex) => SignUpScreen()));
                  },
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
