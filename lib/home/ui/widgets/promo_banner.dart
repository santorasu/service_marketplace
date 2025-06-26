import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:service_marketplace/app/asset_paths.dart';

class HomeCarouselSlider extends StatelessWidget {
  const HomeCarouselSlider({
    super.key,
    required ValueNotifier<int> currentSlider,
  }) : _currentSlider = currentSlider;

  final ValueNotifier<int> _currentSlider;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: 180,
              viewportFraction: 0.92,
              enlargeCenterPage: true,
              enableInfiniteScroll: false,
              autoPlay: true,
              onPageChanged: (index, _) {
                _currentSlider.value = index;
              },
            ),
            items: List.generate(5, (index) {
              return Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: SizedBox(
                      width: double.infinity,
                      child: Image.asset(
                        AssetPaths.demo,
                        fit: BoxFit.cover,
                        height: 180,
                      ),
                    ),
                  ),
                  Positioned(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Get your roofs cleaned",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              "Don't let your mind stick to\nthe ugly roofs.",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: 12),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.yellow,
                                foregroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32),
                                ),
                              ),
                              onPressed: () {},
                              child: Text("Get Started"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
          SizedBox(height: 8),
          ValueListenableBuilder(
            valueListenable: _currentSlider,
            builder: (context, index, _) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (i) {
                  return Container(
                    width: 8,
                    height: 8,
                    margin: EdgeInsets.only(left: 3),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(8),
                      color: index == i ? Colors.blue : Colors.white,
                    ),
                  );
                }),
              );
            },
          ),
        ],
      ),
    );
  }
}
