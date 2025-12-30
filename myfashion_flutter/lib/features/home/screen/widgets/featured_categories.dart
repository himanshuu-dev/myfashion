import 'package:ecommerce/router/router.dart';
import 'package:ecommerce/utils/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FeaturedCategoriesHome extends ConsumerStatefulWidget {
  const FeaturedCategoriesHome({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FeaturedCategoriesHomeState();
}

class _FeaturedCategoriesHomeState
    extends ConsumerState<FeaturedCategoriesHome> {
  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.48,
      ),
      itemCount: 4,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            context.pushNamed(AppRouter.products);
          },
          child: _categoryCard(0.58),
        );
      },
    );
  }

  Widget _categoryCard(double thumbnailRatio) {
    return ColoredBox(
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: thumbnailRatio,
            child: Image.asset(pickRandomModelImage(), fit: BoxFit.cover),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Category'.toUpperCase(),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    'Explore'.toUpperCase(),
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
