import 'package:cart_app/cubit/cart_cubit.dart';
import 'package:cart_app/pages/pages.dart';
import 'package:cart_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CartCubit>(
      create: (context) => CartCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Carrito App'),
            actions: const [IconCart()],
          ),
          body: const HomePage(),
        ),
      ),
    );
  }
}
