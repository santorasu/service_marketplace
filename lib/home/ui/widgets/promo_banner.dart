import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeCarouselSlider extends StatefulWidget {
  const HomeCarouselSlider({
    super.key,
    required ValueNotifier<int> currentSlider,
  }) : _currentSlider = currentSlider;

  final ValueNotifier<int> _currentSlider;

  @override
  State<HomeCarouselSlider> createState() => _HomeCarouselSliderState();
}

class _HomeCarouselSliderState extends State<HomeCarouselSlider> {
  List sliderList = [];
  bool isLoading = true;

  Future<void> fetchSliders() async {
    final response = await http.get(
      Uri.parse('https://prohandy.xgenious.com/api/v1/slider-lists'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        sliderList = data['sliders'] ?? [];
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchSliders();
  }

  @override
  Widget build(BuildContext context) {
    // Show loading
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    // Show carousel
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Carousel Slider
          CarouselSlider(
            options: CarouselOptions(
              height: 180,
              autoPlay: true,
              onPageChanged: (index, _) {
                widget._currentSlider.value = index;
              },
            ),
            items: sliderList.map((slider) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    slider['image'],
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 10),

          ValueListenableBuilder(
            valueListenable: widget._currentSlider,
            builder: (context, index, _) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: sliderList.map((slider) {
                  int currentIndex = sliderList.indexOf(slider);
                  return Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: index == currentIndex ? Colors.blue : Colors.grey,
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
