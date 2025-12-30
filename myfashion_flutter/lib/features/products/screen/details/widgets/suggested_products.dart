import 'package:ecommerce/utils/widgets/diamond_divider.dart';
import 'package:ecommerce/utils/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SuggestedProducts extends StatelessWidget {
  const SuggestedProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'You may also like'.toUpperCase(),
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Gap(4),
        DiamondDivider(),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.53,
            crossAxisSpacing: 1,
            mainAxisSpacing: 1,
          ),
          itemCount: 6,
          itemBuilder: (context, index) {
            return ProductCard(thumbnailAspectRatio: 0.7, centerContent: false);
          },
        ),
      ],
    );
  }
}
