import 'package:flutter/material.dart';
import 'package:pantry_pro/providers/pantry_provider.dart';
import 'package:pantry_pro/providers/recipe_provider.dart';
import 'package:pantry_pro/widgets/add_pantry_item_dialog.dart';
import 'package:pantry_pro/widgets/pantry_list_item.dart';
import 'package:pantry_pro/widgets/recipe_list.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.index == 1) {
        final pantryProvider = Provider.of<PantryProvider>(
          context,
          listen: false,
        );
        final recipeProvider = Provider.of<RecipeProvider>(
          context,
          listen: false,
        );
        recipeProvider.generateRecipes(pantryProvider.items);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final pantryProvider = Provider.of<PantryProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pantry Pro'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Pantry'),
            Tab(text: 'Recipes'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          pantryProvider.items.isEmpty
              ? const Center(
                  child: Text('Your pantry is empty. Add some items!'),
                )
              : ListView.builder(
                  itemCount: pantryProvider.items.length,
                  itemBuilder: (context, index) {
                    final item = pantryProvider.items[index];
                    return PantryListItem(
                      key: ValueKey(item.id),
                      item: item,
                      onDelete: () {
                        pantryProvider.removeItem(item.id!);
                      },
                    );
                  },
                ),
          const RecipeList(),
        ],
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
