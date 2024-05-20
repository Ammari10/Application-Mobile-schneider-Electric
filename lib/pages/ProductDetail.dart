import 'package:flutter/material.dart';


// Classe pour stocker les détails des produits
class ProductDetail {
  final String name;
  final String description;
  final double price;

  ProductDetail({required this.name, required this.description, required this.price});
}

// Page de détail des produits
class ProductDetailPage extends StatelessWidget {
  final ProductDetail product;

  ProductDetailPage({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Name: ${product.name}'),
            Text('Description: ${product.description}'),
            Text('Price: \$${product.price.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }
}

// Page principale avec la liste des produits
class HomePage extends StatelessWidget {
  final List<ProductDetail> products = [
    ProductDetail(
      name: 'cccc',
      description: 'A product for automation purposes.',
      price: 60,
    ),
    ProductDetail(
      name: 'Product Y',
      description: 'A versatile product with multiple functionalities.',
      price: 149.99,
    ),
    // Ajoutez d'autres produits selon vos besoins
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(products[index].name),
            subtitle: Text('\$${products[index].price.toStringAsFixed(2)}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailPage(product: products[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HomePage(), // Utilise HomePage comme point d'entrée
  ));
}


