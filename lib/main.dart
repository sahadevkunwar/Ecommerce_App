import 'dart:async';


import 'package:dio/dio.dart';


import 'package:ecommerce_project/common/interceptor/authentication_interceptor.dart';


import 'package:ecommerce_project/common/wrapper/notification_wrapper.dart';


import 'package:ecommerce_project/features/auth/cubit/social_login_cubit.dart';


import 'package:ecommerce_project/features/auth/resources/user_repository.dart';


import 'package:ecommerce_project/features/cart/resources/cart_repository.dart';


import 'package:ecommerce_project/features/checkout/cubit/create_order_cubit.dart';


import 'package:ecommerce_project/features/homepage/resource/product_repository.dart';


import 'package:ecommerce_project/features/orders/resources/order_repository.dart';


import 'package:ecommerce_project/features/splash/ui/screens/splash_page.dart';


import 'package:firebase_core/firebase_core.dart';


import 'package:firebase_crashlytics/firebase_crashlytics.dart';


import 'package:firebase_messaging/firebase_messaging.dart';


import 'package:flutter/material.dart';


import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:google_fonts/google_fonts.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {}


void main() async {

  runZonedGuarded(() async {

    WidgetsFlutterBinding.ensureInitialized();


    await Firebase.initializeApp();


    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;


    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);


    runApp(const MyApp());

  }, (error, stack) {

    FirebaseCrashlytics.instance.recordError(error, stack);

  });

}


class MyApp extends StatelessWidget {

  const MyApp({super.key});


  // This widget is the root of your application.


  @override

  Widget build(BuildContext context) {

    return MultiRepositoryProvider(

      providers: [

        RepositoryProvider(

          create: (context) => UserRepository(),

        ),

        RepositoryProvider(

          create: (context) => Dio()

            ..interceptors.add(

              AuthInterceptor(

                userRepository: context.read<UserRepository>(),

              ),

            ),

        ),

        RepositoryProvider(

          create: (context) => ProductRepository(
              userRepository: context.read<UserRepository>(),
              dio: context.read<Dio>()),

        ),

        RepositoryProvider(

            create: (context) =>

                CartRepository(userRepository: context.read<UserRepository>())),

        RepositoryProvider(

            create: (context) => OrderRepository(

                userRepository: context.read<UserRepository>())),

      ],

      child: MultiBlocProvider(

        providers: [

          BlocProvider(

            create: (context) => CreateOrderCubit(

                orderRepository: context.read<OrderRepository>()),

          ),

          BlocProvider(

            create: (context) => SocialLoginCubit(

                userRepository: context.read<UserRepository>()),

          ),

        ],

        child: NotificationWrapper(

          child: MaterialApp(

            debugShowCheckedModeBanner: false,

            title: 'Ecommerce App',

            theme: ThemeData(

              //primaryColor: CustomTheme.primaryColor,


              colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),


              useMaterial3: true,


              textTheme: GoogleFonts.poppinsTextTheme(),

            ),

            home: const SplashPage(),

          ),

        ),

      ),

    );

  }

}

