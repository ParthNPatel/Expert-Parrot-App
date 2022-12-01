import 'package:dotted_line/dotted_line.dart';
import 'package:expert_parrot_app/Models/apis/api_response.dart';
import 'package:expert_parrot_app/Models/responseModel/gte_search_user_res_model.dart';
import 'package:expert_parrot_app/components/common_widget.dart';
import 'package:expert_parrot_app/constant/color_const.dart';
import 'package:expert_parrot_app/constant/image_const.dart';
import 'package:expert_parrot_app/constant/text_const.dart';
import 'package:expert_parrot_app/constant/text_styel.dart';
import 'package:expert_parrot_app/viewModel/get_search_user_view_model.dart';
import 'package:expert_parrot_app/viewModel/send_request_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'get_req_user_screen.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController search = TextEditingController();
  TextEditingController relation = TextEditingController();
  GetSearchUserViewModel getSearchUserViewModel =
      Get.put(GetSearchUserViewModel());
  SendReqViewModel sendReqViewModel = Get.put(SendReqViewModel());

  @override
  void initState() {
    getSearchUserViewModel.getSearchUserViewModel(name: '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,
        //   elevation: 0,
        //   actions: [
        //     TextButton(
        //       onPressed: () {
        //         Get.to(() => RequestUserScreen());
        //       },
        //       child: Text('Show Request'),
        //     )
        //   ],
        // ),
        body: CommonWidget.commonBackGround(
      body: Column(
        children: [
          CommonWidget.header(
              backOnTap: () {
                Get.back();
              },
              addOnTap: () {
                Get.to(() => RequestUserScreen());
              },
              titleText: TextConst.dependentSearch),
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
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 35.sp,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: search,
                    onChanged: (val) async {
                      await getSearchUserViewModel.getSearchUserViewModel(
                          name: '${search.text.trim()}');
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10, bottom: 9),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.sp,
                ),
                InkResponse(
                  onTap: () async {
                    await getSearchUserViewModel.getSearchUserViewModel(
                        name: '${search.text.trim()}');
                  },
                  child: CircleAvatar(
                    radius: 20.sp,
                    child: Icon(Icons.search, color: Colors.white),
                    backgroundColor: CommonColor.greenColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.sp,
          ),
          Expanded(
            child: GetBuilder<GetSearchUserViewModel>(
              builder: (controller) {
                if (controller.getUserResponse.status == Status.LOADING) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (controller.getUserResponse.status == Status.COMPLETE) {
                  GetSearchUserResponseModel getSearchRes =
                      controller.getUserResponse.data;

                  return search.text.isEmpty
                      ? ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: getSearchRes.data!.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(
                                    'https://wallpapercave.com/dwp1x/wp4376818.jpg'),
                              ),
                              title: Text('${getSearchRes.data![index].name}'),
                              trailing: IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CommonText.textBoldWight500(
                                            text: "Enter Relation",
                                            fontSize: 17.sp,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Get.back();
                                            },
                                            child:
                                                CommonWidget.commonSvgPitcher(
                                              image: ImageConst.close,
                                            ),
                                          )
                                        ],
                                      ),
                                      // const Text("Enter Relation"),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          CommonWidget.dottedLineWidget(),
                                          SizedBox(height: 20),
                                          TextField(
                                            controller: relation,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              focusedBorder:
                                                  OutlineInputBorder(),
                                              enabledBorder:
                                                  OutlineInputBorder(),
                                              hintText: 'Relation',
                                            ),
                                          ),
                                        ],
                                      ),
                                      actions: <Widget>[
                                        SizedBox(
                                          height: 6.5.h,
                                          width: 25.w,
                                          child: CommonWidget.commonButton(
                                              color: CommonColor.greenColor,
                                              radius: 10,
                                              onTap: () async {
                                                await sendReqViewModel
                                                    .sendReqViewModel(model: {
                                                  "userId":
                                                      "${getSearchRes.data![index].id}",
                                                  "relation":
                                                      "${relation.text.trim()}"
                                                });
                                                relation.clear();

                                                if (sendReqViewModel
                                                        .sendReqApiResponse
                                                        .status ==
                                                    Status.COMPLETE) {
                                                  Get.back();
                                                  CommonWidget.getSnackBar(
                                                    message:
                                                        'Request send successfully',
                                                    title: 'Successfully',
                                                    duration: 2,
                                                    color: Colors.green,
                                                  );
                                                }
                                                if (sendReqViewModel
                                                        .sendReqApiResponse
                                                        .status ==
                                                    Status.ERROR) {
                                                  Get.back();
                                                  CommonWidget.getSnackBar(
                                                    message: 'Try Again...',
                                                    title: 'Failed',
                                                    duration: 2,
                                                    color: Colors.red,
                                                  );
                                                }
                                              },
                                              text: "Send"),
                                        ),
                                        SizedBox(
                                          height: 6.5.h,
                                          width: 25.w,
                                          child: CommonWidget.commonButton(
                                              color: CommonColor.greenColor,
                                              radius: 10,
                                              onTap: () {
                                                Navigator.of(ctx).pop();
                                              },
                                              text: "Back"),
                                        )

                                        // TextButton(
                                        //   onPressed: () {
                                        //     Navigator.of(ctx).pop();
                                        //   },
                                        //   child: Container(
                                        //     color: Colors.green,
                                        //     padding: const EdgeInsets.all(14),
                                        //     child: const Text(
                                        //       "Back",
                                        //       style: TextStyle(
                                        //         color: Colors.white,
                                        //       ),
                                        //     ),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  );
                                },
                                icon: Icon(Icons.add),
                              ),
                            );
                          },
                        )
                      : ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: getSearchRes.data!.length <= 8
                              ? getSearchRes.data!.length
                              : 8,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(
                                    'https://wallpapercave.com/dwp1x/wp4376818.jpg'),
                              ),
                              title: Text('${getSearchRes.data![index].name}'),
                              trailing: IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                      title: const Text("Enter Relation"),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          CommonWidget.dottedLineWidget(),
                                          SizedBox(height: 20),
                                          TextField(
                                            controller: relation,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              focusedBorder:
                                                  OutlineInputBorder(),
                                              enabledBorder:
                                                  OutlineInputBorder(),
                                              hintText: 'Relation',
                                            ),
                                          ),
                                        ],
                                      ),
                                      actions: <Widget>[
                                        SizedBox(
                                          height: 6.5.h,
                                          width: 25.w,
                                          child: CommonWidget.commonButton(
                                              color: CommonColor.greenColor,
                                              radius: 10,
                                              onTap: () async {
                                                await sendReqViewModel
                                                    .sendReqViewModel(model: {
                                                  "userId":
                                                      "${getSearchRes.data![index].id}",
                                                  "relation":
                                                      "${relation.text.trim()}"
                                                });
                                                relation.clear();

                                                if (sendReqViewModel
                                                        .sendReqApiResponse
                                                        .status ==
                                                    Status.COMPLETE) {
                                                  Get.back();
                                                  CommonWidget.getSnackBar(
                                                    message:
                                                        'Request send successfully',
                                                    title: 'Successfully',
                                                    duration: 2,
                                                    color: Colors.green,
                                                  );
                                                }
                                                if (sendReqViewModel
                                                        .sendReqApiResponse
                                                        .status ==
                                                    Status.ERROR) {
                                                  Get.back();
                                                  CommonWidget.getSnackBar(
                                                    message: 'Try Again...',
                                                    title: 'Failed',
                                                    duration: 2,
                                                    color: Colors.red,
                                                  );
                                                }
                                              },
                                              text: "Send"),
                                        ),
                                        SizedBox(
                                          height: 6.5.h,
                                          width: 25.w,
                                          child: CommonWidget.commonButton(
                                              color: CommonColor.greenColor,
                                              radius: 10,
                                              onTap: () {
                                                Navigator.of(ctx).pop();
                                              },
                                              text: "Back"),
                                        )

                                        // TextButton(
                                        //   onPressed: () {
                                        //     Navigator.of(ctx).pop();
                                        //   },
                                        //   child: Container(
                                        //     color: Colors.green,
                                        //     padding: const EdgeInsets.all(14),
                                        //     child: const Text(
                                        //       "Back",
                                        //       style: TextStyle(
                                        //         color: Colors.white,
                                        //       ),
                                        //     ),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  );
                                },
                                icon: Icon(Icons.add),
                              ),
                            );
                          },
                        );
                }
                return SizedBox();
              },
            ),
          ),
        ],
      ),
    ));
  }
}
