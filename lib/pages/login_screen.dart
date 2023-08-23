import 'package:chat/pages/chat_page.dart';
import 'package:chat/pages/cubits/cubit_login/login_cubit.dart';
import 'package:chat/pages/cubits/cubit_login/login_state.dart';
import 'package:chat/pages/register_screen.dart';
import 'package:chat/widget/buttom.dart';
import 'package:chat/const/colors.dart';
import 'package:chat/widget/text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../helper/snackpar_show.dart';

class LoginPage extends StatelessWidget {
  static String id = 'LoginPage';
  String? email, password;
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginSuccess) {
          Navigator.pushNamed(context, ChatPage.id, arguments: email);
          isLoading = false;
        } else if (state is LoginFailure) {
          showMessageToUser(context, state.errorMessage);
          isLoading = false;
        }
      },
      builder:(context, state) =>  ModalProgressHUD(
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
                            'LOGIN',
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
                            text: 'login',
                            onTap: () async {
                              if (formKey.currentState!.validate()) {
                                BlocProvider.of<LoginCubit>(context).loginUser(
                                    email: email!, password: password!);
                              }
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
                            "don't have an account?  ",
                            style: TextStyle(color: Colors.white),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, RegisterPage.id);
                            },
                            child: const Text(
                              "Register ",
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
      ),
    );
  }

  Future<void> loginUser() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
