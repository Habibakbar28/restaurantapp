import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';

import 'package:restaurant_app/data/model/restaurant_review.dart';
import 'package:restaurant_app/ui/restaurantdetail_page.dart';

class CardReviewRestaurant extends StatelessWidget{
  final ReviewCostumer review;

  CardReviewRestaurant({Key? key, required this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding:
      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Icon(Icons.account_circle),
      ),
      title: Text(review.name),
      subtitle: Text(review.review),
      trailing: Text(review.date),
    );
  }
}