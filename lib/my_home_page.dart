import 'package:assignment/api/apifetch.dart';
import 'package:assignment/core/model/category_model.dart';
import 'package:assignment/core/model/product_model.dart';
import 'package:assignment/widgets/flipkartslider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<ProductModel>> _products;
  @override
  void initState() {
    super.initState();
    _products = ApiService().fetchProducts();
  }

  final List<Category> categories = [
    Category(name: "Electronics"),
    Category(name: "Fashion"),
    Category(name: "Home"),
    Category(name: "Books"),
  ];

  List<int> list = [1, 2, 3, 4];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("E-Commerce App"),
        actions: [
          Icon(Icons.search),
        ],
      ),
      body: Center(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CarouselSlider(
                  options: CarouselOptions(height: 400.0),
                  items: [1, 2, 3, 4, 5].map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(color: Colors.amber),
                            child: Text(
                              'text $i',
                              style: TextStyle(fontSize: 16.0),
                            ));
                      },
                    );
                  }).toList(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Categories',
                      style: TextStyle(color: Colors.black),
                    ),
                    Row(
                      children: [
                        Text(
                          'More',
                          style: TextStyle(color: Colors.black),
                        ),
                        Icon(Icons.navigate_next)
                      ],
                    ),
                  ],
                ),
                FlipkartCategoriesSlider(categories: categories),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Top Deals on Electronics',
                      style: TextStyle(color: Colors.black),
                    ),
                    Row(
                      children: [
                        Text(
                          'More',
                          style: TextStyle(color: Colors.black),
                        ),
                        Icon(Icons.navigate_next)
                      ],
                    ),
                  ],
                ),
                Expanded(
                    child: FutureBuilder<List<ProductModel>>(
                        future: _products,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error : ${snapshot.error}'));
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return const Center(
                              child: Text('No products available'),
                            );
                          } else {
                            final products = snapshot.data!;
                            return GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.7,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                ),
                                itemCount: products.length,
                                itemBuilder: (context, index) {
                                  final product = products[index];
                                  return Card(
                                    child: Column(
                                      children: [
                                        Image.network(product.image,
                                            height: 100, width: 100),
                                        Text(product.title),
                                        Text(
                                            '\$${product.price.toStringAsFixed(2)}'),
                                        Text('Rating: ${product.rating.rate}'),
                                      ],
                                    ),
                                  );
                                });
                          }
                        }))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
