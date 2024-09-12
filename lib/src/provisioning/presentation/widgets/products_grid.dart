import 'package:flutter/material.dart';

import '../../../../core/res/colours.dart';
import '../../domain/entities/product.dart';

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({
    super.key,
    required this.index,
    required this.onTap,
    required this.products,
  });

  final int index;

  // onTap
  final Function() onTap;
  // products
  final List<Product?> products;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(3, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                products[index]!.image!,
                width: 90,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              products[index]!.name,
              style: const TextStyle(
                color: Colours.primaryColour,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'Rp. ${products[index]!.price}',
              style: const TextStyle(
                color: Colours.primaryColour,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
