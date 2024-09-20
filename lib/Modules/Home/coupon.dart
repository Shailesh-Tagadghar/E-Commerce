import 'package:ecommerce/Modules/Auth/Widget/custom_text.dart';
import 'package:ecommerce/Modules/Home/Widget/coupon_item_widget.dart';
import 'package:ecommerce/Utils/Constants/color_constant.dart';
import 'package:ecommerce/Utils/Constants/string_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:sizer/sizer.dart';

class Coupon extends StatelessWidget {
  Coupon({super.key});

  final List<Map<String, String>> couponItems = [
    {
      'code': StringConstants.code,
      'description': StringConstants.description,
      'offertext': StringConstants.offertext,
      'copy': StringConstants.copy,
    },
    {
      'code': StringConstants.code,
      'description': StringConstants.description,
      'offertext': StringConstants.offertext,
      'copy': StringConstants.copy,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.whiteColor,
      appBar: AppBar(
        backgroundColor: ColorConstants.whiteColor,
        toolbarHeight: 10.h,
        leadingWidth: 15.w,
        title: const CustomText(
          text: StringConstants.coupon,
          weight: FontWeight.w500,
          fontSize: 13,
        ),
        centerTitle: true,
        leading: Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(
            left: 4.w,
          ),
          padding: EdgeInsets.all(
            0.6.w,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: ColorConstants.lightGrayColor, width: 1),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            iconSize: 24,
            icon: const Icon(
              Bootstrap.arrow_left,
              color: ColorConstants.blackColor,
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: 6.w,
          right: 6.w,
          bottom: 2.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(
              text: StringConstants.offers,
              fontSize: 15,
              weight: FontWeight.w500,
              color: ColorConstants.blackColor,
            ),
            SizedBox(
              height: 1.5.h,
            ),
            // Place Expanded inside Column, outside of Padding
            Expanded(
              child: ListView.builder(
                itemCount: couponItems.length,
                itemBuilder: (context, index) {
                  final item = couponItems[index];
                  return Column(
                    children: [
                      CouponItemWidget(
                        code: item['code']!,
                        description: item['description']!,
                        offertext: item['offertext']!,
                        copy: item['copy']!,
                      ),
                      SizedBox(
                        height: 1.5.h,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
