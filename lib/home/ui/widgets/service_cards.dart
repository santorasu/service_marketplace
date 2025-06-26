import 'package:flutter/material.dart';
import 'package:service_marketplace/app/asset_paths.dart';

class ServiceCardListView extends StatelessWidget {
  const ServiceCardListView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 340,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: 5,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          return Container(
            width: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image and Heart Icon
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                      child: Image.asset(
                        AssetPaths.demo,
                        height: 160,
                        width: 250,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(Icons.favorite_border, color: Colors.black),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Rating and Tag
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.orange, size: 16),
                          SizedBox(width: 4),
                          Text(
                            "4.5",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 6),
                          Text(
                            "· 1 hr · Painting",
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      // Title
                      Text(
                        'Home Cleaning Services at Miami, FL',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 8),
                      // Price
                      Row(
                        children: [
                          Text(
                            '\$199',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            '\$248',
                            style: TextStyle(
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ),
                      Divider(height: 20),
                      // Author
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 12,
                            backgroundImage: AssetImage(AssetPaths.demo),
                          ),
                          SizedBox(width: 6),
                          Text('Robert Fox', style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
