import 'package:chat/helper/snackpar_show.dart';
import 'package:chat/pages/chat_page.dart';
import 'package:chat/pages/cubits/cubit_register/register_cubit.dart';
import 'package:chat/pages/cubits/cubit_register/register_state.dart';
import 'package:chat/widget/buttom.dart';
import 'package:chat/const/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../widget/text_form_field.dart';

class RegisterPage extends StatelessWidget {
  String? email;

  String? password;
  static String id = 'RegisterPage';

  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          isLoading = true;
        } else if (state is RegisterSuccess) {
          Navigator.pushNamed(context, ChatPage.id, arguments: email);
          isLoading = false;
        } else if (state is RegisterFailure) {
          showMessageToUser(context, state.errorMessage);
          isLoading = false;
        }
      },
      builder: (context, state) {
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
                                  BlocProvider.of<RegisterCubit>(context)
                                      .registerUser(
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
      },
    );
  }

 
}
