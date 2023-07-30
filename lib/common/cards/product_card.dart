import 'package:ecommerce_project/features/homepage/ui/screens/produc_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../features/homepage/model/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {
          ///here code of navigation of details page
          Navigator.of(context).push(PageTransition(
              child: ProductDetailScreen(productId: product.id),
              type: PageTransitionType.fade));
        },
        child: Material(
          elevation: 1,
          borderRadius: BorderRadius.circular(12),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      product.image,
                      height: 220,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 12, bottom: 0),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      product.name,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      product.brand,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 12),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Rs.${product.price}",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
