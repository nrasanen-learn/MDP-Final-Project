import 'package:flutter/material.dart';
import 'package:pantry_pro/providers/pantry_provider.dart';
import 'package:pantry_pro/widgets/add_pantry_item_dialog.dart';
import 'package:pantry_pro/widgets/pantry_list_item.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pantryProvider = Provider.of<PantryProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pantry'),
      ),
      body: pantryProvider.items.isEmpty
          ? const Center(
              child: Text('Your pantry is empty. Add some items!'),
            )
          : ListView.builder(
              itemCount: pantryProvider.items.length,
              itemBuilder: (context, index) {
                final item = pantryProvider.items[index];
                return PantryListItem(
                  key: ValueKey(item.name),
                  item: item,
                  onDelete: () {
                    pantryProvider.removeItem(item.name);
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => const AddPantryItemDialog(),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
