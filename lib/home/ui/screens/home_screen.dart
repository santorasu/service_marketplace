import 'package:flutter/material.dart';
import 'package:service_marketplace/app/asset_paths.dart';
import 'package:service_marketplace/home/ui/widgets/bottom_nav.dart';
import 'package:service_marketplace/home/ui/widgets/category_grid.dart';
import 'package:service_marketplace/home/ui/widgets/header.dart';
import 'package:service_marketplace/home/ui/widgets/job_post.dart';
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
                  JobPost(),
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

