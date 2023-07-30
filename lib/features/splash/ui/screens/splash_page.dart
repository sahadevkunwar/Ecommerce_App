import 'package:ecommerce_project/features/auth/resources/user_repository.dart';
import 'package:ecommerce_project/features/splash/cubit/startup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/splash_widget.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StartUpCubit(
        userRepository: context.read<UserRepository>(),
      )..fetchStartUpData(),
      child: const SplashWidget(),
    );
  }
}
