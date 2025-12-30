import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/widgets/diamond_divider.dart';
import 'package:ecommerce/utils/widgets/diamond_icon.dart';
import 'package:ecommerce/utils/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class JustForYouSection extends StatefulWidget {
  const JustForYouSection({super.key});

  @override
  State<JustForYouSection> createState() => _JustForYouSectionState();
}

class _JustForYouSectionState extends State<JustForYouSection> {
  PageController _controller = PageController();
  // 1. State variable to track the current page
  int _currentIndex = 0;

  @override
  void initState() {
    // Note: It's often better to initialize the controller in the definition or
    // keep this but ensure you dispose of it later.
    _controller = PageController(viewportFraction: 0.8);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose(); // Best practice to dispose controllers
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Just For You', style: Theme.of(context).textTheme.titleLarge),
        Gap(4),
        DiamondDivider(),
        Gap(22),
        AspectRatio(
          aspectRatio: 0.8,
          child: PageView(
            controller: _controller,
            padEnds: false,
            // 2. Update state when page changes
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            children: [
              for (var i = 0; i < 5; i++)
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: ProductCard(
                    thumbnailAspectRatio: 0.75,
                    centerContent: true,
                  ),
                ),
            ],
          ),
        ),
        Gap(4),
        Row(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var i = 0; i < 5; i++)
              DiamondContainer(
                size: 8,
                fillColor: i == _currentIndex
                    ? AppColors.placeholder
                    : Colors.transparent,
                borderColor: AppColors.placeholder,
                borderWidth: 1,
              ),
          ],
        ),
      ],
    );
  }
}
