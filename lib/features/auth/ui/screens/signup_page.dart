import 'package:ecommerce_project/features/auth/cubit/signup_cubit.dart';
import 'package:ecommerce_project/features/auth/resources/user_repository.dart';
import 'package:ecommerce_project/features/auth/ui/widgets/signup_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SignupCubit(userRepository: context.read<UserRepository>()),
      child: const SignupWidget(),
    );
  }
}
