import 'package:chat/helper/snackpar_show.dart';
import 'package:chat/pages/chat_page.dart';
import 'package:chat/widget/buttom.dart';
import 'package:chat/const/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../widget/text_form_field.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});
  static String id = 'RegisterPage';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? email;

  String? password;

  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Image.asset('assets/images/scholar.png'),
                    const Text(
                      'Scholar Chat',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Pacifico'),
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'REGISTER',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                        MyTextFormfield(
                            validator: (data) {
                              if (data!.isEmpty || !data.contains('@')) {
                                return "enter a valid eamil";
                              }
                            },
                            onChanged: (data) {
                              email = data;
                            },
                            hintText: 'Email',
                            textInputType: TextInputType.emailAddress),
                        const SizedBox(
                          height: 14,
                        ),
                        MyTextFormfield(
                          obscureText: true,
                            validator: (data) {
                              
                              if (data!.isEmpty || data.length < 6) {
                                return 'Enter passward greater than 6 letters';
                              }
                            },
                            onChanged: (data) {
                              password = data;
                            },
                            hintText: 'Password',
                            textInputType: TextInputType.visiblePassword),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomButton(
                          text: 'Register',
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              isLoading = true;
                              setState(() {});
                              try {
                                await registerUser();
                                 Navigator.pushNamed(context, ChatPage.id,arguments: email);
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'weak-password') {
                                  showMessageToUser(context,
                                      'The password provided is too weak');
                                } else if (e.code == 'email-already-in-use') {
                                  showMessageToUser(context,
                                      'The account already exists for that email');
                                }
                                
                              } catch (e) {
                                showMessageToUser(
                                    context, 'there was an error');
                              }
                            }
                            isLoading = false;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "already have an account?  ",
                          style: TextStyle(color: Colors.white),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Login ",
                            style: TextStyle(color: Color(0xff96AEC6)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> registerUser() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}
