import 'package:ecommerce/features/products/screen/details/widgets/product_gallery.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/widgets/diamond_icon.dart';
import 'package:ecommerce/utils/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProductDetailsCarousel extends StatefulWidget {
  const ProductDetailsCarousel({super.key});

  @override
  State<ProductDetailsCarousel> createState() => _ProductDetailsCarouselState();
}

class _ProductDetailsCarouselState extends State<ProductDetailsCarousel> {
  PageController _controller = PageController();
  int _currentIndex = 0;
  @override
  void initState() {
    _controller = PageController(viewportFraction: 1);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              PageView(
                controller: _controller,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                children: [
                  for (var i = 0; i < models.length; i++)
                    Image.asset(models[i], fit: BoxFit.cover),
                ],
              ),
              Positioned(
                bottom: 12,
                right: 12,
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog.fullscreen(
                          backgroundColor: Colors.black87,
                          child: ProductGallery(),
                        );
                      },
                    );
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.black26,
                    child: Icon(
                      Icons.open_in_full,
                      size: 20,
                      color: AppColors.offWhite,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Gap(8),
        Row(
          spacing: 8,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var i = 0; i < models.length; i++)
              DiamondContainer(
                size: 7,
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
