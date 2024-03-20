import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfileMax extends StatefulWidget {
  const ProfileMax({Key? key}) : super(key: key);

  @override
  State<ProfileMax> createState() => _ProfileMaxState();
}

class _ProfileMaxState extends State<ProfileMax> {
  int _cartItemsCount = 0;

  void addToCart() {
    setState(() {
      _cartItemsCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Hide the status bar by default
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent, // Make the status bar transparent
      ),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CartPage(cartItemsCount: _cartItemsCount),
              ),
            );
          },
          child: Icon(Icons.shopping_cart),
        ),
        body: SingleChildScrollView(
          child: Container(
            color: Color.fromRGBO(
                245, 221, 219, 1), // Set background color to yellow
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 0,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromRGBO(223, 143, 146, 1),
                            Color.fromRGBO(245, 221, 219, 1), // Start color
                            // End color
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 16,
                      left: 16,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          // Handle back button click
                        },
                      ),
                    ),
                    Positioned(
                      top: 16,
                      right: 16,
                      child: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          // Handle search button click
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Marketplace',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Koulen',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductPage(
                              productId: index.toString(),
                              addToCart: addToCart,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromRGBO(223, 143, 146, 1),
                              Color.fromRGBO(245, 221, 219, 1), // Start color
                              // End color
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/images/melo.jpeg',
                              width: double.infinity,
                              height: 120,
                              fit: BoxFit.cover,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Products'),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class QuantityButton extends StatefulWidget {
  @override
  _QuantityButtonState createState() => _QuantityButtonState();
}

class _QuantityButtonState extends State<QuantityButton> {
  int _quantity = 0;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        setState(() {
          if (_quantity == 0) {
            _quantity = 1;
          }
        });
      },
      child: _quantity == 0
          ? Text('Add')
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (_quantity > 1) {
                        _quantity--;
                      } else {
                        _quantity = 0;
                      }
                    });
                  },
                  icon: Icon(Icons.remove),
                ),
                Text(_quantity.toString()),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _quantity++;
                    });
                  },
                  icon: Icon(Icons.add),
                ),
              ],
            ),
    );
  }
}

class ProductPage extends StatelessWidget {
  final String productId;
  final VoidCallback addToCart;

  const ProductPage({
    Key? key,
    required this.productId,
    required this.addToCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product $productId'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Product $productId details'),
            SizedBox(height: 20),
            QuantityButton(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: addToCart,
              child: Text('Add to Cart'),
            ),
          ],
        ),
      ),
    );
  }
}

class CartPage extends StatelessWidget {
  final int cartItemsCount;

  const CartPage({super.key, required this.cartItemsCount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.grey[800],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              "My Cart",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Empty cart message
          if (cartItemsCount == 0)
            Expanded(
              child: Center(
                child: Text(
                  "Your cart is empty.",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),

          // Placeholder for cart items
          if (cartItemsCount > 0)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: ListView.builder(
                  itemCount: cartItemsCount,
                  padding: EdgeInsets.all(12),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListTile(
                          leading: Image.network(
                            'https://via.placeholder.com/50', // Placeholder image URL
                            height: 36,
                          ),
                          title: Text(
                            'Product ${index + 1}',
                            style: const TextStyle(fontSize: 18),
                          ),
                          subtitle: Text(
                            '\$${(index + 1) * 10}',
                            style: const TextStyle(fontSize: 12),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.cancel),
                            onPressed: () {
                              // Remove item from cart
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

          if (cartItemsCount > 0)
            Padding(
              padding: const EdgeInsets.all(36.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.green,
                ),
                padding: const EdgeInsets.all(24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Price',
                          style: TextStyle(color: Colors.green[200]),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '\$${cartItemsCount * 10}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green.shade200),
                        borderRadius: BorderRadius.circular(28),
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: const [
                          Text(
                            'Pay Now',
                            style: TextStyle(color: Colors.white),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }
}
