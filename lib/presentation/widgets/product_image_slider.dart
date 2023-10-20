import 'package:fic6_ecommerce_flutter/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class ProductImageSlider extends StatelessWidget {
  const ProductImageSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return ImageSlideshow(
      indicatorColor: primaryColor,
      indicatorBackgroundColor: lightgreyColor,
      height: 300,
      autoPlayInterval: 3000,
      indicatorRadius: 4,
      isLoop: true,
      children: [
        Image.network(
          'https://compass-ecom-bucket.s3-ap-southeast-1.amazonaws.com/images/productdetail/f3185f97be0601eb4c8ce8d44ca2512c39502f3c.jpg',
          fit: BoxFit.cover,
        ),
        Image.network(
          'https://compass-ecom-bucket.s3-ap-southeast-1.amazonaws.com/images/productdetail/5dcee1f2c3dcf309d12130cc84ac31f74ae804b4.jpg',
          fit: BoxFit.cover,
        ),
        Image.network(
          'https://compass-ecom-bucket.s3-ap-southeast-1.amazonaws.com/images/productdetail/f049a8fa9d8a6b41a47f7187faee9b99de816aaa.jpg',
          fit: BoxFit.cover,
        ),
      ],
    );
  }
}
