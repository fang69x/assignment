import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class EcommerceBannerSlider extends StatefulWidget {
  final Color primaryColor;
  final Color bgColor;
  final Color accentColor;
  final Color textColor;

  const EcommerceBannerSlider({
    super.key,
    required this.primaryColor,
    required this.bgColor,
    required this.accentColor,
    required this.textColor,
  });

  @override
  State<EcommerceBannerSlider> createState() => _EcommerceBannerSliderState();
}

class _EcommerceBannerSliderState extends State<EcommerceBannerSlider> {
  int _currentCarouselIndex = 0;
  final List<Map<String, dynamic>> _banners = [
    {'image': 'assets/posters/1.jpg'},
    {'image': 'assets/posters/2.jpg'},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 200,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 5),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            aspectRatio: 16 / 2,
            viewportFraction: 0.85,
            initialPage: 0,
            enableInfiniteScroll: true,
            scrollDirection: Axis.horizontal,
            onPageChanged: (index, reason) {
              setState(() {
                _currentCarouselIndex = index;
              });
            },
          ),
          items: _banners.map((banner) {
            return _buildBannerItem(banner);
          }).toList(),
        ),
        const SizedBox(height: 10),
        _buildPageIndicator(),
      ],
    );
  }

  Widget _buildBannerItem(Map<String, dynamic> banner) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: widget.textColor.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [
            Image.asset(
              banner['image'],
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.7),
                      Colors.transparent,
                    ],
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15,
                ),
                // You can add additional overlay content here if needed
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_banners.length, (index) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          width: _currentCarouselIndex == index ? 24 : 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: _currentCarouselIndex == index
                ? widget.primaryColor
                : widget.primaryColor.withOpacity(0.3),
          ),
        );
      }),
    );
  }
}
