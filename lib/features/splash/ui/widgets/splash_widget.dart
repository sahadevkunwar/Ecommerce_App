import 'package:ecommerce_project/common/bloc/common_state.dart';
import 'package:ecommerce_project/common/services/notification_services.dart';
import 'package:ecommerce_project/features/dashboard/screens/dash_board_screen.dart';
import 'package:ecommerce_project/features/splash/cubit/startup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import '../../../auth/ui/screens/login_page.dart';

class SplashWidget extends StatefulWidget {
  const SplashWidget({Key? key}) : super(key: key);

  @override
  State<SplashWidget> createState() => _SplashWidgetState();
}

class _SplashWidgetState extends State<SplashWidget> {
  @override
  void initState() {
    super.initState();
    LocalNotificationService().initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<StartUpCubit, CommonState>(
        listener: (context, state) {
          if (state is CommonSuccessState<({bool isLoggedIn})>) {
            if (state.item.isLoggedIn) {
              Navigator.of(context).pushAndRemoveUntil(
                  PageTransition(
                      child: const DashBoardScreen(),
                      type: PageTransitionType.fade),
                  (route) => false);
            } else {
              Navigator.of(context).pushAndRemoveUntil(
                  PageTransition(
                      child: const LoginPage(), type: PageTransitionType.fade),
                  (route) => false);
            }
          }
        },
        child: const Center(
            child: Text(
          'Ecommerce',
          style: TextStyle(
            fontSize: 30,
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        )),
      ),
    );
  }
}
