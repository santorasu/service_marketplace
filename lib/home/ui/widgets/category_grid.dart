import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:service_marketplace/app/asset_paths.dart';


class CategoryListView extends StatefulWidget {
  const CategoryListView({
    super.key,
  });

  @override
  State<CategoryListView> createState() => _CategoryListViewState();
}

class _CategoryListViewState extends State<CategoryListView> {

  List categoryList = [];
  bool isLoading = true;
  String? errorMessage;

  Future<void> fetchCategory() async {
    try {
      final response = await http.get(
        Uri.parse('https://prohandy.xgenious.com/api/v1/categories'),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        setState(() {
          categoryList = decodedData['categories'] ?? [];
          isLoading = false;
          errorMessage = null;
        });
      } else {
        setState(() {
          isLoading = false;
          errorMessage = 'Failed to load Category: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Error: $e';
      });
      print('Error fetching Category: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCategory();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const SizedBox(
        height: 150,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (errorMessage != null) {
      return SizedBox(
        height: 150,
        child: Center(
          child: Text(
            errorMessage!,
            style: const TextStyle(color: Colors.red),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    if (categoryList.isEmpty) {
      return const SizedBox(
        height: 150,
        child: Center(child: Text('No providers found')),
      );
    }

    return SizedBox(
      height: 100,
      child: ListView.separated(
        itemCount: categoryList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final category = categoryList[index];
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
                Text(category['name'], style: TextStyle(fontSize: 12)),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 8),

      ),
    );
  }
}