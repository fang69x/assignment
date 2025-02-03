import 'package:flutter/material.dart';
import 'package:assignment/core/model/category_model.dart';

class CategoriesSlider extends StatelessWidget {
  CategoriesSlider({Key? key}) : super(key: key);

  final List<Category> categories = [
    Category(name: "Electronics"),
    Category(name: "Jewelery"),
    Category(name: "Men's Clothing"),
    Category(name: "Women's Clothing"),
  ];

  // Map categories to their corresponding icons
  final Map<String, IconData> categoryIcons = {
    "Electronics": Icons.devices,
    "Jewelery": Icons.diamond_outlined,
    "Men's Clothing": Icons.male,
    "Women's Clothing": Icons.female,
  };

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GestureDetector(
              onTap: () {
                // TODO: Implement category navigation
                print("Tapped on ${category.name}");
              },
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Icon(
                        categoryIcons[category.name],
                        size: 40,
                        color: const Color(0xFF2A4BA0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    category.name,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
