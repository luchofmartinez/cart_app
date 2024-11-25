import 'package:cached_network_image/cached_network_image.dart';
import 'package:cart_app/cubit/carrito_cubit.dart';
import 'package:cart_app/cubit/cart_cubit.dart';
import 'package:cart_app/models/products.dart';
import 'package:cart_app/pages/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.description)),
      body: Column(
        children: [
          Card(
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(10)),
                  child: CachedNetworkImage(
                    imageUrl: product.image,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            CircularProgressIndicator(
                                value: downloadProgress.progress),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text('Precio: \$${product.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                      const SizedBox(height: 4),

                      // BlocBuilder<CarritoCubit, List<Map<String, dynamic>>>(
                      //   builder: (context, state) {
                      //     int quantity =
                      //         context.read<CarritoCubit>().getQuantity(product);
                      //     return Row(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       children: [
                      //         IconButton(
                      //           onPressed: () {
                      //             if (quantity > 1) {
                      //               context
                      //                   .read<CarritoCubit>()
                      //                   .modifyQuantity(product, quantity - 1);
                      //             }
                      //           },
                      //           icon: const Icon(Icons.remove),
                      //         ),
                      //         Text(
                      //           '$quantity',
                      //           style: const TextStyle(fontSize: 20),
                      //         ),
                      //         IconButton(
                      //           onPressed: () => context
                      //               .read<CarritoCubit>()
                      //               .modifyQuantity(product, quantity + 1),
                      //           icon: const Icon(Icons.add),
                      //         ),
                      //       ],
                      //     );
                      //   },
                      // ),
                    ],
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: FilledButton(
                      onPressed: () {
                        context.read<CarritoCubit>().addProduct(product);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                '${product.description} agregado al carrito'),
                          ),
                        );
                      },
                      child: const Text('Agregar al carrito'),
                    ),
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
