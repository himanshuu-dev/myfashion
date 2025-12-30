import 'package:ecommerce/utils/widgets/diamond_divider.dart';
import 'package:ecommerce/utils/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class WishlistScreen extends ConsumerStatefulWidget {
  const WishlistScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<WishlistScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: true,
            title: Column(
              children: [
                Text(
                  'My Wishlist'.toUpperCase(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Gap(4),
                const DiamondDivider(),
              ],
            ),
            floating: true,
            snap: true,
            pinned: false,
          ),
          SliverGap(16),
          SliverGrid.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 2,
              crossAxisSpacing: 2,
              crossAxisCount: 2,
              childAspectRatio: 0.6,
            ),
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return ProductCard(
                thumbnailAspectRatio: 0.8,
                isFromWishlist: true,
              );
            },
          ),
          SliverGap(kBottomNavigationBarHeight + 32),
        ],
      ),
    );
  }
}
