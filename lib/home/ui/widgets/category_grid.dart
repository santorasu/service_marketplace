import 'package:flutter/material.dart';
import 'package:service_marketplace/app/asset_paths.dart';


class CategoryListView extends StatelessWidget {
  const CategoryListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Column(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Image.asset(
                    AssetPaths.cleaning,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 6),
                Text('Batman', style: TextStyle(fontSize: 12)),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemCount: 10,
      ),
    );
  }
}