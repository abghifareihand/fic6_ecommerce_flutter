import 'package:fic6_ecommerce_flutter/common/constants.dart';
import 'package:fic6_ecommerce_flutter/common/theme.dart';
import 'package:fic6_ecommerce_flutter/data/models/list_product_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class DetailScreen extends StatelessWidget {
  final Product product;
  const DetailScreen({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: ListView(
          children: [
            Stack(
              children: [
                /// Image Slider
                ImageSlideshow(
                  indicatorColor: primaryColor,
                  indicatorBackgroundColor: lightgreyColor,
                  height: 400,
                  indicatorRadius: 4,
                  children: [
                    Image.network(
                      product.attributes.image,
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
                ),

                /// Icon Header
                Container(
                  margin: const EdgeInsets.only(top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          margin: const EdgeInsets.only(left: 16),
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: whiteColor,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            color: lightgreyColor,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: whiteColor,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.favorite_border_outlined,
                              color: lightgreyColor,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                              left: 8,
                              right: 16,
                            ),
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: whiteColor,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.share_outlined,
                              color: lightgreyColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 24,
        ),
        height: MediaQuery.of(context).size.height * 0.4,
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.attributes.name,
              style: blackTextStyle.copyWith(
                fontSize: 20,
                fontWeight: semiBold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              product.attributes.description,
              style: greyTextStyle.copyWith(
                fontSize: 12,
              ),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 16.0,
            ),
            Text(
              formatCurrency(product.attributes.price),
              style: primaryTextStyle.copyWith(
                fontSize: 20,
                fontWeight: semiBold,
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(36),
                    border: Border.all(
                      color: greyColor,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.remove,
                          color: greyColor,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            '1',
                            style: greyTextStyle.copyWith(
                              fontSize: 18,
                              fontWeight: semiBold,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.add,
                          color: greyColor,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 48,
                  width: 220,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(65),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      'Buy Now',
                      style: whiteTextStyle.copyWith(
                        fontWeight: semiBold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
