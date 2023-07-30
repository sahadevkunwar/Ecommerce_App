import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:ecommerce_project/common/bloc/common_state.dart';
import 'package:ecommerce_project/common/utils/snackbar_utils.dart';
import 'package:ecommerce_project/features/auth/cubit/signup_cubit.dart';
import 'package:ecommerce_project/features/auth/ui/screens/login_page.dart';
import 'package:ecommerce_project/features/auth/ui/widgets/login_signup_widget.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_overlay/loading_overlay.dart';

class SignupWidget extends StatefulWidget {
  const SignupWidget({Key? key}) : super(key: key);

  @override
  State<SignupWidget> createState() => _SignupWidgetState();
}

class _SignupWidgetState extends State<SignupWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  File? profilePicture;
  bool _isLoading = false;

  // bool _isPasswordVisible = false;
  // bool _isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: _isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Signup Page'),
          backgroundColor: Colors.blue,
        ),
        body: BlocListener<SignupCubit, CommonState>(
          listener: (context, state) {
            if (state is CommonLoadingState) {
              setState(() {
                _isLoading = true;
              });
            } else if (state is CommonErrorState) {
              setState(() {
                _isLoading = false;
              });
            }
            if (state is CommonErrorState) {
              SnackbarUtils.showMessage(
                  context: context, message: state.message);
            } else if (state is CommonSuccessState) {
              SnackbarUtils.showMessage(
                  backgroundColor: Colors.green,
                  context: context,
                  message: "User registered successfully");
              Navigator.of(context).pop();
            }
          },
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          DottedBorder(
                            dashPattern: const [6],
                            borderType: BorderType.Circle,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(80),
                                child: SizedBox(
                                  height: 80,
                                  width: 80,
                                  child: profilePicture == null
                                      ? const Icon(Icons.person_2_outlined,
                                          size: 40)
                                      : Image.file(
                                          profilePicture!,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: InkWell(
                              onTap: () async {
                                final imagePicker = ImagePicker();
                                final res = await imagePicker.pickImage(
                                    source: ImageSource.gallery);
                                if (res != null) {
                                  setState(() {
                                    profilePicture = File(res.path);
                                  });
                                }
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle, color: Colors.red),
                                child: const Icon(
                                  Icons.add,
                                  size: 35,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  CustomTextFormField(
                    controller: _nameController,
                    hintText: 'Enter full name',
                    labelText: 'Full Name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Value cannot be empty";
                      }
                      return null;
                    },
                  ),
                  // const Padding(
                  //   padding: EdgeInsets.all(8.0),
                  //   child: Text("Phone Number"),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: TextFormField(
                  //     controller: _phoneController,
                  //     keyboardType: TextInputType.phone,
                  //     textInputAction: TextInputAction.next,
                  //     decoration: const InputDecoration(
                  //       hintText: 'Enter phone number',
                  //       border: OutlineInputBorder(),
                  //     ),
                  //     validator: (value) {
                  //       if (value == null || value.isEmpty) {
                  //         return "Phone number cannot be empty";
                  //       }
                  //       return null;
                  //     },
                  //   ),
                  // ),
                  CustomTextFormField(
                    controller: _phoneController,
                    hintText: 'Enter phone number',
                    labelText: 'Phone Number',
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Phone number cannot be empty";
                      }
                      return null;
                    },
                  ),
                  // const Padding(
                  //   padding: EdgeInsets.all(8.0),
                  //   child: Text(" Address"),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: TextFormField(
                  //     controller: _addressController,
                  //     keyboardType: TextInputType.streetAddress,
                  //     textInputAction: TextInputAction.next,
                  //     decoration: const InputDecoration(
                  //       hintText: 'Enter address',
                  //       border: OutlineInputBorder(),
                  //     ),
                  //     validator: (value) {
                  //       if (value == null || value.isEmpty) {
                  //         return "Value cannot be empty";
                  //       }
                  //       return null;
                  //     },
                  //   ),
                  // ),
                  CustomTextFormField(
                    controller: _addressController,
                    hintText: 'Enter address',
                    labelText: 'Address',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Value cannot be empty";
                      }
                      return null;
                    },
                  ),
                  // const Padding(
                  //   padding: EdgeInsets.all(8.0),
                  //   child: Text("Email"),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: TextFormField(
                  //     controller: _emailController,
                  //     keyboardType: TextInputType.emailAddress,
                  //     textInputAction: TextInputAction.next,
                  //     decoration: const InputDecoration(
                  //       hintText: 'Enter email',
                  //       border: OutlineInputBorder(),
                  //     ),
                  //     validator: (value) {
                  //       if (value == null || value.isEmpty) {
                  //         return "Value cannot be empty";
                  //       }
                  //       return null;
                  //     },
                  //   ),
                  // ),
                  CustomTextFormField(
                    controller: _emailController,
                    hintText: 'Enter email',
                    labelText: 'Email',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Value cannot be empty";
                      }
                      final isValid = EmailValidator.validate(value);
                      if (isValid) {
                        return null;
                      } else {
                        return "Enter valid email address";
                      }
                    },
                  ),
                  CustomTextFormField(
                    controller: _passwordController,
                    hintText: 'Enter password',
                    labelText: 'Password',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Value cannot be empty";
                      } else if (value.length < 6) {
                        return "password must be at least 6 character long";
                      } else {
                        return null;
                      }
                    },
                  ),
                  CustomTextFormField(
                    controller: _confirmPasswordController,
                    hintText: 'Enter confirm password update',
                    labelText: 'Confirm password',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Value cannot be empty";
                      } else if (value.length < 6) {
                        return "password must be at least 6 character longr";
                      } else if (value != _passwordController.text) {
                        return "Password does not match";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<SignupCubit>().signUp(
                              name: _nameController.text,
                              phone: _phoneController.text,
                              address: _addressController.text,
                              email: _emailController.text,
                              password: _passwordController.text,
                              profile: profilePicture,
                            );
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
                            "SIGNUP",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
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
                            text: "Sign In",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const LoginPage()));
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
