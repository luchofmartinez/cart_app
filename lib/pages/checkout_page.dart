import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cart_app/cubit/carrito_cubit.dart';
import 'package:cart_app/services/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
                'Por favor verificar los detalles antes de realizar el pago. Todos los pagos no son reembolsables.'),
            const SizedBox(height: 16),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade200,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        'Resumen del pedido',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: ListView.separated(
                          separatorBuilder: (context, index) => const Divider(),
                          itemCount: context.watch<CarritoCubit>().state.length,
                          itemBuilder: (context, index) {
                            final product =
                                context.watch<CarritoCubit>().state[index];
                            return ListTile(
                              minTileHeight: 10,
                              leading: Text('${product['quantity']}x'),
                              title: Text(
                                product['product'].description,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              trailing: Text(
                                '\$${product['product'].price}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total: \$${context.watch<CarritoCubit>().getTotal().toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                FilledButton(
                  onPressed: () async {
                    // Add your onPressed logic here
                    final preferencia = await MercadoPagoAPI.crearPreferencia(
                        context.read<CarritoCubit>().state);

                    // final preferencia2 =
                    //     await MercadoPagoAPI.crearPreferencia2({
                    //   "items": context.read<CarritoCubit>().state.map((item) {
                    //     final product = item['product'];
                    //     return {
                    //       "title": product.description,
                    //       "quantity": item['quantity'],
                    //       "unit_price": product.price,
                    //     };
                    //   }).toList(),
                    //   "back_urls": {
                    //     "success": "https://example.com/checkout/success",
                    //     "failure": "https://example.com/checkout/failure",
                    //     "pending": "https://example.com/checkout/pending",
                    //   },
                    // });

                    log(preferencia["sandbox_init_point"]);

                    await launchUrl(
                      Uri.parse(preferencia["sandbox_init_point"]),
                      mode: LaunchMode.inAppBrowserView,
                    );
                  },
                  child: const Text('Continuar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
