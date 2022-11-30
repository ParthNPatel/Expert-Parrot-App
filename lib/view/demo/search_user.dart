import 'package:expert_parrot_app/Models/apis/api_response.dart';
import 'package:expert_parrot_app/Models/responseModel/gte_search_user_res_model.dart';
import 'package:expert_parrot_app/components/common_widget.dart';
import 'package:expert_parrot_app/view/demo/get_req_user_screen.dart';
import 'package:expert_parrot_app/viewModel/get_search_user_view_model.dart';
import 'package:expert_parrot_app/viewModel/send_request_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            TextButton(
              onPressed: () {
                Get.to(() => RequestUserScreen());
              },
              child: Text('Show Request'),
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.sp),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: search,
                      onChanged: (val) async {
                        await getSearchUserViewModel.getSearchUserViewModel(
                            name: '${search.text.trim()}');
                      },
                      decoration: InputDecoration(
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
                      child: Icon(Icons.search),
                    ),
                  ),
                ],
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
                      return ListView.builder(
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
                                    title: const Text("Enter Relation"),
                                    content: TextField(
                                      controller: relation,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(),
                                        enabledBorder: OutlineInputBorder(),
                                        hintText: 'Relation',
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () async {
                                          await sendReqViewModel
                                              .sendReqViewModel(model: {
                                            "userId":
                                                "${getSearchRes.data![index].id}",
                                            "relation":
                                                "${relation.text.trim()}"
                                          });
                                          relation.clear();

                                          if (sendReqViewModel
                                                  .sendReqApiResponse.status ==
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
                                                  .sendReqApiResponse.status ==
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
                                        child: Container(
                                          color: Colors.green,
                                          padding: const EdgeInsets.all(14),
                                          child: const Text(
                                            "Send",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(ctx).pop();
                                        },
                                        child: Container(
                                          color: Colors.green,
                                          padding: const EdgeInsets.all(14),
                                          child: const Text(
                                            "Back",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
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
        ),
      ),
    );
  }
}
