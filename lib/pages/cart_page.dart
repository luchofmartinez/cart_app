import 'dart:developer';

import 'package:cart_app/cubit/cart_cubit.dart';
import 'package:cart_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double total = 0.0;

  @override
  Widget build(BuildContext context) {
    final cartCubit = context.read<CartCubit>().cart;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi carrito'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartCubit.length,
              itemBuilder: (context, index) {
                return CartItem(product: cartCubit[index]);
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total:',
                  style: TextStyle(fontSize: 20.0),
                ),
                Text(
                  '\$${context.read<CartCubit>().getTotal().toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 20.0),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Checkout'),
          ),
        ],
      ),
    );
  }
}
