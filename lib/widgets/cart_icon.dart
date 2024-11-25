import 'package:cart_app/cubit/carrito_cubit.dart';
import 'package:cart_app/models/products.dart';
import 'package:cart_app/pages/cart_page.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class IconCart extends StatefulWidget {
  const IconCart({
    super.key,
  });

  @override
  State<IconCart> createState() => _IconCartState();
}

class _IconCartState extends State<IconCart> {
  void navigateToCart() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CartPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CarritoCubit, List<Map<String, dynamic>>>(
      builder: (context, state) {
        bool isCartEmpty = state.isEmpty;
        return IconButton(
          onPressed: navigateToCart,
          icon: Icon(isCartEmpty
              ? Icons.shopping_cart_outlined
              : Icons.shopping_cart_rounded),
        );
      },
    );
  }
}
