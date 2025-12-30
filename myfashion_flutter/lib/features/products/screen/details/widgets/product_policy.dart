import 'package:ecommerce/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class ProductPolicyTile extends StatelessWidget {
  final String title;
  final String desc;
  const ProductPolicyTile({super.key, required this.title, required this.desc});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        title,
        style: Theme.of(
          context,
        ).textTheme.bodyMedium!.copyWith(color: AppColors.titleActive),
      ),
      textColor: AppColors.body,
      collapsedShape: const Border(),
      shape: Border(bottom: BorderSide(color: AppColors.border)),
      childrenPadding: EdgeInsets.only(bottom: 8),
      tilePadding: EdgeInsets.all(0),
      children: <Widget>[Text(desc, style: TextStyle(color: AppColors.label))],
    );
  }
}
