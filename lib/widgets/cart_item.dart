import 'package:cart_app/cubit/cart_cubit.dart';
import 'package:cart_app/models/products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartItem extends StatefulWidget {
  final Product product;
  const CartItem({super.key, required this.product});

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  int productQuantity = 1;
  double subtotal = 0.0;

  @override
  void initState() {
    super.initState();
    productQuantity = context.read<CartCubit>().getQuantity(widget.product);
    calculateSubTotal(widget.product.price, productQuantity);
  }

  void calculateSubTotal(double price, int quantity) {
    setState(() {
      subtotal = price * quantity;
    });
  }

  void incrementQuantity() {
    productQuantity++;
    context.read<CartCubit>().modifyQuantity(widget.product, productQuantity);
    calculateSubTotal(widget.product.price, productQuantity);
    setState(() {});
  }

  void decrementQuantity() {
    if (productQuantity <= 0) {
      return;
    }
    productQuantity--;
    context.read<CartCubit>().modifyQuantity(widget.product, productQuantity);
    calculateSubTotal(widget.product.price, productQuantity);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      isThreeLine: true,
      leading: Image.network(widget.product.image),
      title: Text(widget.product.description),
      subtitle: Text('\$${subtotal.toStringAsFixed(2)}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              decrementQuantity();
            },
            icon: const Icon(Icons.remove),
          ),
          Text('$productQuantity'),
          IconButton(
            onPressed: () {
              incrementQuantity();
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
