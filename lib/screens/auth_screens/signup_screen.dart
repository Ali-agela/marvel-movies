import 'package:flutter/material.dart';
import 'package:marvel/helpers/constants.dart';
import 'package:marvel/providers/auth_provider.dart';
import 'package:marvel/widgets/buttons/main_button.dart';
import 'package:marvel/widgets/custome_text_form_filde.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController genderController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController PhoneController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  List<String> genders = ['male', 'female'];
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Sign Up  Screen"),
      ),
      body: Form(
        key: formkey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 70),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/marvelLogo.png"),
                SizedBox(
                  height: 40,
                ),
                CustomeTextFormFiled(
                    label: "name",
                    textEditingController: nameController,
                    validate: (v) {
                      if (v!.isEmpty) {
                        return "name cant be empty ";
                      }
                      return null;
                    }),
                SizedBox(
                  height: 25,
                ),
                CustomeTextFormFiled(
                    label: "phone",
                    textEditingController: PhoneController,
                    validate: (v) {
                      if (v!.length != 10) {
                        return " phone must be 10 numers ";
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
                        return "password is requred ";
                      }
                      if (v.length < 8) {
                        return "password must be at least 8 characters long ";
                      }
                      return null;
                    }),
                SizedBox(
                  height: 25,
                ),
                PopupMenuButton(
                  itemBuilder: (context) {
                    return List<PopupMenuItem>.from(
                        genders.map((e) => PopupMenuItem(
                              onTap: () {
                                setState(() {
                                  genderController.text = e;
                                  print(genderController.text);
                                });
                              },
                              child: Text(e),
                              value: e,
                            )));
                  },
                  child: CustomeTextFormFiled(
                      isEn: false,
                      label: "Gender",
                      textEditingController: genderController,
                      validate: (v) {
                        if (v!.isEmpty) {
                          return "gsenser is requred ";
                        }
                        if (v != 'male' && v != 'female') {
                          return "male or female ";
                        }
                        return null;
                      }),
                ),
                SizedBox(
                  height: 25,
                ),
                GestureDetector(
                  onTap: () {
                    showDatePicker(
                            context: context,
                            firstDate: DateTime(1997),
                            lastDate: DateTime(20060))
                        .then((s) {
                      setState(() {
                        dateController.text =
                            s!.toIso8601String().substring(0, 10);
                        print(dateController.text);
                      });
                    });
                  },
                  child: CustomeTextFormFiled(
                      isEn: false,
                      label: "Date",
                      hint: 'yyyy-mm-dd',
                      textEditingController: dateController,
                      validate: (v) {
                        if (v!.isEmpty) {
                          return "password is requred ";
                        }
                        return null;
                      }),
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: MainButton(
                    text: "SignUp",
                    onTap: () {
                      Provider.of<AuthProvider>(context, listen: false).signup({
                        "name": "${nameController.text}",
                        "phone": "${PhoneController.text}",
                        "password": "${passwordController.text}",
                        "gender": "${genderController.text}",
                        "DOB": "${dateController.text}"
                      }).then((onValue) {
                        if (onValue) {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("created ")));
                        }
                      });
                    },
                    borderRadius: 10,
                    btnColor: mainColor,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
