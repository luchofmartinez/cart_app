// crear clase MercadoPagoAPI, donde la URL base es "https://api.mercadopago.com", el auth type es Bearer
// y el token es "APP_USER_TOKEN". Crear tambien un metodo CrearPreferencia donde la peticion es un POST a /checkout/preferences

import 'dart:developer';

import 'package:dio/dio.dart';

class MercadoPagoAPI {
  static const String baseUrl = 'https://api.mercadopago.com';
  static const String authType = 'Bearer';
  static const String token =
      'APP_USR-1062916901411423-112417-f6cb7490d0632d201e6433e9139b8cf4-2114410385';

  static Future<Map<String, dynamic>> crearPreferencia(
      List<Map<String, dynamic>> data) async {
    final dio = Dio();
    dio.options.baseUrl = baseUrl;
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': '$authType $token',
    };

    final items = data
        .map((item) => {
              'id': item['product'].id,
              'title': item['product'].description,
              'currency_id': 'ARS',
              'description': item['product'].description,
              'quantity': item['quantity'],
              'unit_price': item['product'].price,
            })
        .toList();

    log('items: $items');

    final body = {
      "back_urls": {
        "success": "https://www.success.com",
        "failure": "https://www.failure.com",
        "pending": "https://www.pending.com"
      },
      "auto_return": "approved",
      "items": items,
      "payer": {
        "name": "Juan",
        "surname": "Lopez",
        "email": "user@email.com",
        "phone": {"area_code": "351", "number": "5575239"},
        "identification": {"type": "DNI", "number": "12345678"},
        "address": {
          "street_name": "Street",
          "street_number": 123,
          "zip_code": "5009"
        }
      },
      "payment_methods": {
        "excluded_payment_methods": [
          {"id": "amex"},
          {"id": "argencard"},
          {"id": "cabal"},
          {"id": "cmr"},
          {"id": "cencosud"},
          {"id": "cordobesa"},
          {"id": "diners"},
          {"id": "tarshop"}
        ],
        "excluded_payment_types": [
          {"id": "ticket"},
          {"id": "debit_card"}
        ],
        "installments": 12
      },
    };

    final response = await dio.post('/checkout/preferences', data: body);

    if (response.statusCode == 201) {
      return response.data;
    } else {
      throw Exception('Failed to create preference');
    }
  }

  static Future<Map<String, dynamic>> crearPreferencia2(
      Map<String, dynamic> data) async {
    final dio = Dio();
    dio.options.baseUrl = baseUrl;
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': '$authType $token',
    };

    final body = {
      'items': [],
      "payment_methods": {
        "excluded_payment_methods": [
          {"id": "amex"},
          {"id": "argencard"},
          {"id": "cabal"},
          {"id": "cmr"},
          {"id": "cencosud"},
          {"id": "cordobesa"},
          {"id": "diners"},
          {"id": "tarshop"}
        ],
        "excluded_payment_types": [
          {"id": "ticket"},
          {"id": "debit_card"}
        ],
        "installments": 12
      },
    };

    final response = await dio.post('/checkout/preferences', data: body);

    if (response.statusCode == 201) {
      return response.data;
    } else {
      throw Exception('Failed to create preference');
    }
  }
}
