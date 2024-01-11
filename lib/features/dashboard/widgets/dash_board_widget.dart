import 'package:ecommerce_project/common/services/notification_services.dart';

import 'package:ecommerce_project/features/auth/resources/user_repository.dart';
import 'package:ecommerce_project/features/homepage/cubit/fetch_product_cubit.dart';
import 'package:ecommerce_project/features/homepage/cubit/fetch_product_event.dart';

import 'package:ecommerce_project/features/homepage/ui/screens/add_product_screen.dart';

import 'package:ecommerce_project/features/orders/ui/screen/order_screen.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:page_transition/page_transition.dart';

import '../../auth/ui/screens/login_page.dart';

import '../../cart/ui/cart_page.dart';

import '../../homepage/ui/screens/homepage_screen.dart';

class DashBoardWidget extends StatefulWidget {
  const DashBoardWidget({super.key});

  @override
  State<DashBoardWidget> createState() => _DashBoardWidgetState();
}

class _DashBoardWidgetState extends State<DashBoardWidget> {
  final PageController _pageController = PageController();
  final TextEditingController _searchController = TextEditingController();

  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
    context
        .read<FetchProductCubit>()
        .add(FetchProductEvent(query: _searchController.text));
  }

  void searchData(BuildContext context) {
    context
        .read<FetchProductCubit>()
        .add(FetchProductEvent(query: _searchController.text));
  }

  @override
  Widget build(BuildContext context) {
    // final userRepo = context.read<UserRepository>();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              const Text("Ecom",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
              const SizedBox(
                  width:
                      4), // Add some space between the title and the search field
              Container(
                width: 158, // Set the desired width
                height: 50, // Set the desired height
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey), // Add a border
                  color: Colors.white, // Set the background color to white
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: TextField(
                    onSubmitted: (_) => searchData(context),
                    textInputAction: TextInputAction.search,
                    controller: _searchController,
                    style: const TextStyle(fontSize: 14.0, color: Colors.black),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search...',
                      hintStyle: const TextStyle(color: Colors.grey),
                      // suffixIcon: Icon(Icons.search, color: Colors.grey),
                      suffixIcon: IconButton(
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            searchData(context);
                          },
                          icon: const Icon(Icons.search, color: Colors.grey)),
                    ),
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.blue,
          // centerTitle: true,
          // title: const Text("E-commerce"),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  PageTransition(
                      child: const AddProductScreen(),
                      type: PageTransitionType.fade),
                );
              },
              icon: const Icon(Icons.add),
              iconSize: 30,
              tooltip: 'Add product',
            ),
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
          children: [
            HomePageScreen(searchController: _searchController),
            const CartPage(),
            const OrderScreen(),
          ],
        ),
      ),
    );
  }
}
