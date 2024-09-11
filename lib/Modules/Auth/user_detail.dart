import 'package:ecommerce/Modules/Auth/Widget/custom_button.dart';
import 'package:ecommerce/Modules/Auth/Widget/custom_field.dart';
import 'package:ecommerce/Modules/Auth/Widget/custom_text.dart';
import 'package:ecommerce/Modules/Auth/auth_controller.dart';
import 'package:ecommerce/Routes/app_routes.dart';
// import 'package:ecommerce/Routes/app_routes.dart';
import 'package:ecommerce/Utils/Constants/asset_constant.dart';
import 'package:ecommerce/Utils/Constants/color_constant.dart';
import 'package:ecommerce/Utils/Constants/string_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:sizer/sizer.dart';

class UserDetail extends StatelessWidget {
  UserDetail({super.key});

  final AuthController authController = Get.put(AuthController());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nameController.text = authController.userName.value;
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
                  height: 3.h,
                ),
                const Align(
                  child: CustomText(
                    text: StringConstants.profiletext,
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
                      // Align(
                      //   child: GestureDetector(
                      //     onTap: () {
                      //       showModalBottomSheet(
                      //         context: context,
                      //         builder: (context) => SizedBox(
                      //           height: 150,
                      //           child: Column(
                      //             children: [
                      //               ListTile(
                      //                 leading: const Icon(Icons.photo_library),
                      //                 title: const Text('Gallery'),
                      //                 onTap: () {},
                      //               ),
                      //               ListTile(
                      //                 leading: const Icon(Icons.camera_alt),
                      //                 title: const Text('Camera'),
                      //                 onTap: () {},
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //       );
                      //     },
                      //     child: Stack(
                      //       alignment: Alignment.center,
                      //       children: [
                      //         CircleAvatar(
                      //           radius: 60,
                      //           backgroundColor: ColorConstants.background,
                      //           child: Align(
                      //             alignment: Alignment.bottomRight,
                      //             child: Container(
                      //               height: 4.h,
                      //               width: 8.w,
                      //               decoration: BoxDecoration(
                      //                 color: ColorConstants.rich,
                      //                 borderRadius: BorderRadius.circular(100),
                      //                 border: Border.all(
                      //                   width: 2,
                      //                   color: ColorConstants.whiteColor,
                      //                 ),
                      //               ),
                      //               child: const Icon(
                      //                 AntDesign.edit_outline,
                      //                 color: ColorConstants.whiteColor,
                      //                 size: 20,
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //         const Icon(
                      //           Icons.person_rounded,
                      //           color: ColorConstants.greyColor,
                      //           size: 60,
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      Align(
                        child: GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => SizedBox(
                                height: 150,
                                child: Column(
                                  children: [
                                    ListTile(
                                      leading: const Icon(Icons.photo_library),
                                      title: const Text('Gallery'),
                                      onTap: () {
                                        authController.pickImageFromGallery();
                                        // Get.back();
                                        Navigator.pop(context);
                                      },
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.camera_alt),
                                      title: const Text('Camera'),
                                      onTap: () {
                                        authController.pickImageFromCamera();
                                        // Get.back();
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Obx(
                                () =>
                                    // child:
                                    CircleAvatar(
                                  radius: 60,
                                  // backgroundImage:
                                  //     const AssetImage(AssetConstant.image),
                                  backgroundImage: authController
                                              .profileImage.value !=
                                          null
                                      ? FileImage(authController
                                          .profileImage.value!) as ImageProvider
                                      : const AssetImage(AssetConstant.image),
                                  backgroundColor: ColorConstants.background,
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      height: 4.h,
                                      width: 8.w,
                                      decoration: BoxDecoration(
                                        color: ColorConstants.rich,
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        border: Border.all(
                                          width: 2,
                                          color: ColorConstants.whiteColor,
                                        ),
                                      ),
                                      child: const Icon(
                                        AntDesign.edit_outline,
                                        color: ColorConstants.whiteColor,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // const Icon(
                              //   Icons.person_rounded,
                              //   color: ColorConstants.greyColor,
                              //   size: 60,
                              // ),
                            ],
                          ),
                        ),
                      ),
                      Obx(() => authController.imageError.value.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: CustomText(
                                text: authController.imageError.value,
                                color: ColorConstants.errorColor,
                                fontSize: 10,
                                weight: FontWeight.w400,
                              ),
                            )
                          : const SizedBox.shrink()),
                      SizedBox(
                        height: 3.h,
                      ),
                      const CustomText(
                        text: StringConstants.namelabel,
                        color: ColorConstants.blackColor,
                        fontSize: 11,
                        weight: FontWeight.w400,
                      ),
                      SizedBox(
                        height: 0.2.h,
                      ),
                      // const CustomField(
                      //   hintText: StringConstants.name,
                      //   fontSize: 11,
                      //   hintTextColor: ColorConstants.greyColor,
                      //   keyboardType: TextInputType.name,
                      // ),
                      CustomField(
                        controller: nameController,
                        // hintText: StringConstants.name,
                        fontSize: 11,
                        // hintTextColor: ColorConstants.blackColor,
                        keyboardType: TextInputType.name,
                        // readonly: true,
                        readonly: false,
                      ),

                      SizedBox(
                        height: 1.5.h,
                      ),
                      const CustomText(
                        text: StringConstants.phonelabel,
                        color: ColorConstants.blackColor,
                        fontSize: 11,
                        weight: FontWeight.w400,
                      ),
                      SizedBox(
                        height: 0.2.h,
                      ),
                      // const CustomField(
                      //   hintText: StringConstants.phone,
                      //   fontSize: 11,
                      //   isPhoneNumber: true,
                      //   hintTextColor: ColorConstants.greyColor,
                      //   keyboardType: TextInputType.phone,
                      // ),
                      Obx(
                        () => CustomField(
                          hintText: StringConstants
                              .phone, // Placeholder for phone input
                          fontSize: 11,
                          isPhoneNumber: true,
                          hintTextColor: ColorConstants.greyColor,
                          selectedCountryCode:
                              authController.selectedCountrycode.value,
                          countryCodes: authController.countryCode,
                          onCountryCodeChanged: (newValue) {
                            authController.setSelectedCountryCode(
                                newValue); // Update country code
                          },
                          onChanged: (newValue) {
                            authController.setPhoneNumber(
                                newValue); // Update phone number
                          },
                          controller: phoneController,
                        ),
                      ),
                      Obx(() => authController.phoneError.value.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: CustomText(
                                text: authController.phoneError.value,
                                color: ColorConstants.errorColor,
                                fontSize: 10,
                                weight: FontWeight.w400,
                              ),
                            )
                          : const SizedBox.shrink()),
                      SizedBox(
                        height: 1.5.h,
                      ),
                      SizedBox(
                        height: 1.5.h,
                      ),
                      const CustomText(
                        text: StringConstants.genderlabel,
                        color: ColorConstants.blackColor,
                        fontSize: 11,
                        weight: FontWeight.w400,
                      ),
                      SizedBox(
                        height: 0.2.h,
                      ),
                      Obx(
                        () => CustomField(
                          hintText: StringConstants.gender,
                          fontSize: 11,
                          isDropdown: true,
                          hintTextColor: ColorConstants.greyColor,
                          genderdropdown: authController.genderDropdownValues,
                          onChanged: (newValue) {
                            authController.setSelectedDropdownItem(newValue);
                          },
                          controller: TextEditingController(
                            text: authController.selectedDropdownItem.value,
                          ),
                        ),
                      ),
                      Obx(
                        () => authController.genderError.value.isNotEmpty
                            ? Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: CustomText(
                                  text: authController.genderError.value,
                                  color: ColorConstants.errorColor,
                                  fontSize: 10,
                                  weight: FontWeight.w400,
                                ),
                              )
                            : SizedBox(height: 1.h),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      CustomButton(
                        label: StringConstants.userBtntext,
                        btnColor: ColorConstants.rich,
                        height: 6.h,
                        fontSize: 14,
                        weight: FontWeight.w500,
                        action: () {
                          authController.submitUserDetails();
                          // Get.toNamed(
                          //   AppRoutes.addressScreen,
                          // );
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
