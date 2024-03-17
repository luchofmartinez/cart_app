import 'package:flutter/material.dart';

import 'package:cart_app/models/product_list.dart';

class ProductListView extends StatelessWidget {
  const ProductListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: productos.length,
        itemBuilder: (context, index) => ListTile(
          onTap: () {},
          leading: CircleAvatar(
              backgroundImage: NetworkImage(productos[index].image)),
          title: Text(productos[index].description),
          trailing: Text('\$${productos[index].price.toStringAsFixed(2)}'),
        ),
      ),
    );
  }
}
