import 'package:ecommerce/router/router.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MenuScreen extends ConsumerStatefulWidget {
  const MenuScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MenuScreenState();
}

class _MenuScreenState extends ConsumerState<MenuScreen> {
  // Controller to handle search input
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 1. Wrap in DefaultTabController for the 3 tabs
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        // 2. Use NestedScrollView so the AppBar floats/snaps when inner lists scroll
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                title: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search items...',
                    prefixIcon: const Icon(Icons.search),
                  ),
                ),
                floating: true,
                snap: true,
                pinned: true,
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(kTextTabBarHeight),
                  child: Column(
                    children: [
                      // --- Tab Bar ---
                      TabBar(
                        indicatorColor: AppColors.primary,
                        labelColor: AppColors.body,
                        unselectedLabelColor: AppColors.body.withValues(
                          alpha: 0.5,
                        ),
                        dividerColor: AppColors.placeholder.withValues(
                          alpha: 0.2,
                        ),
                        tabAlignment: TabAlignment.start,
                        isScrollable: true,
                        labelStyle: Theme.of(context).textTheme.titleLarge!
                            .copyWith(fontSize: 14, letterSpacing: 3),
                        tabs: [
                          Tab(text: "Men".toUpperCase()),
                          Tab(text: "Women".toUpperCase()),
                          Tab(text: "Kids".toUpperCase()),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ];
          },
          // 4. The Body contains the TabBarView with your menus
          body: TabBarView(
            children: [
              _buildMenuContent("Men's Collection"),
              _buildMenuContent("Women's Collection"),
              _buildMenuContent("Kids' Collection"),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget to create a dummy menu list for demonstration
  Widget _buildMenuContent(String title) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 12),
      itemCount: 6,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            'Category $index',
            style: TextStyle(color: AppColors.body),
          ),
          textColor: AppColors.body,
          trailing: Icon(Icons.chevron_right),
          minTileHeight: 45,
          onTap: () {
            context.pushNamed(AppRouter.products);
          },
        );
      },
    );
  }
}
