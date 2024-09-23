import 'package:ecommerce/Modules/Auth/Widget/custom_text.dart';
import 'package:ecommerce/Modules/Auth/services/api_service.dart';
import 'package:ecommerce/Modules/Home/Widget/banner_widget.dart';
import 'package:ecommerce/Modules/Home/controllers/home_controller.dart';
import 'package:ecommerce/Utils/Constants/asset_constant.dart';
import 'package:ecommerce/Utils/Constants/color_constant.dart';
import 'package:ecommerce/Utils/Constants/string_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:sizer/sizer.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeController homeController = Get.put(HomeController());

  final PageController pageController = PageController();

  List<Map<String, dynamic>> carousalItems = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchCarousal();
  }

  Future<void> _fetchCarousal() async {
    try {
      final carousal = await ApiService.fetchCarousal();
      setState(() {
        carousalItems = carousal;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching carousal: $e');
      setState(() {
        isLoading = false; // Stop loading even on error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.whiteColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: 5.w,
            right: 5.w,
            bottom: 1.5.h,
            top: 5.h,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                        text: StringConstants.location,
                        color: ColorConstants.greyColor,
                        fontSize: 10,
                        weight: FontWeight.w400,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: ColorConstants.rich,
                            size: 16,
                          ),
                          SizedBox(
                            width: 0.5.w,
                          ),
                          SizedBox(
                            height: 2.3.h,
                            width: 32.w,
                            child: Obx(
                              () => DropdownButton<String>(
                                value: homeController.dropdownValue.value,
                                underline: const SizedBox(),
                                icon: const Icon(
                                  Icons.keyboard_arrow_down_outlined,
                                  color: ColorConstants.greyColor,
                                ),
                                iconSize: 5.5.w,
                                elevation: 0,
                                // dropdownColor:
                                //     const Color.fromARGB(150, 0, 0, 0),
                                dropdownColor: ColorConstants.whiteColor,
                                style: const TextStyle(
                                  color: ColorConstants.blackColor,
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w500,
                                ),
                                items: <String>[
                                  StringConstants.location,
                                  StringConstants.dropLoc1,
                                  StringConstants.dropLoc2,
                                ].map<DropdownMenuItem<String>>(
                                  (String value) {
                                    return DropdownMenuItem<String>(
                                      alignment: Alignment.bottomLeft,
                                      value: value,
                                      child: Text(value),
                                    );
                                  },
                                ).toList(),
                                onChanged: (String? newValue) {
                                  homeController.setDropdownValue(newValue!);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Container(
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: ColorConstants.background,
                      border: Border.all(
                          color: ColorConstants.background, width: 1),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      color: ColorConstants.background,
                      iconSize: 4.9.w,
                      icon: const Icon(
                        Icons.notification_important,
                        color: ColorConstants.blackColor,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 1.5.h,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 75.w,
                    height: 5.h,
                    child: TextField(
                      // controller: searchControllers.searchControllers,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.search,
                          color: ColorConstants.rich,
                          size: 28,
                        ),
                        // suffixIcon: const Icon(Bootstrap.sliders2_vertical,
                        //     color: ColorConstants.blackColor),
                        hintText: StringConstants.search,
                        hintStyle: const TextStyle(
                          color: ColorConstants.greyColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          borderSide: const BorderSide(
                            color: ColorConstants.lightGrayColor,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          borderSide: const BorderSide(
                            color: ColorConstants.lightGrayColor,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          borderSide: const BorderSide(
                            color: ColorConstants.lightGrayColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  Container(
                    height: 5.h,
                    decoration: BoxDecoration(
                      color: ColorConstants.rich,
                      border: Border.all(
                          color: ColorConstants.background, width: 1),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      iconSize: 4.9.w,
                      icon: const Icon(
                        Bootstrap.sliders,
                        color: ColorConstants.whiteColor,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              SizedBox(
                height: 16.h,
                width: 100.w,
                child: PageView.builder(
                  itemCount: carousalItems.length,
                  onPageChanged: (index) {
                    homeController.currentPage.value = index;
                  },
                  itemBuilder: (context, index) {
                    final item = carousalItems[index];

                    return BannerWidget(
                      image: AssetConstant.banner2tp,
                      // image: item['image'] ?? AssetConstant.banner1,
                      title: item['title'] ?? 'No Title',
                      subtitle: item['subtitle'] ?? 'No Subtitle',
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
