import 'package:cart_app/cubit/carrito_cubit.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cart_app/models/products.dart';
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
  }

  Widget calculateSubTotal() {
    final quantity = context.read<CarritoCubit>().getQuantity(widget.product);
    return Text('\$${(widget.product.price * quantity).toStringAsFixed(2)}');
  }

  void incrementQuantity(Product product) {
    context.read<CarritoCubit>().modifyQuantity(product, 1);
  }

  void decrementQuantity(Product product) {
    context.read<CarritoCubit>().modifyQuantity(product, -1);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.teal.shade50,
      ),
      child: ListTile(
        // isThreeLine: true,
        leading: CircleAvatar(
            child: CachedNetworkImage(imageUrl: widget.product.image)),
        title: Text(widget.product.description),
        subtitle: calculateSubTotal(),
        trailing: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.red.shade100,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  decrementQuantity(widget.product);
                },
                icon: const Icon(Icons.remove),
              ),
              Text(
                  '${context.read<CarritoCubit>().getQuantity(widget.product)}'),
              IconButton(
                onPressed: () {
                  incrementQuantity(widget.product);
                },
                icon: const Icon(Icons.add),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
