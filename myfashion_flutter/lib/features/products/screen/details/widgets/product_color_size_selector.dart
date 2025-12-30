import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/widgets/chip_container.dart';
import 'package:flutter/material.dart';

class ProductColorSizeSelector extends StatefulWidget {
  const ProductColorSizeSelector({super.key});

  @override
  State<ProductColorSizeSelector> createState() =>
      _ProductColorSizeSelectorState();
}

class _ProductColorSizeSelectorState extends State<ProductColorSizeSelector> {
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      children: [
        Column(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Color:',
              style: Theme.of(
                context,
              ).textTheme.titleSmall!.copyWith(color: AppColors.label),
            ),
            Row(
              spacing: 8,
              children: [
                ChipColorSelector(isSelected: true, color: Colors.pink),
                ChipColorSelector(isSelected: false, color: Colors.green),
                ChipColorSelector(isSelected: false, color: Colors.indigo),
                ChipColorSelector(isSelected: false, color: Colors.pink),
                ChipColorSelector(isSelected: false, color: Colors.green),
                ChipColorSelector(isSelected: false, color: Colors.indigo),
              ],
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            Text(
              'Size:',
              style: Theme.of(
                context,
              ).textTheme.titleSmall!.copyWith(color: AppColors.label),
            ),
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
    );
  }
}
