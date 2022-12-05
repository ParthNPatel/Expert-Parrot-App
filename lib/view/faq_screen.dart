import 'dart:developer';

import 'package:dotted_line/dotted_line.dart';
import 'package:expert_parrot_app/Models/apis/api_response.dart';
import 'package:expert_parrot_app/Models/responseModel/all_faq_category_res_model.dart';
import 'package:expert_parrot_app/Models/responseModel/get_faq_res_model.dart';
import 'package:expert_parrot_app/components/common_widget.dart';
import 'package:expert_parrot_app/constant/color_const.dart';
import 'package:expert_parrot_app/constant/image_const.dart';
import 'package:expert_parrot_app/constant/text_const.dart';
import 'package:expert_parrot_app/constant/text_styel.dart';
import 'package:expert_parrot_app/viewModel/add_faq_view_model.dart';
import 'package:expert_parrot_app/viewModel/all_faq_category_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({Key? key}) : super(key: key);

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  List<String> menu = ['General', 'Account', 'Service', 'Application'];
  int selectMenu = 0;
  bool value = false;
  TextEditingController search = TextEditingController();

  AllFaqCategoryViewModel allFaqCategoryViewModel =
      Get.put(AllFaqCategoryViewModel());

  GetFaqViewModel getFaqViewModel = Get.put(GetFaqViewModel());

  @override
  void initState() {
    super.initState();
    apiCall();
  }

  apiCall() async {
    await allFaqCategoryViewModel.allFaqCategoryViewModel();

    AllFaqCategoryResponseModel resp =
        allFaqCategoryViewModel.allFaqCategoryApiResponse.data;

    getFaqViewModel.getFaqViewModel(id: resp.data![0].sId!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CommonWidget.commonBackGround(
        body: Center(
          child: Column(
            children: [
              CommonWidget.faqHeader(
                  backOnTap: () {
                    Get.back();
                  },
                  addOnTap: () {},
                  titleText: TextConst.faq),
              CommonWidget.commonSizedBox(height: 13),
              DottedLine(
                lineLength: double.infinity,
                lineThickness: 1.0,
                dashLength: 10.0,
                dashColor: Color(0xffbac2ba),
                dashRadius: 0.0,
                dashGapLength: 6.0,
                dashGapColor: Colors.transparent,
                dashGapRadius: 0.0,
              ),
              CommonWidget.commonSizedBox(height: 27.sp),
              GetBuilder<AllFaqCategoryViewModel>(builder: (controller) {
                if (controller.allFaqCategoryApiResponse.status ==
                    Status.ERROR) {
                  return Center(
                    child: CircularProgressIndicator(
                        color: CommonColor.greenColor),
                  );
                }

                if (controller.allFaqCategoryApiResponse.status ==
                    Status.COMPLETE) {
                  AllFaqCategoryResponseModel response =
                      controller.allFaqCategoryApiResponse.data;

                  return SizedBox(
                    height: 5.h,
                    child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemCount: response.data!.length,
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index) {
                          return SizedBox(width: 5.w);
                        },
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () async {
                              setState(() {
                                selectMenu = index;
                              });

                              await getFaqViewModel.getFaqViewModel(
                                  id: response.data![index].sId!);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.sp, vertical: 8.sp),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100.h),
                                color: selectMenu == index
                                    ? CommonColor.greenColor
                                    : Colors.transparent,
                                border: Border.all(
                                  color: CommonColor.greenColor,
                                ),
                              ),
                              child: CommonText.textBoldWight600(
                                  text:
                                      '${response.data![index].name.toString().capitalizeFirst}',
                                  color: selectMenu == index
                                      ? CommonColor.whiteColorEDEDED
                                      : CommonColor.blackColor0D0D0D),
                            ),
                          );
                        }),
                  );
                }

                return SizedBox();
              }),
              CommonWidget.commonSizedBox(height: 20.sp),
              CommonWidget.textFormField(
                borderColor: Colors.transparent,
                controller: search,
                hintText: 'Search',
                prefix: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(ImageConst.search),
                  ],
                ),
                suffix: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(ImageConst.filter),
                  ],
                ),
              ),
              CommonWidget.commonSizedBox(height: 20.sp),
              Expanded(
                child: GetBuilder<GetFaqViewModel>(builder: (controller) {
                  if (controller.getFaqApiResponse.status == Status.LOADING) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: CommonColor.greenColor,
                      ),
                    );
                  }
                  if (controller.getFaqApiResponse.status == Status.COMPLETE) {
                    GetFaqResponseModel response =
                        controller.getFaqApiResponse.data;
                    return ListView.builder(
                      itemCount: response.data!.length,
                      itemBuilder: (context, index) {
                        return Column(children: [
                          Container(
                            width: Get.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.sp),
                            ),
                            child: Theme(
                              data: Theme.of(context)
                                  .copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                textColor: CommonColor.blackColor0D0D0D,
                                collapsedTextColor:
                                    CommonColor.blackColor0D0D0D,
                                iconColor: Colors.white,
                                onExpansionChanged: (val) {
                                  setState(() {
                                    value = val;
                                  });
                                  log('VALUE $value');
                                },
                                trailing: value == false
                                    ? Transform.rotate(
                                        angle: 3.1,
                                        child:
                                            SvgPicture.asset(ImageConst.arrow))
                                    : SvgPicture.asset(ImageConst.arrow),
                                collapsedIconColor: Colors.white,
                                childrenPadding: EdgeInsets.only(
                                    left: 10.sp, right: 10.sp, bottom: 10.sp),
                                children: [
                                  Divider(
                                      thickness: 1,
                                      color: Colors.grey.shade200,
                                      indent: 2.w,
                                      endIndent: 2.w),
                                  CommonText.textBoldWight500(
                                      text: "${response.data![index].answer}",
                                      fontSize: 14),
                                ],
                                title: CommonText.textBoldWight500(
                                  text: '${response.data![index].question}',
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 24.sp,
                          )
                        ]);
                      },
                    );
                  }
                  return SizedBox();
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
