import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:service_marketplace/app/asset_paths.dart';

class ServiceProviderCard extends StatefulWidget {
  ServiceProviderCard({super.key});

  @override
  State<ServiceProviderCard> createState() => _ServiceProviderCardState();
}

class _ServiceProviderCardState extends State<ServiceProviderCard> {
  List providerList = [];
  bool isLoading = true;
  String? errorMessage;

  Future<void> fetchProviders() async {
    try {
      final response = await http.get(
        Uri.parse('https://prohandy.xgenious.com/api/v1/provider-lists'),
      );

      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        setState(() {
          providerList = decodedData['provider_lists'] ?? [];
          isLoading = false;
          errorMessage = null;
        });
      } else {
        setState(() {
          isLoading = false;
          errorMessage = 'Failed to load providers: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Error: $e';
      });
      print('Error fetching providers: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchProviders();
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

    if (providerList.isEmpty) {
      return const SizedBox(
        height: 150,
        child: Center(child: Text('No providers found')),
      );
    }

    return SizedBox(
      height: 150,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: providerList.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final provider = providerList[index];
          return Container(
            width: 140,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: provider['image'] != null
                          ? NetworkImage(provider['image'])
                          : const AssetImage(AssetPaths.demo) as ImageProvider,
                    ),
                    Positioned(
                      bottom: -8,
                      left: 9,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(color: Colors.black12, blurRadius: 4),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.star, color: Colors.orange, size: 14),
                            const SizedBox(width: 2),
                            Text(
                              provider['average_rating'] ?? '0.0',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Text(
                  provider['full_name'] ?? 'Unknown',
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  provider['service_categories']?.isNotEmpty == true
                      ? provider['service_categories'][0]['name']
                      : 'Service Provider',
                  style: const TextStyle(fontSize: 11, color: Colors.grey),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
