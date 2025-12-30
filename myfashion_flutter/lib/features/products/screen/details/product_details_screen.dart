import 'dart:ui';

import 'package:ecommerce/features/products/screen/details/widgets/product_color_size_selector.dart';
import 'package:ecommerce/features/products/screen/details/widgets/product_desc.dart';
import 'package:ecommerce/features/products/screen/details/widgets/product_details_crousel.dart';
import 'package:ecommerce/features/products/screen/details/widgets/product_policy.dart';
import 'package:ecommerce/features/products/screen/details/widgets/suggested_products.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class ProductDetailsScreen extends ConsumerStatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends ConsumerState<ProductDetailsScreen> {
  @override
  void initState() {
    super.initState();
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  void dispose() {
    //  SystemChrome.setEnabledSystemUIMode(
    //   SystemUiMode.manual,
    //   overlays: SystemUiOverlay.values,
    // );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double carouselHeight = MediaQuery.of(context).size.height * 0.7;

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              floating: false,
              snap: false,
              expandedHeight: carouselHeight,
              elevation: 0,
              backgroundColor: Colors.white.withValues(alpha: 0.9),
              flexibleSpace: _buildFrostyFlexibleSpace(context, carouselHeight),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(AppIcons.shoppingBag),
                ),
                const Gap(8),
              ],
            ),
          ];
        },
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 24),
          child: Column(
            children: [
              const Gap(22),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Recycle Boucle Knit Cardigan Pink',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(
                        context,
                      ).textTheme.titleMedium!.copyWith(fontSize: 18),
                    ),
                    const Gap(4),
                    Text(
                      '\$120',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const Gap(16),
                    const ProductColorSizeSelector(),
                  ],
                ),
              ),
              const Gap(22),
              // Add to basket section
              _buildAddToBasketSection(context),
              const Gap(22),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ProductDesc(
                      title: 'Material',
                      desc:
                          'We work with monitoring programmes to ensure compliance with safety, health and quality standards for our products.',
                    ),
                    const Gap(22),
                    const ProductDesc(
                      title: 'Care',
                      desc:
                          'To keep your jackets and coats clean, you only need to freshen them up and go over them with a cloth or a clothes brush. If you need to dry clean a garment, look for a dry cleaner that uses technologies that are respectful of the environment.',
                    ),
                    const Gap(22),
                    const ProductPolicyTile(
                      title: 'COD Policy',
                      desc:
                          'We work with monitoring programmes to ensure compliance with safety, health and quality standards for our products.',
                    ),
                    const ProductPolicyTile(
                      title: 'Return Policy',
                      desc:
                          'We work with monitoring programmes to ensure compliance with safety, health and quality standards for our products.',
                    ),
                  ],
                ),
              ),
              const Gap(22),
              const SuggestedProducts(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFrostyFlexibleSpace(
    BuildContext context,
    double expandedHeight,
  ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final mediaPaddingTop = MediaQuery.paddingOf(context).top;
        final minHeight = kToolbarHeight + mediaPaddingTop;

        final currentHeight = constraints.maxHeight;
        final collapseRange = expandedHeight - minHeight;

        final collapseProgress =
            (1 - ((currentHeight - minHeight) / collapseRange)).clamp(0.0, 1.0);

        final blurSigma = lerpDouble(0, 12, collapseProgress)!;
        // final bool isCollapsed =
        //     currentHeight <=
        //     MediaQuery.of(context).padding.top + kToolbarHeight + 10;

        return FlexibleSpaceBar(
          collapseMode: CollapseMode.parallax,
          background: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
            child: const ProductDetailsCarousel(),
          ),
        );
      },
    );
  }

  Widget _buildAddToBasketSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      color: AppColors.titleActive,
      child: Row(
        children: [
          Icon(Icons.add, color: AppColors.offWhite),
          const Gap(12),
          Text(
            'Add to basket'.toUpperCase(),
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: AppColors.offWhite,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.favorite_border, color: AppColors.offWhite),
          ),
        ],
      ),
    );
  }
}
