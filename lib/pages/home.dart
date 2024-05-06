import 'package:flutter/material.dart';

class Item {
  String imgPath;
  String name;
  double price;
  int quantity;

  Item({required this.name, required this.imgPath, required this.price, this.quantity = 1});
}

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Item> allItems = [
    Item(price: 60, name: "cccc", imgPath: "assets/images/sh1.png"),
    Item(price: 50, name: "Pfff", imgPath: "assets/images/sh2.png"),
    Item(price: 70, name: "Pdgf", imgPath: "assets/images/sh3.png"),
    Item(price: 80, name: "gss", imgPath: "assets/images/sh4.png"),
    Item(price: 90, name: "teee", imgPath: "assets/images/sh5.png"),
    Item(price: 75, name: "iiig", imgPath: "assets/images/sh6.png"),
    Item(price: 65, name: "fddd", imgPath: "assets/images/sh7.png"),
    Item(price: 55, name: "uff", imgPath: "assets/images/sh8.png"),
    Item(price: 55, name: "hnnuff", imgPath: "assets/images/sh8.png"),
  ];

  List<Item> displayedItems = [];
  List<Item> cartItems = [];

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    displayedItems.addAll(allItems);
  }

  void filterItems(String query) {
    setState(() {
      if (query.isNotEmpty) {
        displayedItems = allItems
            .where((item) => item.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      } else {
        displayedItems.clear();
        displayedItems.addAll(allItems);
      }
    });
  }

  void addToCart(Item item) {
    bool alreadyInCart = cartItems.any((cartItem) => cartItem.name == item.name);

    if (!alreadyInCart) {
      setState(() {
        cartItems.add(item);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${item.name} added to cart')),
      );
    } else {
      setState(() {
        cartItems[cartItems.indexWhere((cartItem) => cartItem.name == item.name)].quantity++;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Item quantity updated in cart')),
      );
    }
  }

  void removeFromCart(Item item) {
    if (item.quantity > 1) {
      setState(() {
        cartItems[cartItems.indexWhere((cartItem) => cartItem.name == item.name)].quantity--;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Item quantity updated in cart')),
      );
    } else {
      setState(() {
        cartItems.remove(item);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${item.name} removed from cart')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartPage(cartItems: cartItems, removeFromCart: removeFromCart)),
              );
            },
            icon: Icon(Icons.shopping_cart),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/11.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage("assets/images/shryyfa.png"),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Ashraf Ammari",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  Text(
                    "Ammari10@gmail.com",
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.add_shopping_cart),
              title: Text("My Products"),
              onTap: () {
                // Navigate to My Products screen
              },
            ),
            ListTile(
              leading: Icon(Icons.help_center),
              title: Text("About"),
              onTap: () {
                // Navigate to About screen
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Logout"),
              onTap: () {
                // Add logout logic
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: 'Search product',
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: (value) {
              filterItems(value);
            },
          ),
          ElevatedButton(
            onPressed: () {
              filterItems(searchController.text);
            },
            child: Text('Search'),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1,
              ),
              itemCount: displayedItems.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    addToCart(displayedItems[index]);
                  },
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage(displayedItems[index].imgPath),
                        ),
                        SizedBox(height: 8),
                        Text(
                          displayedItems[index].name,
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          "\$${displayedItems[index].price.toStringAsFixed(2)}",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CartPage extends StatelessWidget {
  final List<Item> cartItems;
  final Function(Item) removeFromCart;

  const CartPage({Key? key, required this.cartItems, required this.removeFromCart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double totalPrice = 0;
    for (var item in cartItems) {
      totalPrice += item.price * item.quantity;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: cartItems.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(cartItems[index].imgPath),
                  ),
                  title: Text(cartItems[index].name),
                  subtitle: Text("\$${cartItems[index].price.toStringAsFixed(2)} x ${cartItems[index].quantity}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          removeFromCart(cartItems[index]);
                        },
                      ),
                      
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          cartItems[index].quantity++;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('${cartItems[index].name} Quantity updated in cart')),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
            BottomAppBar(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total: \$${totalPrice.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PaymentPage(cartItems: cartItems)),
                        );
                      },
                      child: Text('Checkout'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentPage extends StatefulWidget {
  final List<Item> cartItems;

  const PaymentPage({Key? key, required this.cartItems}) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expiryController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController billingAddressController = TextEditingController();

  double get totalPrice {
    double total = 0;
    for (var item in widget.cartItems) {
      total += item.price * item.quantity;
    }
    return total;
  }

  void processPayment(BuildContext context) {
    // Placeholder method for processing payment
    // Implement actual payment processing logic here
    // Send payment details to payment gateway API
    print('Payment processed successfully');

    // After successful payment, show a thank you message
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Thank You!"),
          content: Text("Your order has been placed successfully."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.of(context).pop(); // Pop PaymentPage and CartPage
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Total Amount: \$${totalPrice.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: cardNumberController,
              decoration: InputDecoration(labelText: 'Card Number'),
            ),
            TextFormField(
              controller: expiryController,
              decoration: InputDecoration(labelText: 'Expiry Date'),
            ),
            TextFormField(
              controller: cvvController,
              decoration: InputDecoration(labelText: 'CVV'),
            ),
            TextFormField(
              controller: billingAddressController,
              decoration: InputDecoration(labelText: 'Billing Address '),
            ),
              TextFormField(
              controller: cardNumberController,
              decoration: InputDecoration(labelText: 'Phone Number '),
            ),
            
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Validate form data here (e.g., card number, expiry, CVV)
                // For simplicity, validation is not included in this example
                processPayment(context); // Pass context to show dialog
              },
              child: Text('Pay Now'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
} 







