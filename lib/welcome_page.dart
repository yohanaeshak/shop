import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Catalog',
      home: WelcomePage(),
    );
  }
}

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  int _selectedIndex = 0;
  List<String> cartItems = [];
  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages.addAll([
      HomeScreen(onAddToCart: addToCart), // الصفحة الرئيسية
      ShopScreen(),                       // صفحة المتجر
      CheckoutScreen(cartItems: cartItems), // صفحة الدفع
    ]);
  }

  void addToCart(String product) {
    setState(() {
      cartItems.add(product);
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
        backgroundColor: Colors.deepPurple,
      ),
      body: _pages[_selectedIndex], // عرض الصفحة بناءً على الزر المحدد
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            label: 'Checkout',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple,
        onTap: _onItemTapped,
      ),
    );
  }
}

// صفحة "Home" مع إمكانية إضافة المنتجات للسلة وعرضها في Grid أو List
class HomeScreen extends StatefulWidget {
  final Function(String) onAddToCart;

  HomeScreen({required this.onAddToCart});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isGridView = false; // لتحديد ما إذا كنا في GridView أم ListView

  // قائمة المنتجات مع الصور والأسعار
  final List<Map<String, String>> products = [
    {
      'name': 'Product 1',
      'image': 'images/image1.jpg',
      'price': '20',
    },
    {
      'name': 'Product 2',
      'image': 'images/image2.jpg',
      'price': '40',
    },
    {
      'name': 'Product 3',
      'image': 'images/image3.jpg',
      'price': '60',
    },
    {
      'name': 'Product 4',
      'image': 'images/image4.jpg',
      'price': '80',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Welcome to the Home Page!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
        ),
        // زر لتبديل بين ListView و GridView
        ElevatedButton(
          onPressed: () {
            setState(() {
              isGridView = !isGridView;
            });
          },
          child: Text(isGridView ? 'Switch to List View' : 'Switch to Grid View'),
        ),
        // عرض المنتجات إما في GridView أو ListView بناءً على isGridView
        Expanded(
          child: isGridView
              ? GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // عدد الأعمدة في الشبكة
              crossAxisSpacing: 10, // المسافة بين الأعمدة
              mainAxisSpacing: 10, // المسافة بين الصفوف
            ),
            itemCount: products.length, // عدد المنتجات
            itemBuilder: (context, index) {
              final product = products[index];
              return Card(
                elevation: 4,
                child: GridTile(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(product['image']!, width: 80, height: 80, fit: BoxFit.cover),
                      Text(product['name']!),
                      Text('Price: \$${product['price']}'),
                      ElevatedButton(
                        onPressed: () {
                          widget.onAddToCart(product['name']!);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Added ${product['name']} to Cart'),
                            ),
                          );
                        },
                        child: Text('Add to Cart'),
                      ),
                    ],
                  ),
                ),
              );
            },
          )
              : ListView.builder(
            itemCount: products.length, // عدد المنتجات
            itemBuilder: (context, index) {
              final product = products[index];
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  leading: Image.asset(product['image']!, width: 50, height: 50, fit: BoxFit.cover),
                  title: Text(product['name']!),
                  subtitle: Text('Price: \$${product['price']}'),
                  trailing: ElevatedButton(
                    onPressed: () {
                      widget.onAddToCart(product['name']!);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Added ${product['name']} to Cart'),
                        ),
                      );
                    },
                    child: Text('Add to Cart'),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

// صفحة "Shop"
class ShopScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Welcome to the Shop!',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.deepPurple,
        ),
      ),
    );
  }
}

// صفحة "Checkout" التي تعرض المنتجات في السلة
class CheckoutScreen extends StatelessWidget {
  final List<String> cartItems;

  // تعريف قائمة المنتجات مع الأسعار
  final List<Map<String, dynamic>> products = [
    {
      'name': 'Product 1',
      'price': 20.0,
    },
    {
      'name': 'Product 2',
      'price': 40.0,
    },
    {
      'name': 'Product 3',
      'price': 60.0,
    },
    {
      'name': 'Product 4',
      'price': 80.0,
    },
  ];

  CheckoutScreen({required this.cartItems});

  // دالة لحساب المجموع الكلي بناءً على المنتجات في السلة
  double calculateTotal() {
    double total = 0;
    for (var item in cartItems) {
      final product = products.firstWhere((product) => product['name'] == item);
      total += product['price'];  // إضافة السعر للمجموع الكلي
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    double total = calculateTotal();  // حساب المجموع الكلي
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Checkout Page',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
        ),
        // عرض المنتجات التي تمت إضافتها إلى السلة
        Expanded(
          child: cartItems.isEmpty
              ? Center(
            child: Text(
              'No items in the cart',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          )
              : ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(Icons.shopping_bag),
                title: Text(cartItems[index]),
              );
            },
          ),
        ),
        // عرض العدد الإجمالي والمجموع الكلي
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'Total items: ${cartItems.length}',  // عرض عدد العناصر في السلة
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.deepPurple,
                ),
              ),
              Text(
                'Total: \$${total.toStringAsFixed(2)}',  // عرض المجموع الكلي
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // هنا يمكنك إضافة منطق الدفع
                },
                child: Text('Proceed to Payment'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
