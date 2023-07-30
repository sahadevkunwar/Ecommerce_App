import 'package:ecommerce_project/features/auth/resources/user_repository.dart';
import 'package:ecommerce_project/features/auth/ui/widgets/login_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/login_cubit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              LoginCubit(userRepository: context.read<UserRepository>()),
        ),
        BlocProvider(
          create: (context) =>
              LoginCubit(userRepository: context.read<UserRepository>()),
        ),
      ],
      child: const LoginWidget(),
    );
  }
}
