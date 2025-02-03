import 'package:assignment/core/model/category_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class FlipkartCategoriesSlider extends StatelessWidget {
  final List<Category> categories;

  const FlipkartCategoriesSlider({Key? key, required this.categories})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: categories.length,
      options: CarouselOptions(
        height: 150,
        enlargeCenterPage: true, // Enlarges the center item
        enableInfiniteScroll: false,
        viewportFraction: 0.3, // Each item takes ~30% of the screen width
      ),
      itemBuilder: (context, index, realIndex) {
        final category = categories[index];
        return GestureDetector(
          onTap: () {
            // Handle category tap, e.g., navigate to category details.
            print("Tapped on ${category.name}");
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Card-like container for a nicer look (similar to Flipkart)
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(10),
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey[200],
                ),
              ),
              SizedBox(height: 8),
              Text(
                category.name,
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        );
      },
    );
  }
}
