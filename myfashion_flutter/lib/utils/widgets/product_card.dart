import 'dart:math';

import 'package:ecommerce/router/router.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/images.dart';
import 'package:ecommerce/utils/widgets/chip_container.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ProductCard extends StatelessWidget {
  final double thumbnailAspectRatio;
  final bool centerContent;
  final bool smallText;
  final bool showProductImage;
  final bool isGalleryView;
  final bool isHorizontalCard;
  final bool isFromWishlist;
  final bool isFromBag;
  const ProductCard({
    super.key,
    required this.thumbnailAspectRatio,
    this.centerContent = false,
    this.smallText = false,
    this.showProductImage = false,
    this.isGalleryView = false,
    this.isHorizontalCard = false,
    this.isFromBag = false,
    this.isFromWishlist = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(AppRouter.productdetails);
      },
      child: ColoredBox(
        color: Colors.transparent,
        child: isHorizontalCard
            ? _horizontalCard(context)
            : isFromBag
            ? _bagProductCard(context)
            : _verticalCard(context),
      ),
    );
  }

  Widget _verticalCard(BuildContext context) {
    return Column(
      crossAxisAlignment: centerContent
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: thumbnailAspectRatio,
          child: Stack(
            children: [
              Image.asset(
                height: double.infinity,
                width: double.infinity,
                showProductImage
                    ? pickRandomProductImage()
                    : pickRandomModelImage(),
                fit: BoxFit.cover,
              ),
              if (!isFromBag && !isFromWishlist) ...[
                Positioned(
                  right: 10,
                  top: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withValues(alpha: 0.6),
                          blurRadius: 16,
                          spreadRadius: 6,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Icon(
                      FontAwesomeIcons.heart,
                      color: AppColors.primary,
                      size: 18,
                    ),
                  ),
                ),
              ],
              if (isFromBag || isFromWishlist) ...[
                Positioned(
                  right: 10,
                  top: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withValues(alpha: 0.6),
                          blurRadius: 16,
                          spreadRadius: 6,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Icon(Icons.close, color: AppColors.label, size: 18),
                  ),
                ),
              ],
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: centerContent
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              crossAxisAlignment: centerContent
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Recycle Boucle Knit Cardigan Pink',
                        textAlign: centerContent ? TextAlign.center : null,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: isGalleryView
                            ? Theme.of(context).textTheme.titleMedium
                            : TextStyle(
                                color: AppColors.titleActive,
                                fontSize: smallText ? 12 : null,
                              ),
                      ),
                    ),
                    if (isGalleryView) ...[
                      Gap(4),
                      Text(
                        '\$120',
                        textAlign: centerContent ? TextAlign.center : null,
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: isGalleryView
                              ? null
                              : smallText
                              ? 12
                              : null,
                        ),
                      ),
                    ],
                  ],
                ),
                if (!isGalleryView) ...[
                  Gap(4),
                  Text(
                    '\$120',
                    textAlign: centerContent ? TextAlign.center : null,
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: smallText ? 12 : null,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _horizontalCard(BuildContext context) {
    return Row(
      children: [
        AspectRatio(
          aspectRatio: thumbnailAspectRatio,
          child: Image.asset(
            showProductImage
                ? pickRandomProductImage()
                : pickRandomModelImage(),
            fit: BoxFit.cover,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Row(
                  spacing: 8,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        'Recycle Boucle Knit Cardigan Pink',
                        textAlign: centerContent ? TextAlign.center : null,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    if (!isFromBag && !isFromWishlist)
                      Icon(
                        FontAwesomeIcons.heart,
                        color: AppColors.primary,
                        size: 18,
                      ),
                    if (isFromBag || isFromWishlist)
                      Icon(Icons.close, color: AppColors.label, size: 18),
                  ],
                ),
                Gap(4),
                Text('\$120', style: TextStyle(color: AppColors.primary)),
                Spacer(),
                Row(
                  children: [
                    Text(
                      'Size',
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall!.copyWith(color: AppColors.label),
                    ),
                    Gap(10),
                    Row(
                      spacing: 8,
                      children: [
                        ChipSizeSelector(isSelected: true, size: 'S'),
                        ChipSizeSelector(isSelected: false, size: 'M'),
                        ChipSizeSelector(isSelected: false, size: 'L'),
                        ChipSizeSelector(isSelected: false, size: 'XL'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _bagProductCard(BuildContext context) {
    return Row(
      children: [
        AspectRatio(
          aspectRatio: thumbnailAspectRatio,
          child: Image.asset(
            showProductImage
                ? pickRandomProductImage()
                : pickRandomModelImage(),
            fit: BoxFit.cover,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Row(
                  spacing: 8,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        'Recycle Boucle Knit Cardigan Pink',
                        textAlign: centerContent ? TextAlign.center : null,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),

                    Icon(Icons.close, color: AppColors.label, size: 18),
                  ],
                ),
                Gap(4),
                Text('\$120', style: TextStyle(color: AppColors.primary)),
                Gap(8),
                Row(
                  spacing: 8,
                  children: [
                    CircleAvatar(
                      radius: 12,
                      backgroundColor: AppColors.background,
                      child: Icon(
                        Icons.remove,
                        size: 16,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Text('1'),
                    CircleAvatar(
                      radius: 12,
                      backgroundColor: AppColors.background,
                      child: Icon(
                        Icons.add,
                        size: 16,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
                Gap(8),
                Expanded(
                  child: Column(
                    children: [
                      _infoRow(context, 'Colour', 'Red'),
                      _infoRow(context, 'Size', 'XL'),
                      _infoRow(context, 'Total', '₹1278'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _infoRow(BuildContext context, String label, String value) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(label, style: Theme.of(context).textTheme.bodySmall),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ],
    );
  }
}

List<String> models = [
  AppImages.model,
  AppImages.model2,
  AppImages.model3,
  AppImages.model4,
  AppImages.model5,
  AppImages.model6,
  AppImages.model7,
  AppImages.model8,
];

List<String> products = [
  AppImages.product1,
  AppImages.product2,
  AppImages.product3,
  AppImages.product4,
  AppImages.product5,
  AppImages.product6,
];

String pickRandomModelImage() {
  if (models.isEmpty) return "Default"; // Safety check
  return models[Random().nextInt(models.length)];
}

String pickRandomProductImage() {
  if (products.isEmpty) return "Default"; // Safety check
  return products[Random().nextInt(products.length)];
}
