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

  final Map<String, IconData> categoryIcons = {
    "Electronics": Icons.devices_other_rounded,
    "Jewelery": Icons.diamond_outlined,
    "Men's Clothing": Icons.man_rounded,
    "Women's Clothing": Icons.woman_rounded,
  };

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemBuilder: (context, index) {
          final category = categories[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: InkWell(
              onTap: () {
                print("Tapped on ${category.name}");
              },
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF2A4BA0), Color(0xFF153075)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        categoryIcons[category.name],
                        size: 32,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Text(
                        category.name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          height: 1.2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
