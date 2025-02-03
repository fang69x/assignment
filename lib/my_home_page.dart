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
  int _currentCarouselIndex = 0;
  final Color _primaryColor = const Color(0xFF2A4BA0);
  final Color _accentColor = const Color(0xFFFFC83A);

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
        title: const Text(
          "E-Commerce App",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: IconButton(
              icon: const Icon(Icons.search, color: Colors.white),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Carousel Section
                CarouselSlider(
                  options: CarouselOptions(
                    height: 250, // Increased height for better visibility
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    enlargeCenterPage: true,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.9,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentCarouselIndex = index;
                      });
                    },
                  ),
                  items: [1, 2, 3, 4, 5].map((i) {
                    return Container(
                      margin: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          // Image with gradient overlay
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                image: NetworkImage(
                                    'https://picsum.photos/800/400?random=$i'),
                                fit: BoxFit.cover,
                              ),
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.black.withOpacity(0.6),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                          // Text content
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'New Collection $i',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Discover the latest trends in fashion',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.9),
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blueAccent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 25, vertical: 12),
                                        elevation: 3,
                                      ),
                                      onPressed: () {},
                                      child: const Text(
                                        'Shop Now',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),

// Custom indicator
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [1, 2, 3, 4, 5].asMap().entries.map((entry) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: _currentCarouselIndex == entry.key ? 20 : 8,
                      height: 8,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: _currentCarouselIndex == entry.key
                            ? Colors.blueAccent
                            : Colors.white.withOpacity(0.7),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 10),
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
                            : Colors.grey,
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
                      const Text(
                        'Categories',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Row(
                          children: const [
                            Text(
                              'More',
                              style: TextStyle(color: Color(0xFF2A4BA0)),
                            ),
                            Icon(Icons.chevron_right, color: Color(0xFF2A4BA0)),
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
                      const Text(
                        'Top Deals',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Row(
                          children: const [
                            Text(
                              'More',
                              style: TextStyle(color: Color(0xFF2A4BA0)),
                            ),
                            Icon(Icons.chevron_right, color: Color(0xFF2A4BA0)),
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
                      return const Center(
                        child:
                            CircularProgressIndicator(color: Color(0xFF2A4BA0)),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Column(
                          children: const [
                            Icon(Icons.error, color: Colors.red, size: 40),
                            SizedBox(height: 10),
                            Text(
                              'Failed to load products',
                              style: TextStyle(color: Colors.red),
                            ),
                          ],
                        ),
                      );
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text(
                          'No products available',
                          style: TextStyle(color: Colors.grey),
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
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
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
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
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
