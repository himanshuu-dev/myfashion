import 'package:ecommerce/router/router.dart';
import 'package:ecommerce/utils/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CollectionsHome extends ConsumerStatefulWidget {
  const CollectionsHome({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CollectionsHomeState();
}

class _CollectionsHomeState extends ConsumerState<CollectionsHome> {
  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: 3,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            context.pushNamed(AppRouter.products);
          },
          child: _collectionCard(0.6),
        );
      },
    );
  }

  Widget _collectionCard(double thumbnailRatio) {
    return ColoredBox(
      color: Colors.transparent,
      child: Column(
        children: [
          Image.asset(pickRandomModelImage()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Row(
              spacing: 8,
              children: [
                Expanded(
                  child: Text(
                    'Collection Name'.toUpperCase(),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                Icon(Icons.keyboard_arrow_right),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
