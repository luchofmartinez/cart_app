import 'package:cart_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
        itemBuilder: (context, index) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).cardColor,
          ),
          child: ListTile(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ProductItem(product: productos[index]),
              ));
            },
            leading: CircleAvatar(
              backgroundImage:
                  CachedNetworkImageProvider(productos[index].image),
            ),
            title: Text(productos[index].description),
            trailing: Text('\$${productos[index].price.toStringAsFixed(2)}'),
          ),
        ),
      ),
    );
  }
}
