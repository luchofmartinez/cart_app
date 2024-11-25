import 'package:cart_app/cubit/carrito_cubit.dart';
import 'package:cart_app/pages/cart_page.dart';
import 'package:flutter/material.dart';

import 'package:cart_app/cubit/cart_cubit.dart';
import 'package:cart_app/pages/pages.dart';
import 'package:cart_app/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider<CartCubit>(
        //   create: (context) => CartCubit(),
        // ),
        BlocProvider(
          create: (context) => CarritoCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        theme: ThemeData(colorSchemeSeed: Colors.cyan, useMaterial3: true),
        home: HomePage(),
      ),
    );
  }
}
