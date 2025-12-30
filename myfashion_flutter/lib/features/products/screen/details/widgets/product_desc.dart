import 'package:ecommerce/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProductDesc extends StatelessWidget {
  final String title;
  final String desc;
  const ProductDesc({super.key, required this.title, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
            letterSpacing: 2,
            color: AppColors.titleActive,
          ),
        ),
        Gap(6),
        Text(desc, style: TextStyle(color: AppColors.label)),
      ],
    );
  }
}
