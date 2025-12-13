import 'package:flutter/material.dart';
import 'package:pantry_pro/providers/pantry_provider.dart';
import 'package:provider/provider.dart';

class ExpiringSoonScreen extends StatelessWidget {
  const ExpiringSoonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pantryProvider = Provider.of<PantryProvider>(context);
    final expiringItems = pantryProvider.expiringSoonItems;

    return Scaffold(
      appBar: AppBar(title: const Text('Expiring Soon')),
      body: expiringItems.isEmpty
          ? const Center(child: Text('No items expiring soon.'))
          : ListView.builder(
              itemCount: expiringItems.length,
              itemBuilder: (context, index) {
                final item = expiringItems[index];
                return ListTile(
                  title: Text(item.name),
                  subtitle: Text(
                    'Expires on: ${item.expirationDate!.toLocal().toString().split(' ')[0]}',
                  ),
                  trailing: Text('${item.quantity} left'),
                );
              },
            ),
    );
  }
}
