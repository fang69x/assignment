import 'package:assignment/api/apifetch.dart';
import 'package:assignment/core/model/category_model.dart';
import 'package:assignment/core/model/product_model.dart';
import 'package:assignment/widgets/carousel_slider.dart';
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
  int _currentCarouselIndex = 0;
  final Color _primaryColor = const Color(0xFF3B63A8); // Medium Sapphire
  final Color _accentColor = const Color(0xFF7CB9F2); // Aero
  final Color _bgColor = const Color(0xFFF7F7F7); // White Smoke
  final Color _textColor = const Color(0xFF0C1421); // Eigengrau

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        backgroundColor: _primaryColor,
        title: Text(
          "E-Commerce App",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: _bgColor,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: IconButton(
              icon: Icon(Icons.search, color: _bgColor),
              onPressed: () {},
            ),
          ),
        ],
      ),
      backgroundColor: _bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Carousel Section
                EcommerceBannerSlider(
                  primaryColor: _primaryColor,
                  bgColor: _bgColor,
                  accentColor: _accentColor,
                  textColor: _textColor,
                ),

                // Carousel Indicators
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [0, 1, 2, 3, 4].map((index) {
                    return Container(
                      width: 8.0,
                      height: 8.0,
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentCarouselIndex == index
                            ? _primaryColor
                            : _accentColor.withOpacity(0.3),
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 24),

                // Categories Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Categories',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: _textColor,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Row(
                          children: [
                            Text(
                              'More',
                              style: TextStyle(color: _primaryColor),
                            ),
                            Icon(Icons.chevron_right, color: _primaryColor),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                CategoriesSlider(),

                const SizedBox(height: 24),

                // Products Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Top Deals',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: _textColor,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Row(
                          children: [
                            Text(
                              'More',
                              style: TextStyle(color: _primaryColor),
                            ),
                            Icon(Icons.chevron_right, color: _primaryColor),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                FutureBuilder<List<ProductModel>>(
                  future: _products,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(color: _primaryColor),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Column(
                          children: [
                            Icon(Icons.error, color: Colors.red, size: 40),
                            const SizedBox(height: 10),
                            Text(
                              'Failed to load products',
                              style: TextStyle(color: Colors.red),
                            ),
                          ],
                        ),
                      );
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                        child: Text(
                          'No products available',
                          style: TextStyle(color: _textColor.withOpacity(0.6)),
                        ),
                      );
                    } else {
                      final products = snapshot.data!;
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                        ),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Center(
                                      child: Image.network(
                                        product.image,
                                        fit: BoxFit.contain,
                                        height: 120,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                const Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    product.title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: _textColor,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '\$${product.price.toStringAsFixed(2)}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: _primaryColor,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: _accentColor,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        '${product.rating.rate} (${product.rating.count})',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: _textColor.withOpacity(0.6),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
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
