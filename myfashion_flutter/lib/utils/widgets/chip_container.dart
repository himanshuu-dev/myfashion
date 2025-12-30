import 'package:ecommerce/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class ChipContainer extends StatefulWidget {
  final bool isSelected;
  final String title;
  const ChipContainer({
    super.key,
    required this.isSelected,
    required this.title,
  });

  @override
  State<ChipContainer> createState() => _ChipContainerState();
}

class _ChipContainerState extends State<ChipContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      alignment: Alignment.center,
      decoration: ShapeDecoration(
        shape: RoundedSuperellipseBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: widget.isSelected ? AppColors.titleActive : AppColors.border,
          ),
        ),
        color: widget.isSelected ? AppColors.titleActive : AppColors.offWhite,
      ),
      child: Text(
        widget.title,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: widget.isSelected ? AppColors.offWhite : AppColors.label,
        ),
      ),
    );
  }
}

class ChipColorSelector extends StatefulWidget {
  final bool isSelected;
  final Color color;
  const ChipColorSelector({
    super.key,
    required this.isSelected,
    required this.color,
  });

  @override
  State<ChipColorSelector> createState() => _ChipColorSelectorState();
}

class _ChipColorSelectorState extends State<ChipColorSelector> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      width: 24,
      padding: EdgeInsets.all(1.5),
      decoration: !widget.isSelected
          ? null
          : BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.placeholder),
            ),
      child: Container(
        height: 22,
        width: 22,
        decoration: BoxDecoration(shape: BoxShape.circle),
        child: CircleAvatar(backgroundColor: widget.color),
      ),
    );
  }
}

class ChipSizeSelector extends StatefulWidget {
  final bool isSelected;
  final String size;
  const ChipSizeSelector({
    super.key,
    required this.isSelected,
    required this.size,
  });

  @override
  State<ChipSizeSelector> createState() => _ChipSizeSelectorState();
}

class _ChipSizeSelectorState extends State<ChipSizeSelector> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      width: 24,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: widget.isSelected ? AppColors.body : null,
        border: widget.isSelected ? null : Border.all(color: AppColors.border),
      ),
      child: Text(
        widget.size.toUpperCase(),
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
          color: widget.isSelected ? AppColors.offWhite : null,
        ),
      ),
    );
  }
}
