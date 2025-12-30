import 'package:ecommerce/features/account/screen/account_screen.dart';
import 'package:ecommerce/features/bag/screen/bag_screen.dart';
import 'package:ecommerce/features/home/screen/home_screen.dart';
import 'package:ecommerce/features/menu/screen/menu_screen.dart';
import 'package:ecommerce/features/products/screen/details/product_details_screen.dart';
import 'package:ecommerce/features/products/screen/list/products_list_screen.dart';
import 'package:ecommerce/features/wishlist/screen/wishlist_screen.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:ui';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  static String get home => '/home';
  static String get search => '/search';
  static String get menu => '/menu';
  static String get account => '/account';
  static String get bag => '/bag';
  static String get products => 'products';
  static String get productdetails => '/products-details';

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: home,
    routes: [
      StatefulShellRoute(
        // 1. FIXED: Add this builder line to satisfy the assertion.
        // It acts as a pass-through because we handle the UI in navigatorContainerBuilder.
        builder: (context, state, navigationShell) => navigationShell,

        // 2. We use this to access the list of 'children' (the navigators) for the PageView
        navigatorContainerBuilder: (context, navigationShell, children) {
          return ScaffoldWithNavBar(
            navigationShell: navigationShell,
            children: children,
          );
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: home,
                name: home,
                builder: (context, state) => HomeScreen(),
                routes: [
                  GoRoute(
                    path: products,
                    name: products,
                    builder: (context, state) => ProductsListScreen(),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: search,
                name: search,
                builder: (context, state) => WishlistScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(path: menu, builder: (context, state) => MenuScreen()),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(path: bag, builder: (context, state) => BagScreen()),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: account,
                builder: (context, state) => AccountScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: productdetails,
        name: productdetails,
        builder: (context, state) => ProductDetailsScreen(),
      ),
    ],
  );
}

class ScaffoldWithNavBar extends StatefulWidget {
  const ScaffoldWithNavBar({
    required this.navigationShell,
    required this.children, // Add this parameter
    super.key,
  });

  final StatefulNavigationShell navigationShell;
  final List<Widget> children;

  @override
  State<ScaffoldWithNavBar> createState() => _ScaffoldWithNavBarState();
}

class _ScaffoldWithNavBarState extends State<ScaffoldWithNavBar> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    // Initialize controller to the current index (important for deep linking)
    _pageController = PageController(
      initialPage: widget.navigationShell.currentIndex,
    );
  }

  @override
  void didUpdateWidget(covariant ScaffoldWithNavBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    // If the index changes via Deep Link or external update, animate the PageView
    if (widget.navigationShell.currentIndex != _pageController.page?.round()) {
      _pageController.animateToPage(
        widget.navigationShell.currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTap(int index) {
    // When tapping the bar:
    // 1. Tell go_router to switch the branch
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
    // 2. Animate the PageView to match
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onPageChanged(int index) {
    // When swiping:
    // Tell go_router to update the URL/State, but don't reset the stack
    // (unless you want to pop to root on swipe)
    widget.navigationShell.goBranch(index);
  }

  List get data => [
    {'title': 'Home', 'icon': Icons.home_rounded},
    {'title': 'Wishlist', 'icon': Icons.favorite_rounded},
    {'title': 'Menu', 'icon': Icons.manage_search_rounded},
    {'title': 'Bag', 'icon': Icons.shopping_bag_rounded},
    {'title': 'Account', 'icon': Icons.person_rounded},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        physics: const ClampingScrollPhysics(),
        children: widget.children,
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(8),
          height: kBottomNavigationBarHeight + 8,
          child: ClipPath(
            clipper: ShapeBorderClipper(
              shape: RoundedSuperellipseBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide.none,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                decoration: ShapeDecoration(
                  color: AppColors.offWhite.withValues(alpha: 0.7),
                  shape: RoundedSuperellipseBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(color: AppColors.border, width: 1),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    for (var i = 0; i < data.length; i++)
                      IconButton(
                        onPressed: () {
                          _onTap(i);
                        },
                        icon: Icon(
                          data[i]['icon'],
                          color: widget.navigationShell.currentIndex == i
                              ? AppColors.primary
                              : AppColors.placeholder,
                          size: 24,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
