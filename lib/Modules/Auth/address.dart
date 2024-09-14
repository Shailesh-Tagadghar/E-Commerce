import 'package:ecommerce/Modules/Auth/Widget/custom_button.dart';
import 'package:ecommerce/Modules/Auth/Widget/custom_field.dart';
import 'package:ecommerce/Modules/Auth/Widget/custom_text.dart';
import 'package:ecommerce/Modules/Auth/controllers/validation.dart';
import 'package:ecommerce/Routes/app_routes.dart';
import 'package:ecommerce/Utils/Constants/color_constant.dart';
import 'package:ecommerce/Utils/Constants/string_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:sizer/sizer.dart';

class Address extends StatelessWidget {
  Address({super.key});

  final ValidationController validationController =
      Get.put(ValidationController());

  final TextEditingController addressController = TextEditingController();
  final TextEditingController address1Controller = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController pinController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.whiteColor,
      appBar: AppBar(
        backgroundColor: ColorConstants.whiteColor,
        toolbarHeight: 10.h,
        leadingWidth: 15.w,
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
      body: Scaffold(
        backgroundColor: ColorConstants.whiteColor,
        body: Padding(
          padding: EdgeInsets.only(
            left: 4.w,
            right: 4.w,
            bottom: 2.h,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 1.h,
                ),
                const Align(
                  child: CustomText(
                    text: StringConstants.addresstext,
                    color: ColorConstants.blackColor,
                    fontSize: 18,
                    weight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 0.5.h,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 8.w,
                    right: 8.w,
                  ),
                  child: const CustomText(
                    text: StringConstants.userdisplaytext,
                    color: ColorConstants.greyColor,
                    fontSize: 11,
                    weight: FontWeight.w400,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 4.w,
                    right: 4.w,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                        text: StringConstants.addresslabel,
                        color: ColorConstants.blackColor,
                        fontSize: 11,
                        weight: FontWeight.w400,
                      ),
                      SizedBox(
                        height: 0.2.h,
                      ),
                      CustomField(
                        controller: addressController,
                        hintText: StringConstants.address,
                        fontSize: 11,
                        hintTextColor: ColorConstants.greyColor,
                        keyboardType: TextInputType.name,
                        // onChanged: (value) => validationController.validateAddress(value),
                      ),
                      Obx(() => CustomText(
                            text: validationController.addressError.value,
                            color: ColorConstants.errorColor,
                            fontSize: 10,
                            weight: FontWeight.w400,
                          )),
                      SizedBox(
                        height: 1.h,
                      ),
                      const CustomText(
                        text: StringConstants.addresslabel1,
                        color: ColorConstants.blackColor,
                        fontSize: 11,
                        weight: FontWeight.w400,
                      ),
                      SizedBox(
                        height: 0.2.h,
                      ),
                      CustomField(
                        controller: address1Controller,
                        hintText: StringConstants.address1,
                        fontSize: 11,
                        hintTextColor: ColorConstants.greyColor,
                        keyboardType: TextInputType.name,
                        // onChanged: (value) => validationController.validateAddress1(value),
                      ),
                      Obx(() => CustomText(
                            text: validationController.address1Error.value,
                            color: ColorConstants.errorColor,
                            fontSize: 10,
                            weight: FontWeight.w400,
                          )),
                      SizedBox(
                        height: 1.h,
                      ),
                      const CustomText(
                        text: StringConstants.citylabel,
                        color: ColorConstants.blackColor,
                        fontSize: 11,
                        weight: FontWeight.w400,
                      ),
                      SizedBox(
                        height: 0.2.h,
                      ),
                      CustomField(
                        controller: cityController,
                        hintText: StringConstants.city,
                        fontSize: 11,
                        hintTextColor: ColorConstants.greyColor,
                        keyboardType: TextInputType.name,
                        // onChanged: (value) => validationController.validateCity(value),
                      ),
                      Obx(() => CustomText(
                            text: validationController.cityError.value,
                            color: ColorConstants.errorColor,
                            fontSize: 10,
                            weight: FontWeight.w400,
                          )),
                      SizedBox(
                        height: 1.h,
                      ),
                      const CustomText(
                        text: StringConstants.statelabel,
                        color: ColorConstants.blackColor,
                        fontSize: 11,
                        weight: FontWeight.w400,
                      ),
                      SizedBox(
                        height: 0.2.h,
                      ),
                      CustomField(
                        controller: stateController,
                        hintText: StringConstants.state,
                        fontSize: 11,
                        hintTextColor: ColorConstants.greyColor,
                        keyboardType: TextInputType.name,
                        //  onChanged: (value) => validationController.validateState(value),
                      ),
                      Obx(() => CustomText(
                            text: validationController.stateError.value,
                            color: ColorConstants.errorColor,
                            fontSize: 10,
                            weight: FontWeight.w400,
                          )),
                      SizedBox(
                        height: 1.h,
                      ),
                      const CustomText(
                        text: StringConstants.pinlabel,
                        color: ColorConstants.blackColor,
                        fontSize: 11,
                        weight: FontWeight.w400,
                      ),
                      SizedBox(
                        height: 0.2.h,
                      ),
                      CustomField(
                        controller: pinController,
                        hintText: StringConstants.pin,
                        fontSize: 11,
                        hintTextColor: ColorConstants.greyColor,
                        keyboardType: TextInputType.number,
                        //  onChanged: (value) => validationController.validatePin(value),
                      ),
                      Obx(() => CustomText(
                            text: validationController.pinError.value,
                            color: ColorConstants.errorColor,
                            fontSize: 10,
                            weight: FontWeight.w400,
                          )),
                      SizedBox(
                        height: 4.h,
                      ),
                      CustomButton(
                        label: StringConstants.saveAddress,
                        btnColor: ColorConstants.rich,
                        height: 6.h,
                        fontSize: 14,
                        weight: FontWeight.w500,
                        labelColor: ColorConstants.whiteColor,
                        isSelected: true,
                        action: () {
                          validationController
                              .validateAddress(addressController.text);
                          validationController
                              .validateAddress1(address1Controller.text);
                          validationController
                              .validateCity(cityController.text);
                          validationController
                              .validateState(stateController.text);
                          validationController.validatePin(pinController.text);

                          if (validationController.addressError.value.isEmpty &&
                              validationController
                                  .address1Error.value.isEmpty &&
                              validationController.cityError.value.isEmpty &&
                              validationController.stateError.value.isEmpty &&
                              validationController.pinError.value.isEmpty) {
                            validationController.saveAddress(
                              addressController.text,
                              address1Controller.text,
                              cityController.text,
                              stateController.text,
                              pinController.text,
                            );
                            Get.toNamed(AppRoutes.navbarScreen);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
