import 'package:ecommerce/utils/widgets/product_card.dart';
import 'package:flutter/material.dart';

class NewArrivalsSection extends StatefulWidget {
  const NewArrivalsSection({super.key});

  @override
  State<NewArrivalsSection> createState() => _NewArrivalsSectionState();
}

class _NewArrivalsSectionState extends State<NewArrivalsSection> {
  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.53,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      itemCount: 4,
      itemBuilder: (context, index) {
        return ProductCard(thumbnailAspectRatio: 0.7, centerContent: true);
      },
    );
  }
}
