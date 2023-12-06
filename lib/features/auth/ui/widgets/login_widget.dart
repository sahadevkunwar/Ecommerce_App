import 'package:ecommerce_project/common/bloc/common_state.dart';

import 'package:ecommerce_project/common/utils/snackbar_utils.dart';

import 'package:ecommerce_project/features/auth/cubit/login_cubit.dart';

import 'package:ecommerce_project/features/auth/cubit/social_login_cubit.dart';

import 'package:ecommerce_project/features/dashboard/screens/home_page.dart';

import 'package:flutter/gestures.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:loading_overlay/loading_overlay.dart';

import 'package:page_transition/page_transition.dart';


import '../../../../common/icons/ecommerce_icons.dart';

import '../screens/signup_page.dart';

import 'login_signup_widget.dart';


class LoginWidget extends StatefulWidget {

  const LoginWidget({Key? key}) : super(key: key);


  @override

  State<LoginWidget> createState() => _LoginWidgetState();

}


class _LoginWidgetState extends State<LoginWidget> {

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isLoading = false;


  @override

  Widget build(BuildContext context) {

    return LoadingOverlay(

      isLoading: _isLoading,

      child: MultiBlocListener(

        listeners: [

          BlocListener<LoginCubit, CommonState>(

            listener: (context, state) {

              if (state is CommonErrorState) {

                setState(() {

                  _isLoading = false;

                });

              } else {

                setState(() {

                  _isLoading = true;

                });

              }

              if (state is CommonSuccessState) {

                SnackbarUtils.showMessage(

                    backgroundColor: Colors.green,

                    context: context,

                    message: "Login successfully");

                Navigator.of(context).pushAndRemoveUntil(

                    PageTransition(

                        child: const HomePage(), type: PageTransitionType.fade),

                    (route) => false);

              } else if (state is CommonErrorState) {

                SnackbarUtils.showMessage(

                    context: context, message: state.message);

              }

            },

          ),

          BlocListener<SocialLoginCubit, CommonState>(

            listener: (context, state) {

              if (state is CommonErrorState) {

                setState(() {

                  _isLoading = false;

                });

              } else {

                setState(() {

                  _isLoading = true;

                });

              }

              if (state is CommonSuccessState) {

                SnackbarUtils.showMessage(

                    backgroundColor: Colors.green,

                    context: context,

                    message: "Login successfully");

                Navigator.of(context).pushAndRemoveUntil(

                    PageTransition(

                        child: const HomePage(), type: PageTransitionType.fade),

                    (route) => false);

              } else if (state is CommonErrorState) {

                SnackbarUtils.showMessage(

                    context: context, message: state.message);

              }

            },

          ),

        ],

        child: Scaffold(

          appBar: AppBar(

            title: const Text('Login Page'),

            backgroundColor: Colors.blue,

          ),

          body: Form(

            key: _formKey,

            child: SingleChildScrollView(

              child: Column(

                children: [

                  // const Padding(

                  //   padding: EdgeInsets.all(8.0),

                  //   child: Text("Email Address"),

                  // ),

                  // Padding(

                  //   padding: const EdgeInsets.all(8.0),

                  //   child: TextFormField(

                  //     textInputAction: TextInputAction.next,

                  //     decoration: const InputDecoration(

                  //       hintText: 'Enter email address',

                  //       border: OutlineInputBorder(),

                  //     ),

                  //   ),

                  // ),

                  CustomTextFormField(

                    controller: _emailController,

                    hintText: 'Enter email address',

                    labelText: 'Email',

                    validator: (value) {

                      if (value == null || value.isEmpty) {

                        return "Please enter email";

                      } else {

                        return null;

                      }

                    },

                  ),

                  CustomTextFormField(

                    controller: _passwordController,

                    hintText: 'Enter password',

                    labelText: 'Password',

                    validator: (value) {

                      if (value == null || value.isEmpty) {

                        return "Please enter password";

                      } else if (value.length < 6) {

                        return "Password field must be greater than 6 character long";

                      } else {

                        return null;

                      }

                    },

                  ),


                  const SizedBox(height: 10),

                  InkWell(

                    onTap: () {

                      if (_formKey.currentState!.validate()) {

                        context.read<LoginCubit>().login(

                            email: _emailController.text,

                            password: _passwordController.text);

                      }

                    },

                    child: Padding(

                      padding: const EdgeInsets.all(8.0),

                      child: Container(

                        decoration: BoxDecoration(

                          borderRadius: BorderRadius.circular(

                              8), // Set the border radius value

                          color: Colors.blue,

                        ),

                        height: 40,

                        width: double.infinity,

                        child: const Center(

                          child: Text(

                            "LOGIN",

                            style: TextStyle(color: Colors.white),

                          ),

                        ),

                      ),

                    ),

                  ),

                  const SizedBox(height: 15),

                  const Divider(thickness: 1),


                  Row(

                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [

                      IconButton(

                        onPressed: () {

                          context.read<SocialLoginCubit>().loginViaGoogle();

                        },

                        icon: const Icon(

                          Ecommerce.google,

                          color: Colors.red,

                        ),

                      ),

                      const SizedBox(width: 20),

                      IconButton(

                        onPressed: () {

                          context.read<SocialLoginCubit>().loginViaFacebook();

                        },

                        icon: const Icon(

                          Ecommerce.facebook,

                          color: Colors.blue,

                        ),

                      ),

                    ],

                  ),

                  const Divider(thickness: 1),

                  const SizedBox(height: 15),

                  Center(

                    child: RichText(

                      text: TextSpan(

                        children: [

                          const TextSpan(

                              text: "Don't have an account?",

                              style: TextStyle(color: Colors.black)),

                          const WidgetSpan(

                            child: Padding(

                              padding: EdgeInsets.symmetric(

                                  horizontal: 6.0), // Add horizontal spacing

                            ),

                          ),

                          TextSpan(

                            text: "Sign Up",

                            style: const TextStyle(

                              fontWeight: FontWeight.bold,

                              color: Colors.blue,

                            ),

                            recognizer: TapGestureRecognizer()

                              ..onTap = () {

                                Navigator.of(context).push(MaterialPageRoute(

                                    builder: (context) => const SignupPage()));

                              },

                          ),

                        ],

                      ),

                    ),

                  ),

                ],

              ),

            ),

          ),

        ),

      ),

    );

  }

}

