import 'package:flutter/material.dart';
import 'package:service_marketplace/app/asset_paths.dart';
import 'package:service_marketplace/home/ui/widgets/bottom_nav.dart';
import 'package:service_marketplace/home/ui/widgets/category_grid.dart';
import 'package:service_marketplace/home/ui/widgets/header.dart';
import 'package:service_marketplace/home/ui/widgets/promo_banner.dart';
import 'package:service_marketplace/home/ui/widgets/provider_profiles.dart';
import 'package:service_marketplace/home/ui/widgets/service_cards.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    ValueNotifier<int> currentSlider = ValueNotifier(0);
    return Scaffold(
      body: Column(
        children: [
          CustomHeader(),
          SizedBox(height: 8),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CategoryListView(),
                  Divider(height: 40, thickness: 8, color: Colors.grey.shade300),
                  ServiceCardListView(),
                  Divider(height: 40, thickness: 8, color: Colors.grey.shade300),
                  HomeCarouselSlider(currentSlider: currentSlider),
                  Divider(height: 40, thickness: 8, color: Colors.grey.shade300),
                  ServiceProviderCard(),
                  Divider(height: 40, thickness: 8, color: Colors.grey.shade300),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          AssetPaths.jobPost,
                          height: 100,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          "Post a Job",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          "Didn't find what you’re looking for?",
                          style: TextStyle(fontSize: 13, color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: const Text("Post a Job"),
                          ),
                        ),
                      ],
                    ),
                  )


                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: MainBottomNavBar(),
    );
  }
}




