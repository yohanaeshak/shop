import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool isGridView = true;

  // Updated list of image paths for the grid/list view
  final List<String> imagePaths = [
    'images/assets/image1.jpg',
    'images/assets/image2.jpg',
    'images/assets/image3.jpg',
    'images/assets/image4.jpg',
    'images/assets/image5.jpg',
    'images/assets/image6.jpg',
    'images/assets/image7.jpg',
    'images/assets/image8.jpg',
    'images/assets/image9.jpg',
    'images/assets/image10.jpg',
    'images/assets/image12.jpg',
    'images/assets/image13.jpg',
    'images/assets/image14.jpg',
    'images/assets/image15.jpg',
    'images/assets/image16.jpg',
    'images/assets/image17.jpg',
    'images/assets/image18.jpg',
    'images/assets/image19.jpg',
    'images/assets/image20.jpg',
    'images/assets/image21.jpg',
    'images/assets/image23.jpg',
    'images/assets/image14.jpg',
    'images/assets/image25.jpg',
    'images/assets/image26.jpg',
    'images/assets/image27.jpg',
  ];

  List<Map<String, dynamic>> cartItems = [];  // Track cart items

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Women's Tops"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: Column(
        children: [
          // Horizontal Category List
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              children: [
                _buildCategoryItem("T-Shirts"),
                _buildCategoryItem("Crop Tops"),
                _buildCategoryItem("Blouses"),
              ],
            ),
          ),
          // Sort and Filter Row
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Price: Lowest to High"),
                IconButton(
                  icon: Icon(isGridView ? Icons.grid_view : Icons.list),
                  onPressed: () {
                    setState(() {
                      isGridView = !isGridView;
                    });
                  },
                ),
              ],
            ),
          ),
          // Product Display
          Expanded(
            child: isGridView
                ? GridView.builder(
              padding: EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.75,
              ),
              itemCount: imagePaths.length,
              itemBuilder: (context, index) {
                return _buildProductCard(imagePaths[index]);
              },
            )
                : ListView.builder(
              padding: EdgeInsets.all(8.0),
              itemCount: imagePaths.length,
              itemBuilder: (context, index) {
                return _buildProductCard(imagePaths[index]);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag), label: 'Shop'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Bag'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorites'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: 'Profile'),
          // Added Checkout Icon
          BottomNavigationBarItem(
              icon: Icon(Icons.check_circle), label: 'Checkout'),
        ],
        currentIndex: 1,
        onTap: (index) {
          if (index == 5) {
            // Navigate to checkout page if checkout is tapped
            _navigateToCheckout(context);
          }
        },
      ),
    );
  }

  // Method to handle product addition to cart
  void _addToCart(String imagePath) {
    setState(() {
      cartItems.add({
        'imagePath': imagePath,
        'name': 'Product', // Placeholder, you can customize
        'price': 20.0, // Example price
      });
    });
  }

  // Method to navigate to Checkout Page
  void _navigateToCheckout(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CheckoutPage(cartItems: cartItems)),
    );
  }

  Widget _buildCategoryItem(String title) {
    return GestureDetector(
      onTap: () {
        print("$title selected");
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        margin: EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }

  Widget _buildProductCard(String imagePath) {
    return GestureDetector(
      onTap: () {
        _addToCart(imagePath);
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(
                  imagePath,
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Text(
                      '-20%',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Blouse', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Dorothy Perkins', style: TextStyle(fontSize: 12)),
                  Row(
                    children: [
                      Icon(Icons.star, size: 16, color: Colors.orange),
                      Icon(Icons.star, size: 16, color: Colors.orange),
                      Icon(Icons.star, size: 16, color: Colors.orange),
                      Icon(Icons.star_border, size: 16),
                      Icon(Icons.star_border, size: 16),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$15',
                        style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        '\$12',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CheckoutPage extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems;

  CheckoutPage({required this.cartItems});

  @override
  Widget build(BuildContext context) {
    double totalAmount = cartItems.fold(0.0, (sum, item) => sum + item['price']);

    return Scaffold(
      appBar: AppBar(
        title: Text("Checkout"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Cart',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ...cartItems.map((product) {
              return ListTile(
                title: Text(product['name']),
                trailing: Text('\$${product['price'].toStringAsFixed(2)}'),
              );
            }).toList(),
            SizedBox(height: 16),
            Divider(),
            SizedBox(height: 8),
            Text(
              'Total: \$${totalAmount.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Order Confirmed')));
              },
              child: Text('Proceed to Checkout'),
            ),
          ],
        ),
      ),
    );
  }
}
