import 'package:flutter/material.dart';

import 'package:shoe_store/shared/extensions/extensions.dart';

class ReviewItemWidget extends StatelessWidget {
  final String username;
  final String comment;
  final String createdAt; // ví dụ: "2025-03-19"
  final int rating;

  const ReviewItemWidget({
    super.key,
    required this.username,
    required this.comment,
    required this.createdAt,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      decoration: BoxDecoration(
        color: context.colors.dimGrey,
        border: Border.all(color: context.colors.dimGrey),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row: Username + Date + Rating
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Username + Date
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      username,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      DateTime.parse(createdAt).format('dd/MM/yyyy'),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              // Rating
              Row(
                children: List.generate(
                  5,
                  (index) => Icon(
                    Icons.star,
                    size: 16,
                    color: index < rating ? Colors.amber : Colors.grey[300],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Comment
          Text(
            comment,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
