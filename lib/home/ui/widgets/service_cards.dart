import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:service_marketplace/app/asset_paths.dart';

class ServiceCardListView extends StatefulWidget {
  const ServiceCardListView({super.key});

  @override
  State<ServiceCardListView> createState() => _ServiceCardListViewState();
}

class _ServiceCardListViewState extends State<ServiceCardListView> {
  List serviceList = [];
  bool isLoading = true;
  String? errorMessage;

  Future<void> fetchServices() async {
    try {
      final response = await http.get(
        Uri.parse('https://prohandy.xgenious.com/api/v1/service/featured'),
      );

      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        setState(() {
          serviceList = decodedData['all_services'] ?? [];
          isLoading = false;
          errorMessage = null;
        });
      } else {
        setState(() {
          isLoading = false;
          errorMessage = 'Failed to load services: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Error: $e';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchServices();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const SizedBox(
        height: 340,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (errorMessage != null) {
      return SizedBox(
        height: 340,
        child: Center(
          child: Text(
            errorMessage!,
            style: const TextStyle(color: Colors.red),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    if (serviceList.isEmpty) {
      return const SizedBox(
        height: 340,
        child: Center(child: Text('No services found')),
      );
    }

    return SizedBox(
      height: 340,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: serviceList.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final service = serviceList[index];
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
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                      child: Image.network(
                        service['image'] ?? '',
                        height: 160,
                        width: 250,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            AssetPaths.demo,
                            height: 160,
                            width: 250,
                            fit: BoxFit.cover,
                          );
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            height: 160,
                            width: 250,
                            color: Colors.grey[300],
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        },
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
                    // Featured badge
                    if (service['is_featured'] == 1)
                      Positioned(
                        top: 8,
                        left: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'Featured',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Rating and Category
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.orange, size: 16),
                          SizedBox(width: 4),
                          Text(
                            service['average_rating'] ?? '0.0',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              "· ${service['unit'] ?? 'Service'} · ${service['category']['name'] ?? 'General'}",
                              style: TextStyle(fontSize: 12),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      // Title
                      Text(
                        service['title'] ?? 'Service',
                        style: TextStyle(fontWeight: FontWeight.w600),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8),
                      // Price
                      Row(
                        children: [
                          Text(
                            '\$${service['discount_price'] != null && service['discount_price'] > 0 ? service['discount_price'] : service['price']}',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (service['discount_price'] != null && service['discount_price'] > 0) ...[
                            SizedBox(width: 8),
                            Text(
                              '\$${service['price']}',
                              style: TextStyle(
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ],
                        ],
                      ),
                      Divider(height: 20),
                      // Provider/Admin
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 12,
                            backgroundImage: _getProviderImage(service) != null
                                ? NetworkImage(_getProviderImage(service)!)
                                : AssetImage(AssetPaths.demo) as ImageProvider,
                          ),
                          SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              _getProviderName(service),
                              style: TextStyle(fontSize: 12),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
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

  String _getProviderName(Map<String, dynamic> service) {
    if (service['provider'] != null) {
      return service['provider']['full_name'] ?? 'Provider';
    } else if (service['admin'] != null) {
      return service['admin']['name'] ?? 'Admin';
    }
    return 'Service Provider';
  }

  String? _getProviderImage(Map<String, dynamic> service) {
    if (service['provider'] != null && service['provider']['image'] != null) {
      return service['provider']['image'];
    } else if (service['admin'] != null && service['admin']['image'] != null) {
      return service['admin']['image'];
    }
    return null;
  }
}
