import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cart_app/models/products.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final List<Product> cart = [];
  final List<Map<String, dynamic>> checkout = [];

  CartCubit() : super(CartInitial());

  void addProduct(Product product) {
    bool exists =
        cart.any((element) => element.description == product.description);
    if (!exists) {
      cart.add(product);
      checkout.add({
        // 'productId': product.id,
        // 'product': product.description,
        // 'productPrice': product.price,
        'product': product.toJson(),
        'quantity': 1,
      });
      emit(CartProducts(cart));
    }
  }

  void modifyQuantity(Product product, int quantity) {
    for (var element in checkout) {
      for (var entries in element.entries) {
        if (entries.key == 'product') {
          Product p = Product.fromJson(entries.value);
          if (p.id == product.id) {
            element['quantity'] = quantity;
          }
        }
      }
    }
  }

  int getQuantity(Product product) {
    for (var element in checkout) {
      for (var entries in element.entries) {
        if (entries.key == 'product') {
          Product p = Product.fromJson(entries.value);
          if (p.id == product.id) {
            return element['quantity'];
          }
        }
      }
    }

    return 1;
  }

  double getTotal() {
    double total = 0.0;
    for (var element in checkout) {
      for (var entries in element.entries) {
        if (entries.key == 'product') {
          Product p = Product.fromJson(entries.value);
          final qty = element['quantity'];
          total += p.price * qty;
        }
      }
    }
    return total;
  }
}
