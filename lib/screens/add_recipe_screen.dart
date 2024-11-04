import 'package:flutter/material.dart';
import '../models/recipe.dart';

class AddRecipeScreen extends StatefulWidget {
  final Function(Recipe) onAddRecipe;

  AddRecipeScreen({required this.onAddRecipe});

  @override
  _AddRecipeScreenState createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final ingredientsController = TextEditingController();

  void submit() {
    final title = titleController.text;
    final description = descriptionController.text;
    final ingredients = ingredientsController.text.split(',');

    if (title.isEmpty || description.isEmpty || ingredients.isEmpty) {
      return; // You can add validation here
    }

    final recipe = Recipe(
      id: DateTime.now().toString(),
      title: title,
      description: description,
      ingredients: ingredients,
    );

    widget.onAddRecipe(recipe);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Recipe')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: ingredientsController,
              decoration: InputDecoration(labelText: 'Ingredients (comma-separated)'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: submit,
              child: Text('Add Recipe'),
            ),
          ],
        ),
      ),
    );
  }
}
