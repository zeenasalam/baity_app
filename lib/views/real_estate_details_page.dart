import 'package:flutter/material.dart';
import '../models/realestate.dart';
class RealEstateDetailsPage extends StatelessWidget {
  final RealEstateModel realEstate;
  const RealEstateDetailsPage({super.key, required this.realEstate});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(realEstate.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(realEstate.ownerImageUrl),
              ),
            ),
            const SizedBox(height: 20),
            _buildDetailRow('Owner', realEstate.ownerName),
            _buildDetailRow('City', realEstate.city.name),
            _buildDetailRow('District', realEstate.district ?? 'N/A'),
            _buildDetailRow('Category', realEstate.category.name),
            _buildDetailRow('Offer Type', realEstate.offerType),
            _buildDetailRow('Price', '${realEstate.price} IQD'),
            _buildDetailRow('Area', '${realEstate.area} m²'),
            _buildDetailRow('Rooms', realEstate.noOfRooms?.toString() ?? 'N/A'),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}