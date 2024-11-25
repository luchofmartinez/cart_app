// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:cart_app/models/products.dart';
// import 'package:equatable/equatable.dart';
// import 'package:meta/meta.dart';

// part 'cart_state.dart';

// class CartCubit extends Cubit<CartState> {
//   final List<Product> cart = [];
//   final List<Map<String, dynamic>> checkout = [];

//   CartCubit() : super(CartInitial());

//   void addProduct(Product product) {
//     final existingProduct = cart.firstWhere(
//       (element) => element.description == product.description,
//       orElse: () =>
//           Product(id: 0, description: '', price: 0, image: '', quantity: 0),
//     );
//     if (existingProduct.id == 0) {
//       cart.add(product);
//       checkout.add({
//         'product': product.toJson(),
//         'quantity': product.quantity,
//       });
//     } else {
//       final existingCheckout = checkout.firstWhere(
//         (element) => element['product']['id'] == existingProduct.id,
//         orElse: () => <String, dynamic>{},
//       );
//       existingCheckout['quantity'] = (existingCheckout['quantity'] ?? 0) + 1;
//     }
//     emit(CartProducts(cart));
//   }

//   void deleteProduct(Product product) {
//     bool exists =
//         cart.any((element) => element.description == product.description);
//     if (exists) {
//       cart.removeWhere(
//         (element) => element.id == product.id,
//       );
//       emit(CartProducts(cart));
//     }
//   }

//   void modifyQuantity(Product product, int quantity) {
//     final existingCheckout = checkout.firstWhere(
//       (element) => Product.fromJson(element['product']).id == product.id,
//     );

//     if (existingCheckout != null) {
//       existingCheckout['quantity'] = quantity;
//     }
//   }

//   int getQuantity(Product product) {
//     for (var element in checkout) {
//       for (var entries in element.entries) {
//         if (entries.key == 'product') {
//           Product p = Product.fromJson(entries.value);
//           if (p.id == product.id) {
//             return element['quantity'];
//           }
//         }
//       }
//     }

//     return 1;
//   }

//   double getTotal() {
//     double total = 0.0;
//     for (var element in checkout) {
//       for (var entries in element.entries) {
//         if (entries.key == 'product') {
//           Product p = Product.fromJson(entries.value);
//           final qty = element['quantity'];
//           total += p.price * qty;
//         }
//       }
//     }
//     return total;
//   }
// }
