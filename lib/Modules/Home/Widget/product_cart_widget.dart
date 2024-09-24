import 'package:ecommerce/Modules/Auth/Widget/custom_text.dart';
import 'package:ecommerce/Utils/Constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ProductCartWidget extends StatelessWidget {
  final String? id;
  final String name;
  final String price;
  final String rating;
  final String? description;
  final String? sizechart;
  final String? colorchart;
  final String image;
  // final String? salecategory_id;
  // final String? category_id;
  final String? gender;

  const ProductCartWidget({
    super.key,
    this.id,
    required this.name,
    required this.price,
    required this.rating,
    this.description,
    this.sizechart,
    this.colorchart,
    required this.image,
    // this.salecategory_id,
    // this.category_id,
    this.gender,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(left: 4.w, right: 4.w),
        child: Container(
          padding: const EdgeInsetsDirectional.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: ColorConstants.whiteColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      height: 19.h,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      image,
                    ),
                  ),
                  Container(
                    width: 8.6.w,
                    height: 4.4.h,
                    margin: const EdgeInsets.only(right: 8, top: 8),
                    decoration: BoxDecoration(
                      color: ColorConstants.whiteColor.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      padding: const EdgeInsets.all(1),
                      iconSize: 22,
                      icon: const Icon(
                        Icons.favorite_outline_outlined,
                        color: ColorConstants.primary,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 0.8.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: name,
                    fontSize: 12,
                    weight: FontWeight.w400,
                    color: ColorConstants.blackColor,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.amber[500],
                        size: 19,
                      ),
                      SizedBox(
                        width: 0.5.w,
                      ),
                      CustomText(
                        text: rating,
                        fontSize: 12,
                        weight: FontWeight.w400,
                        color: ColorConstants.greyColor,
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 0.4.h,
              ),
              CustomText(
                text: price,
                fontSize: 12,
                weight: FontWeight.w500,
                color: ColorConstants.blackColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
