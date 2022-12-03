import 'package:flutter/material.dart';
import 'package:style_trace_back_frontend/widgets/layer1/product_card_widgets/product_info.dart';

class ProductCard extends StatelessWidget {
  final String brand;
  final String category;
  final String description;
  final String onlinePrice;
  final String storePrice;
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
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.96,
        height: MediaQuery.of(context).size.width * 0.3,
        child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: InkWell(
                autofocus: false,
                onTap: () {},
                child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(imagePath,
                                height:
                                    MediaQuery.of(context).size.width * 0.24,
                                width: MediaQuery.of(context).size.width * 0.24,
                                fit: BoxFit.cover)),
                        Expanded(
                            flex: 7,
                            child: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: ProductInfo(
                                    brand: brand,
                                    category: category,
                                    description: description,
                                    onlinePrice: onlinePrice,
                                    storePrice: storePrice)))
                      ],
                    )))));
  }
}
