import 'package:cart_app/models/products.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarritoCubit extends Cubit<List<Map<String, dynamic>>> {
  CarritoCubit() : super([]);

  void addProduct(Product product) {
    final existingProduct = state.firstWhere(
      (element) => element['product'].description == product.description,
      orElse: () => {
        'product': Product(id: 0, description: '', price: 0, image: ''),
        'quantity': 0
      },
    );
    if (existingProduct['product'].id == 0) {
      emit([
        ...state,
        {'product': product, 'quantity': 1}
      ]);
    } else {
      final newState = state.map((element) {
        if (element['product'].description == product.description) {
          return {
            'product': element['product'],
            'quantity': element['quantity'] + 1
          };
        }
        return element;
      }).toList();
      emit(newState);
    }
  }

  void modifyQuantity(Product product, int quantity) {
    final newState = state.map((element) {
      if (element['product'].description == product.description) {
        return {
          'product': element['product'],
          'quantity': element['quantity'] + quantity
        };
      }
      return element;
    }).toList();
    emit(newState);
  }

  void removeProduct(Product product) {
    final existingProduct = state.firstWhere(
      (element) => element['product'].description == product.description,
      orElse: () => {
        'product': Product(id: 0, description: '', price: 0, image: ''),
        'quantity': 0
      },
    );
    if (existingProduct['product'].id != 0) {
      if (existingProduct['quantity'] > 1) {
        final newState = state.map((element) {
          if (element['product'].description == product.description) {
            return {
              'product': element['product'],
              'quantity': element['quantity'] - 1
            };
          }
          return element;
        }).toList();
        emit(newState);
      } else {
        emit(state
            .where((element) =>
                element['product'].description != product.description)
            .toList());
      }
    }
  }

  double getTotal() {
    double total = 0.0;
    for (var element in state) {
      total += element['product'].price * element['quantity'];
    }
    return total;
  }

  getQuantity(Product product) {
    for (var element in state) {
      if (element['product'].description == product.description) {
        return element['quantity'];
      }
    }
    return 1;
  }
}
// CarritoCubit() : super(productos);

// void addProduct(Product product) {
//   final existingProduct = state.firstWhere(
//     (element) => element.description == product.description,
//     orElse: () => Product(id: 0, description: '', price: 0, image: ''),
//   );
//   if (existingProduct.id == 0) {
//     emit([...state, product]);
//   } else {
//     final newState = state.map((element) {
//       if (element.description == product.description) {
//         return element.copyWith(quantity: element.quantity + 1);
//       }
//       return element;
//     }).toList();
//     emit(newState);
//   }
// }

// void modifyQuantity(Product product, int quantity) {
//   final newState = state.map((element) {
//     if (element.description == product.description) {
//       return element.copyWith(quantity: quantity);
//     }
//     return element;
//   }).toList();
//   emit(newState);
// }

// void removeProduct(Product product) {
//   final existingProduct = state.firstWhere(
//     (element) => element.description == product.description,
//     orElse: () => Product(id: 0, description: '', price: 0, image: ''),
//   );
//   if (existingProduct.id != 0) {
//     if (existingProduct.quantity > 1) {
//       final newState = state.map((element) {
//         if (element.description == product.description) {
//           return element.copyWith(quantity: element.quantity - 1);
//         }
//         return element;
//       }).toList();
//       emit(newState);
//     } else {
//       emit(state
//           .where((element) => element.description != product.description)
//           .toList());
//     }
//   }
// }

// getTotal() {
//   double total = 0.0;
//   for (var element in state) {
//     total += element.price * element.quantity;
//   }
//   return total;
// }
// }
