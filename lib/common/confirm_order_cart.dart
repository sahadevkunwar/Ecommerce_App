import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../features/cart/ui/cart_page.dart';

class SuccessfulDialog extends StatelessWidget {
  const SuccessfulDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.blueGrey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          const Text('Order created successfully'),
          const SizedBox(height: 15),
          TextButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    PageTransition(
                        child: const CartPage(), type: PageTransitionType.fade),
                    (route) => false);
              },
              child: const Text('OK'))
        ],
      ),
    );
  }
}
