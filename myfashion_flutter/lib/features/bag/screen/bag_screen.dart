import 'package:ecommerce/main.dart';
import 'package:ecommerce/utils/widgets/diamond_divider.dart';
import 'package:ecommerce/utils/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:myfashion_backend_client/myfashion_backend_client.dart';

class BagScreen extends ConsumerStatefulWidget {
  const BagScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MenuScreenState();
}

class _MenuScreenState extends ConsumerState<BagScreen> {
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
                  'My Bag'.toUpperCase(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Gap(4),
                const DiamondDivider(),
              ],
            ),
            floating: true,
            snap: true,
            pinned: true,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(48),
              child: FilledButton(
                style: ButtonStyle(
                  minimumSize: WidgetStatePropertyAll(Size.fromHeight(45)),
                ),
                onPressed: () async {
                  try {
                     Recipe recipe = await client.recipe.generateRecipe('Nuts');
                     print(recipe);
                    // final result = await client.example.greet('Himanshu');
                    // final result2 = await client.example.abuse('Shruti');
                    // final result3 = await client.example.love('Himanshu');
                    // print(result);
                    // print(result2);
                    // print(result3);
                  } catch (e, s) {
                    print(e);
                    print(s);
                  }
                },
                child: Text('Continue To Checkout'.toUpperCase()),
              ),
            ),
          ),

          SliverGap(16),
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 2,
              crossAxisCount: 1,
              childAspectRatio: 2,
            ),
            delegate: SliverChildBuilderDelegate((
              BuildContext context,
              int index,
            ) {
              return const ProductCard(
                thumbnailAspectRatio: 0.8,
                showProductImage: true,
                isFromBag: true,
              );
            }, childCount: 20),
          ),
          SliverGap(kBottomNavigationBarHeight + 32),
        ],
      ),
    );
  }
}
