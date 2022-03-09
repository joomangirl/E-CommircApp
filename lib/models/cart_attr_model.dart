// @dart=2.9

import 'package:flutter/cupertino.dart';

class CartAttr {
  final String id;
  final String productId;
  final String title;
  final double price;
  final String imageUrl;
  final String brand;
  final String category;
  final String description;
  final int quantity;

  CartAttr({
    this.id,
    @required this.productId,
    this.title,
    this.price,
    this.imageUrl,
    this.quantity,
    this.description,
    this.category,
    this.brand,
  });
}
