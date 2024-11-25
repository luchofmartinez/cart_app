import 'package:cart_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isListViewSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrito App'),
        actions: [
          IconButton(
            tooltip: 'Grilla',
            onPressed: () {
              setState(() {
                isListViewSelected = false;
              });
            },
            icon: const Icon(Icons.grid_on_rounded),
            isSelected: isListViewSelected,
          ),
          IconButton(
            tooltip: 'Lista',
            isSelected: isListViewSelected,
            onPressed: () {
              setState(() {
                isListViewSelected = true;
              });
            },
            icon: const Icon(Icons.list),
          ),
          const IconCart(),
        ],
      ),
      body: const Column(
        children: [
          // Container(
          //   child: isListViewSelected
          //       ? const ProductListView()
          //       : const ProductGridView(),
          // )
          ProductListView(),
        ],
      ),
    );
  }
}
