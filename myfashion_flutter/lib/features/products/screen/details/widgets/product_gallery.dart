import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/widgets/diamond_icon.dart';
import 'package:ecommerce/utils/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class ProductGallery extends StatefulWidget {
  const ProductGallery({super.key});

  @override
  State<ProductGallery> createState() => _ProductGalleryState();
}

class _ProductGalleryState extends State<ProductGallery> {
  PageController _controller = PageController();
  int _currentIndex = 0;
  @override
  void initState() {
    _controller = PageController(viewportFraction: 0.7);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                context.pop();
              },
              child: CircleAvatar(
                backgroundColor: Colors.black45,
                child: Icon(Icons.close_outlined, color: AppColors.offWhite),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            padEnds: false,
            pageSnapping: false,
            scrollDirection: Axis.vertical,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            children: [
              for (var i = 0; i < models.length; i++)
                Padding(
                  padding: const EdgeInsets.only(top: kToolbarHeight),
                  child: Image.asset(models[i]),
                ),
            ],
          ),
          Positioned(
            right: 8,
            bottom: 0,
            top: 0,
            child: Column(
              spacing: 8,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < models.length; i++)
                  DiamondContainer(
                    size: 6,
                    fillColor: i == _currentIndex
                        ? AppColors.primary
                        : AppColors.offWhite.withValues(alpha: 0.9),
                    borderColor: AppColors.offWhite,
                    borderWidth: 0,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
