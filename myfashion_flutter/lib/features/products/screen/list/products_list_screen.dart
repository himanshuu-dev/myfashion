import 'package:ecommerce/router/router.dart';
import 'package:ecommerce/utils/widgets/chip_container.dart';
import 'package:ecommerce/utils/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

enum ProductGridType { grid2x2, grid3x3, listView, galleryView }

class ProductsListScreen extends ConsumerStatefulWidget {
  const ProductsListScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductsListState();
}

class _ProductsListState extends ConsumerState<ProductsListScreen> {
  ProductGridType productGridType = ProductGridType.grid2x2;

  bool _isGridVisible = true;

  void _toggleGrid() async {
    setState(() {
      _isGridVisible = false;
    });

    await Future.delayed(const Duration(milliseconds: 200));

    setState(() {
      if (productGridType == ProductGridType.grid2x2) {
        productGridType = ProductGridType.grid3x3;
      } else if (productGridType == ProductGridType.grid3x3) {
        productGridType = ProductGridType.listView;
      } else if (productGridType == ProductGridType.listView) {
        productGridType = ProductGridType.galleryView;
      } else {
        productGridType = ProductGridType.grid2x2;
      }
    });

    setState(() {
      _isGridVisible = true;
    });
  }

  List cats = ['Hoodies', 'Jackets', 'Jeans', 'Trousers', 'Shirts'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            snap: true,
            pinned: true,
            actions: [
              IconButton(
                onPressed: _toggleGrid,
                icon: Icon(
                  productGridType == ProductGridType.grid2x2
                      ? Icons.apps
                      : productGridType == ProductGridType.grid3x3
                      ? Icons.view_list
                      : productGridType == ProductGridType.listView
                      ? Icons.view_stream
                      : Icons.grid_view,
                  size: 22,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.filter_list, size: 22),
              ),
            ],

            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(58),
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(
                  right: 12,
                  left: 12,
                  bottom: 12,
                  top: 12,
                ),
                scrollDirection: Axis.horizontal,
                child: Row(
                  spacing: 6,
                  children: [
                    for (String item in cats)
                      GestureDetector(
                        onTap: () {
                          context.pushNamed(AppRouter.products);
                        },
                        child: ChipContainer(isSelected: false, title: item),
                      ),
                  ],
                ),
              ),
            ),
          ),

          SliverAnimatedOpacity(
            opacity: _isGridVisible ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            sliver: SliverGrid.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 2,
                crossAxisSpacing: 2,
                crossAxisCount: productGridType == ProductGridType.grid2x2
                    ? 2 // for 2x2 grid
                    : productGridType == ProductGridType.grid3x3
                    ? 3 // for 3x3 grid
                    : productGridType == ProductGridType.listView
                    ? 1 // for listview
                    : 1, // for gallery view
                childAspectRatio: productGridType == ProductGridType.grid2x2
                    ? 0.6 // for 2x2 grid
                    : productGridType == ProductGridType.grid3x3
                    ? 0.5 // for 3x3 grid
                    : productGridType == ProductGridType.listView
                    ? 2.5 // for listview
                    : 0.71, // gallery view
              ),
              itemCount: 20,
              itemBuilder: (BuildContext context, int index) {
                return ProductCard(
                  thumbnailAspectRatio:
                      productGridType == ProductGridType.grid2x2
                      ? 0.8 // for 2x2 grid
                      : productGridType == ProductGridType.grid3x3
                      ? 0.7 // for 3x3 grid
                      : productGridType == ProductGridType.listView
                      ? 1 // for listview
                      : 0.8, // for gallery view
                  centerContent: false,
                  smallText: (productGridType == ProductGridType.grid3x3)
                      ? true
                      : false,
                  showProductImage:
                      (productGridType == ProductGridType.grid3x3 ||
                      productGridType == ProductGridType.listView),
                  isGalleryView: productGridType == ProductGridType.galleryView,
                  isHorizontalCard: productGridType == ProductGridType.listView,
                );
              },
            ),
          ),

          SliverGap(kBottomNavigationBarHeight + 32),
        ],
      ),
    );
  }
}
