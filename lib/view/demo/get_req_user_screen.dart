import 'package:expert_parrot_app/Models/apis/api_response.dart';
import 'package:expert_parrot_app/Models/responseModel/get_req_user_res_model.dart';
import 'package:expert_parrot_app/components/common_widget.dart';
import 'package:expert_parrot_app/constant/color_const.dart';
import 'package:expert_parrot_app/constant/text_styel.dart';
import 'package:expert_parrot_app/get_storage_services/get_storage_service.dart';
import 'package:expert_parrot_app/viewModel/accept_req_view_model.dart';
import 'package:expert_parrot_app/viewModel/get_req_user_view_model.dart';
import 'package:expert_parrot_app/viewModel/reject_req_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../constant/image_const.dart';

class RequestUserScreen extends StatefulWidget {
  const RequestUserScreen({Key? key}) : super(key: key);

  @override
  State<RequestUserScreen> createState() => _RequestUserScreenState();
}

class _RequestUserScreenState extends State<RequestUserScreen> {
  GetRequestUserViewModel getRequestUserViewModel =
      Get.put(GetRequestUserViewModel());

  AcceptRequestViewModel acceptRequestViewModel =
      Get.put(AcceptRequestViewModel());
  RejectRequestViewModel rejectRequestViewModel =
      Get.put(RejectRequestViewModel());
  @override
  void initState() {
    getRequestUserViewModel.getRequestUserViewModel(isLoading: true);
    super.initState();

    print(
        '=============================== > ${GetStorageServices.getBarrierToken()}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommonWidget.commonBackGround(
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 10,
            ),
            header(),
            SizedBox(
              height: 13,
            ),
            CommonWidget.dottedLineWidget(),
            SizedBox(
              height: 23,
            ),
            GetBuilder<GetRequestUserViewModel>(
              builder: (controller) {
                if (controller.getReqUserResponse.status == Status.LOADING) {
                  return CircularProgressIndicator();
                }
                if (controller.getReqUserResponse.status == Status.COMPLETE) {
                  GetReqResponseModel getReq =
                      controller.getReqUserResponse.data;
                  return getReq.data!.length == 0
                      ? CommonText.textBoldWight500(
                          text: "No pending requests", fontSize: 12.sp)
                      : ListView.separated(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: getReq.data!.length,
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 10),
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.symmetric(horizontal: 13.sp),
                              height: 45.sp,
                              decoration: BoxDecoration(
                                  color:
                                      CommonColor.greenColor.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(18)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 20,
                                        backgroundImage: NetworkImage(
                                            'https://wallpapercave.com/dwp1x/wp4376818.jpg'),
                                      ),
                                      SizedBox(width: 10.sp),
                                      Text(
                                        '${getReq.data![index].requestor!.name}',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                          height: 23.sp,
                                          width: 23.sp,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.grey
                                                    .withOpacity(0.3),
                                              ),
                                              color: CommonColor.greenColor
                                                  .withOpacity(0.35),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: IconButton(
                                            icon: SvgPicture.asset(
                                                ImageConst.add,
                                                color: Colors.white),
                                            onPressed: () async {
                                              await acceptRequestViewModel
                                                  .acceptRequestViewModel(
                                                      model: {
                                                    "userId":
                                                        "${getReq.data![index].requestor!.id}"
                                                  });
                                              if (acceptRequestViewModel
                                                      .acceptReqUserResponse
                                                      .status ==
                                                  Status.COMPLETE) {
                                                CommonWidget.getSnackBar(
                                                  message:
                                                      'Request accepted successfully!',
                                                  title: 'Accept',
                                                  duration: 2,
                                                  color: Colors.green,
                                                );
                                              }
                                              if (acceptRequestViewModel
                                                      .acceptReqUserResponse
                                                      .status ==
                                                  Status.ERROR) {
                                                CommonWidget.getSnackBar(
                                                  message: 'Try Again...',
                                                  title: 'Failed',
                                                  duration: 2,
                                                  color: Colors.red,
                                                );
                                              }
                                              await getRequestUserViewModel
                                                  .getRequestUserViewModel(
                                                      isLoading: false);
                                            },
                                          )),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Container(
                                          height: 23.sp,
                                          width: 23.sp,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.grey
                                                    .withOpacity(0.3),
                                              ),
                                              color:
                                                  Colors.red.withOpacity(0.7),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: IconButton(
                                            icon: Transform(
                                              alignment:
                                                  FractionalOffset.center,
                                              transform: Matrix4.identity()
                                                ..rotateZ(45 * 3.1415927 / 180),
                                              child: SvgPicture.asset(
                                                ImageConst.add,
                                                color: Colors.white,
                                              ),
                                            ),
                                            onPressed: () async {
                                              await rejectRequestViewModel
                                                  .rejectRequestViewModel(
                                                      model: {
                                                    "userId":
                                                        "${getReq.data![index].requestor!.id}"
                                                  });
                                              if (rejectRequestViewModel
                                                      .rejectReqUserResponse
                                                      .status ==
                                                  Status.COMPLETE) {
                                                CommonWidget.getSnackBar(
                                                  message:
                                                      'Request rejected successfully!',
                                                  title: 'Reject',
                                                  duration: 2,
                                                  color: Colors.red,
                                                );
                                              }
                                              if (rejectRequestViewModel
                                                      .rejectReqUserResponse
                                                      .status ==
                                                  Status.ERROR) {
                                                CommonWidget.getSnackBar(
                                                  message: 'Try Again...',
                                                  title: 'Failed',
                                                  duration: 2,
                                                  color: Colors.red,
                                                );
                                              }
                                              await getRequestUserViewModel
                                                  .getRequestUserViewModel(
                                                      isLoading: false);
                                            },
                                          )),
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        );
                }
                return SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }

  Row header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CommonWidget.commonBackButton(
          onTap: () {
            Get.back();
          },
        ),
        CommonText.textBoldWight500(text: "Manage Requests", fontSize: 18.sp),
        CommonWidget.commonSizedBox(height: 30.sp, width: 30.sp)
      ],
    );
  }
}
