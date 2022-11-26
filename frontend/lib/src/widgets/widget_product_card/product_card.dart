import 'package:flutter/material.dart';
import 'package:styletraceback/src/widgets/widget_product_card/product_info.dart';
import 'package:transparent_image/transparent_image.dart';

class ProductCard extends StatelessWidget {
  final String brand;
  final String category;
  final String description;
  final double onlinePrice;
  final double storePrice;
  final String imagePath;
  const ProductCard(
      {super.key,
      required this.brand,
      required this.category,
      required this.description,
      required this.onlinePrice,
      required this.storePrice,
      required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: InkWell(
            autofocus: false,
            onTap: () {},
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    FadeInImage.memoryNetwork(
                      image: imagePath,
                      placeholder: kTransparentImage,
                    ),
                    ProductInfo(
                        brand: brand,
                        category: category,
                        description: description,
                        onlinePrice: onlinePrice,
                        storePrice: storePrice)
                  ],
                ))));
  }
}
