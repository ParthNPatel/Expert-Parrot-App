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
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

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
                      : ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: getReq.data!.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 20,
                                      backgroundImage: NetworkImage(
                                          'https://wallpapercave.com/dwp1x/wp4376818.jpg'),
                                    ),
                                    SizedBox(
                                      width: 15.sp,
                                    ),
                                    Text(
                                        '${getReq.data![index].requestor!.name}'),
                                    Spacer(),
                                    SizedBox(
                                      height: 6.h,
                                      child: MaterialButton(
                                          color: CommonColor.greenColor,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          onPressed: () async {
                                            await acceptRequestViewModel
                                                .acceptRequestViewModel(model: {
                                              "userId":
                                                  "${getReq.data![index].requestor!.id}"
                                            });
                                            if (acceptRequestViewModel
                                                    .acceptReqUserResponse
                                                    .status ==
                                                Status.COMPLETE) {
                                              CommonWidget.getSnackBar(
                                                message: '',
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
                                          child: CommonText.textBoldWight600(
                                              text: "Accept",
                                              color: Colors.white,
                                              fontSize: 12.sp)),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    SizedBox(
                                      height: 6.h,
                                      child: MaterialButton(
                                          color: Colors.red,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          onPressed: () async {
                                            await rejectRequestViewModel
                                                .rejectRequestViewModel(model: {
                                              "userId":
                                                  "${getReq.data![index].requestor!.id}"
                                            });
                                            if (rejectRequestViewModel
                                                    .rejectReqUserResponse
                                                    .status ==
                                                Status.COMPLETE) {
                                              CommonWidget.getSnackBar(
                                                message: '',
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
                                          child: CommonText.textBoldWight600(
                                              text: "Reject",
                                              color: Colors.white,
                                              fontSize: 12.sp)),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                )
                              ],
                            );
                            // ListTile(
                            // leading: CircleAvatar(
                            //   radius: 20,
                            //   backgroundImage:
                            //       NetworkImage('https://wallpapercave.com/dwp1x/wp4376818.jpg'),
                            // ),
                            // title: Text('}'),
                            // trailing: ElevatedButton(
                            //   onPressed: () {},
                            //   child: Text('Accept'),
                            // ),
                            // );
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
