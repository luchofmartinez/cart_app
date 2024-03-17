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
  bool isGridViewSelected = true;
  bool isListViewSelected = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              tooltip: 'Grilla',
              onPressed: () {
                setState(() {
                  isGridViewSelected = true;
                  isListViewSelected = false;
                });
              },
              icon: const Icon(Icons.grid_on_rounded),
              isSelected: isGridViewSelected,
            ),
            IconButton(
              tooltip: 'Lista',
              isSelected: isListViewSelected,
              onPressed: () {
                setState(() {
                  isGridViewSelected = false;
                  isListViewSelected = true;
                });
              },
              icon: const Icon(Icons.list),
            ),
          ],
        ),
        Container(
          child: isListViewSelected
              ? const ProductListView()
              : const ProductGridView(),
        )
      ],
    );
  }
}
