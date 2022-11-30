import 'dart:io';

import 'package:expert_parrot_app/Models/apis/api_response.dart';
import 'package:expert_parrot_app/Models/responseModel/edit_profile_res_model.dart';
import 'package:expert_parrot_app/components/common_widget.dart';
import 'package:expert_parrot_app/constant/color_const.dart';
import 'package:expert_parrot_app/constant/text_styel.dart';
import 'package:expert_parrot_app/get_storage_services/get_storage_service.dart';
import 'package:expert_parrot_app/viewModel/edit_profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _EditProfileScreenState();
  }
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController? nameController;
  TextEditingController? heightController;
  TextEditingController? weightController;
  TextEditingController? ageController;

  EditProfileViewModel editProfileViewModel = Get.put(EditProfileViewModel());

  String? liveImageURL;

  bool isSignIn = false;
  bool google = false;
  File? image;

  @override
  void initState() {
    super.initState();
    nameController =
        TextEditingController(text: GetStorageServices.getUserName());
    heightController = TextEditingController(
        text: GetStorageServices.getUserHeight().toString());
    weightController = TextEditingController(
        text: GetStorageServices.getUserWeight().toString());
    ageController =
        TextEditingController(text: GetStorageServices.getAge().toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CommonWidget.commonBackGround(
          body: GetBuilder<EditProfileViewModel>(builder: (controller) {
        return Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            header(),
            SizedBox(
              height: 7,
            ),
            CommonWidget.dottedLineWidget(),
            SizedBox(
              height: 10,
            ),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.withOpacity(0.5),
                      border: Border.all(color: Colors.black),
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://health-app-test.s3.ap-south-1.amazonaws.com/user/' +
                                  '${GetStorageServices.getUserImage()}'),
                          fit: BoxFit.cover)),
                ),
                Positioned(
                  //bottom: 20,
                  // right: 10,
                  child: CircleAvatar(
                      backgroundColor: CommonColor.blackButtonColor1E232C,
                      radius: 15,
                      child: IconButton(
                          onPressed: () {
                            Get.dialog(AlertDialog(
                                content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      getImage(ImageSource.camera);
                                      Get.back();
                                    },
                                    child: Text("Camera")),
                                ElevatedButton(
                                    onPressed: () {
                                      getImage(ImageSource.gallery);
                                      Get.back();
                                    },
                                    child: Text("Gallery"))
                              ],
                            )));
                          },
                          icon: Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 15,
                          ))),
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('User Name'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(8.0),
                  hintText: 'User Name',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide:
                        BorderSide(color: Colors.grey.shade300, width: 1.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(width: 1.5),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Height'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                controller: heightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(8.0),
                  hintText: 'Height',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide:
                        BorderSide(color: Colors.grey.shade300, width: 1.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(width: 1.5),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Weight'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                controller: weightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(8.0),
                  hintText: 'Weight',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide:
                        BorderSide(color: Colors.grey.shade300, width: 1.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(width: 1.5),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Age'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                controller: ageController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(8.0),
                  hintText: 'Age',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide:
                        BorderSide(color: Colors.grey.shade300, width: 1.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(width: 1.5),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                print('Enter The Screen');

                // GetStorageServices.setLocalImage(
                //     GetStorageServices.getLocalImage());

                var _req = {
                  "name": nameController!.text.isNotEmpty
                      ? "${nameController!.text}"
                      : "0",
                  "height": heightController!.text.isNotEmpty
                      ? "${heightController!.text.trim()}"
                      : "0",
                  "userImage": image != null && image != ""
                      ? "${image!.path}"
                      : "${GetStorageServices.getLocalImage()}",
                  "age": ageController!.text.isNotEmpty
                      ? "${ageController!.text.trim()}"
                      : "0",
                  "weight": weightController!.text.isNotEmpty
                      ? "${weightController!.text.trim()}"
                      : "0",
                };

                await controller.editProfileViewModel(model: _req);

                if (controller.editProfileApiResponse.status ==
                    Status.COMPLETE) {
                  EditProfileResponseModel response =
                      controller.editProfileApiResponse.data;

                  GetStorageServices.setUserName(response.data!.name!);
                  GetStorageServices.setUserHeight(response.data!.height!);
                  GetStorageServices.setUserWeight(response.data!.weight!);
                  GetStorageServices.setAge(response.data!.age!);
                  GetStorageServices.setUserImage(response.data!.userImage!);

                  print(
                      '=================== > ${GetStorageServices.getUserImage()}');

                  CommonWidget.getSnackBar(
                    message: "Profile edited successfully",
                    title: 'Success',
                    duration: 2,
                    color: CommonColor.greenColor,
                  );
                }

                if (controller.editProfileApiResponse.status == Status.ERROR) {
                  CommonWidget.getSnackBar(
                    message: 'Something went wrong!',
                    title: 'Failed',
                    duration: 2,
                    color: Colors.red,
                  );
                }
              },
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                    color: CommonColor.themColor35C2C1,
                    borderRadius: BorderRadius.circular(10)),
                margin: const EdgeInsets.all(10.0),
                child: Center(
                  child: Text(
                    'Edit',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        );
      })),
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
        Spacer(),
        CommonText.textBoldWight500(text: "Profile", fontSize: 18.sp),
        SizedBox(
          width: 11.w,
        ),
        Spacer(),
      ],
    );
  }

  getImage(ImageSource imageSource) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickImage = await _picker.pickImage(source: imageSource);
    image = File(pickImage!.path);
    print('Image ================ > ${image}');

    // image == null
    //     ? GetStorageServices.setLocalImage(GetStorageServices.getLocalImage())
    //     : GetStorageServices.setLocalImage(image!);

    setState(() {});
  }
}
