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
    Item(price: 60, name: "Canalis Ksa 100A", imgPath: "assets/images/A2.png"),
    Item(price: 50, name: "Canalis Ksa 250A", imgPath: "assets/images/A1.png"),
    Item(price: 70, name: "Canalis KSA 400A", imgPath: "assets/images/A1.png"),
    Item(price: 80, name: "Canalis KN 160A", imgPath: "assets/images/A3.png"),
    Item(price: 90, name: "Altivar Process ATV600", imgPath: "assets/images/A4.png"),
    Item(price: 75, name: "Rotating 127V", imgPath: "assets/images/A5.png"),
    Item(price: 65, name: "Easy Harmony XA2", imgPath: "assets/images/A6.png"),
    Item(price: 55, name: "9001K", imgPath: "assets/images/A7.png"),
    Item(price: 55, name: "TeSys F", imgPath: "assets/images/B1.png"),
    Item(price: 55, name: "Ikeos", imgPath: "assets/images/B2.png"),
    Item(price: 55, name: "TeSys LUTM", imgPath: "assets/images/B3.png"),
    Item(price: 55, name: "TeSys B", imgPath: "assets/images/B4.png"),
    Item(price: 55, name: "AccuSine PCS+", imgPath: "assets/images/B5.png"),
  ];

  List<Item> displayedItems = [];
  List<Item> cartItems = [];

  TextEditingController searchController = TextEditingController();
  int cartItemCount = 0;

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
        cartItemCount++;
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
        cartItemCount--;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${item.name} removed from cart')),
      );
    }
  }

  double calculateTotalPriceAll() {
    double total = 0;
    for (var item in allItems) {
      total += item.price;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CartPage(cartItems: cartItems, removeFromCart: removeFromCart)),
                  );
                },
                icon: Icon(Icons.shopping_cart),
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
                  ),
                  child: Text(
                    cartItemCount.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              double totalAll = calculateTotalPriceAll();
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Total Price"),
                    content: Text("Total Price of all items: \$${totalAll.toStringAsFixed(2)}"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("OK"),
                      ),
                    ],
                  );
                },
              );
            },
            child: Text("Total"),
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
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(color: Colors.black45, blurRadius: 8),
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage: AssetImage(displayedItems[index].imgPath),
                          ),
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

class CartPage extends StatefulWidget {
  final List<Item> cartItems;
  final Function(Item) removeFromCart;

  const CartPage({Key? key, required this.cartItems, required this.removeFromCart}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double totalPrice = 0;

  @override
  void initState() {
    super.initState();
    calculateTotalPrice();
  }

  void calculateTotalPrice() {
    totalPrice = 0;
    for (var item in widget.cartItems) {
      totalPrice += item.price * item.quantity;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.cartItems.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(widget.cartItems[index].imgPath),
                  ),
                  title: Text(widget.cartItems[index].name),
                  subtitle: Text("\$${widget.cartItems[index].price.toStringAsFixed(2)} x ${widget.cartItems[index].quantity}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          widget.removeFromCart(widget.cartItems[index]);
                          setState(() {});
                        },
                      ),
                      Text(widget.cartItems[index].quantity.toString()),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            widget.cartItems[index].quantity++;
                            calculateTotalPrice();
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
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
                        MaterialPageRoute(builder: (context) => PaymentPage(cartItems: widget.cartItems)),
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
              decoration: InputDecoration(labelText: 'Billing Address'),
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


















