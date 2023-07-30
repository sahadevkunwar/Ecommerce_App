import 'package:ecommerce_project/common/services/notification_services.dart';
import 'package:ecommerce_project/features/auth/resources/user_repository.dart';
import 'package:ecommerce_project/features/orders/ui/screen/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import '../../features/auth/ui/screens/login_page.dart';
import '../../features/cart/ui/cart_page.dart';
import '../../features/homepage/ui/screens/homepage_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final userRepo = context.read<UserRepository>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 70,
          leading: userRepo.user != null
              ? Center(
                  child: Container(
                    padding: const EdgeInsets.only(left: 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: Image.network(
                        userRepo.user!.profile,
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
              : null,
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: const Text("E-commerce"),
          actions: [
            IconButton(
                onPressed: () {
                  LocalNotificationService().generateNotification(
                    title: "Notification",
                    description: "Test notification",
                    payload: "from button",
                  );
                },
                icon: const Icon(Icons.notification_add)),
            IconButton(
                onPressed: () {
                  context.read<UserRepository>().logout();
                  Navigator.pushAndRemoveUntil(
                      context,
                      PageTransition(
                          child: const LoginPage(),
                          type: PageTransitionType.fade),
                      (route) => false);
                },
                icon: const Icon(Icons.logout))
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.blue,
          unselectedItemColor: const Color(0xFF868687),
          selectedFontSize: 12,
          unselectedFontSize: 12,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400),
          currentIndex: _currentIndex,
          onTap: (value) {
            setState(() {
              _currentIndex = value;
            });
            _pageController.animateToPage(
              value,
              duration: const Duration(milliseconds: 300),
              curve: Curves.linear,
            );
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Feed'),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart), label: 'Cart'),
            BottomNavigationBarItem(
                icon: Icon(Icons.dashboard), label: 'Orders'),
          ],
        ),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: (value) {
            setState(() {
              _currentIndex = value;
            });
          },
          children: const [
            HomePageScreen(),
            CartPage(),
            OrderScreen(),
          ],
        ),
      ),
    );
  }
}
