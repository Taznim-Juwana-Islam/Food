import 'package:flutter/material.dart';
import 'theme_preferences.dart';
import 'food_item.dart';
import 'package:flutter/material.dart';
import 'theme_preferences.dart';
import 'food_item.dart';  // Correct import for FoodItem model

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final theme = await ThemePreferences.getThemePreference();
  runApp(MyApp(initialTheme: theme));
}

class MyApp extends StatelessWidget {
  final String? initialTheme;

  MyApp({this.initialTheme});

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = initialTheme == 'dark';

    return MaterialApp(
      title: 'Theme Preferences App',
      theme: isDarkTheme ? ThemeData.dark() : ThemeData.light(),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isDarkTheme = false;

  final List<FoodItem> foodItems = [
    FoodItem(name: 'Pizza', description: 'Delicious cheese and pepperoni pizza', price: 8.99),
    FoodItem(name: 'Burger', description: 'Juicy beef burger with fresh toppings', price: 5.99),
    FoodItem(name: 'Pasta', description: 'Creamy Alfredo pasta with chicken', price: 7.49),
    FoodItem(name: 'Salad', description: 'Fresh garden salad with vinaigrette', price: 4.99),
  ];

  @override
  void initState() {
    super.initState();
    _loadThemePreference();
  }

  _loadThemePreference() async {
    final theme = await ThemePreferences.getThemePreference();
    setState(() {
      _isDarkTheme = theme == 'dark';
    });
  }

  void _toggleTheme() {
    setState(() {
      _isDarkTheme = !_isDarkTheme;
    });
    ThemePreferences.saveThemePreference(_isDarkTheme ? 'dark' : 'light');
  }

  void _navigateToDetailPage(FoodItem foodItem) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FoodDetailPage(foodItem: foodItem),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Menu'),
        actions: [
          IconButton(
            icon: Icon(_isDarkTheme ? Icons.light_mode : Icons.dark_mode),
            onPressed: _toggleTheme,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: foodItems.length,
        itemBuilder: (context, index) {
          final foodItem = foodItems[index];
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(foodItem.name),
              subtitle: Text(foodItem.description),
              trailing: Text('\$${foodItem.price.toStringAsFixed(2)}'),
              onTap: () => _navigateToDetailPage(foodItem),
            ),
          );
        },
      ),
    );
  }
}

class FoodDetailPage extends StatelessWidget {
  final FoodItem foodItem;

  FoodDetailPage({required this.foodItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(foodItem.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              foodItem.name,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              foodItem.description,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Price: \$${foodItem.price.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add your order functionality here
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text('Order Confirmation'),
                    content: Text('You ordered ${foodItem.name}.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('OK'),
                      ),
                    ],
                  ),
                );
              },
              child: Text('Order Now'),
            ),
          ],
        ),
      ),
    );
  }
}
