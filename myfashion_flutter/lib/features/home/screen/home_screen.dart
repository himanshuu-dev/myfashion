import 'package:ecommerce/features/home/screen/widgets/collections.dart';
import 'package:ecommerce/features/home/screen/widgets/featured_categories.dart';
import 'package:ecommerce/features/home/screen/widgets/footer.dart';
import 'package:ecommerce/features/home/screen/widgets/just_for_you.dart';
import 'package:ecommerce/features/home/screen/widgets/new_arrivals.dart';
import 'package:ecommerce/router/router.dart';
import 'package:ecommerce/utils/constants/icons.dart';
import 'package:ecommerce/utils/widgets/diamond_divider.dart';
import 'package:ecommerce/utils/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

enum ShopType { men, women, kids }

List shopTypes = [
  {'type': ShopType.men, 'title': 'Men'},
  {'type': ShopType.women, 'title': 'Women'},
  {'type': ShopType.kids, 'title': 'Kids'},
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ShopType selectedShopType = ShopType.men;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: false,
            title: SvgPicture.asset(AppIcons.logo),
            floating: true,
            snap: true,
            pinned: false,
            actions: [
              MenuAnchor(
                builder:
                    (
                      BuildContext context,
                      MenuController controller,
                      Widget? child,
                    ) {
                      return TextButton.icon(
                        onPressed: () {
                          if (controller.isOpen) {
                            controller.close();
                          } else {
                            controller.open();
                          }
                        },
                        icon: Icon(
                          controller.isOpen ? Icons.remove : Icons.add,
                        ),
                        label: Text(selectedShopType.name.toUpperCase()),
                        iconAlignment: IconAlignment.end,
                      );
                    },
                menuChildren: [
                  for (var item in shopTypes)
                    MenuItemButton(
                      onPressed: () =>
                          setState(() => selectedShopType = item['type']),
                      child: Text(
                        item['title'],
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                ],
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: AspectRatio(
              aspectRatio: 0.75,
              child: SizedBox(
                width: double.infinity,
                child: Image.asset(pickRandomModelImage(), fit: BoxFit.cover),
              ),
            ),
          ),
          SliverGap(22),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Text(
                  'New Arrivals'.toUpperCase(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Gap(4),
                DiamondDivider(),
              ],
            ),
          ),
          SliverGap(16),
          NewArrivalsSection(),
          SliverToBoxAdapter(
            child: TextButton.icon(
              iconAlignment: IconAlignment.end,
              onPressed: () {
                context.pushNamed(AppRouter.products);
              },
              label: Text('Explore More'),
              icon: SvgPicture.asset(AppIcons.forwardArrow),
            ),
          ),
          SliverGap(22),

          SliverToBoxAdapter(
            child: Column(
              children: [
                Text(
                  'Collections'.toUpperCase(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ),
          SliverGap(16),

          CollectionsHome(),
          SliverGap(22),

          FeaturedCategoriesHome(),
          SliverGap(22),

          SliverToBoxAdapter(child: JustForYouSection()),
          SliverGap(55),
          SliverToBoxAdapter(child: Footer()),
          SliverGap((kBottomNavigationBarHeight + 32)),
        ],
      ),
    );
  }
}
