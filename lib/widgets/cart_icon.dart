import 'package:cart_app/pages/cart_page.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cart_app/cubit/cart_cubit.dart';

class IconCart extends StatefulWidget {
  const IconCart({
    super.key,
  });

  @override
  State<IconCart> createState() => _IconCartState();
}

class _IconCartState extends State<IconCart> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CartPage(),
          ),
        );
      },
      icon: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartInitial) {
            return const Icon(Icons.shopping_cart_outlined);
          } else if (state is CartProducts) {
            final products = state.products;
            if (products.isEmpty) {
              return const Icon(Icons.shopping_cart_outlined);
            } else {
              return Stack(
                children: [
                  const Icon(Icons.shopping_cart_rounded),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.red,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        '${products.length}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              );
            }
          }
          return Container();
        },
      ),
    );
  }
}
