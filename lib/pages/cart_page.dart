import 'dart:developer';

import 'package:cart_app/cubit/carrito_cubit.dart';
import 'package:cart_app/pages/checkout_page.dart';
import 'package:cart_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi carrito'),
      ),
      body: context.watch<CarritoCubit>().state.isEmpty
          ? const Center(child: Text('El carrito está vacío'))
          : Column(
              children: [
                Expanded(
                  child: BlocBuilder<CarritoCubit, List<Map<String, dynamic>>>(
                    builder: (context, state) {
                      return ListView.builder(
                        itemCount: state.length,
                        itemBuilder: (context, index) {
                          return Dismissible(
                            key: Key(state[index]['product'].id.toString()),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) {
                              context
                                  .read<CarritoCubit>()
                                  .removeProduct(state[index]['product']);
                            },
                            background: Container(
                              color: Colors.red,
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.only(right: 16.0),
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                            child: CartItem(product: state[index]['product']),
                          );
                        },
                      );
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
                        '\$${context.watch<CarritoCubit>().getTotal().toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 20.0),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: FilledButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const CheckoutPage(),
                              ),
                            );
                          },
                          child: const Text('Pagar'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
