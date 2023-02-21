import 'dart:io';
import 'dart:math';

import 'package:expert_parrot_app/components/common_widget.dart';
import 'package:expert_parrot_app/constant/color_const.dart';
import 'package:expert_parrot_app/constant/text_styel.dart';
import 'package:expert_parrot_app/get_storage_services/get_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

import '../Models/repo/edit_profile_repo.dart';

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

  String? liveImageURL;

  bool isSignIn = false;
  bool google = false;
  File? image;

  @override
  void initState() {
    print('GetStorageServices.getAge()  ${GetStorageServices.getAge()}');
    print(
        'GetStorageServices.getUserImage()  ${GetStorageServices.getUserImage()}');
    print(
        'GetStorageServices.getUserHeight()  ${GetStorageServices.getUserHeight()}');
    print(
        'GetStorageServices.getUserWeight()  ${GetStorageServices.getUserWeight()}');
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
          body: Column(
        mainAxisSize: MainAxisSize.max,
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
                ),
                child: showImageWidget(),
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
              child: Text('Height (cm)'),
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
              child: Text('Weight (kg)'),
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

              if (nameController!.text.isNotEmpty &&
                  heightController!.text.isNotEmpty &&
                  weightController!.text.isNotEmpty &&
                  ageController!.text.isNotEmpty) {
                var _req;
                if (image != null) {
                  _req = {
                    "name": "${nameController!.text.toString()}",
                    "height": "${heightController!.text.toString().trim()}",
                    "userImage": "${image!.path}",
                    "age": "${ageController!.text.toString().trim()}",
                    "weight": "${weightController!.text.toString().trim()}",
                  };
                } else {
                  _req = {
                    "name": nameController!.text.toString(),
                    "height": heightController!.text.toString().trim(),
                    "age": ageController!.text.toString().trim(),
                    "weight": weightController!.text.toString().trim(),
                    "userTime": "${DateTime.now()}",
                  };
                }

                await EditProfileRepo.editProfileRepo(
                    model: _req, isEdit: true);

                double weight = double.parse(weightController!.text);
                double height = double.parse(heightController!.text);

                var bmi = await weight / pow((height / 100), 2);

                GetStorageServices.setUserBMI(bmi.toStringAsFixed(1));
              } else {
                CommonWidget.getSnackBar(
                  message: "Please enter all detail",
                  title: 'Failed',
                  duration: 2,
                  color: Colors.red,
                );
              }
            },
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                  color: CommonColor.greenColor,
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
      )),
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
        CommonText.textBoldWight500(text: "Edit Profile", fontSize: 18.sp),
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

  showImageWidget() {
    try {
      return image == null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(500),
              child: Image.network(
                'https://health-app-test.s3.ap-south-1.amazonaws.com/user/${GetStorageServices.getUserImage()}',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Icon(
                  color: Colors.grey,
                  Icons.person,
                  size: 60,
                ),
              ))
          : ClipRRect(
              borderRadius: BorderRadius.circular(500),
              child: Image.file(
                image!,
                fit: BoxFit.cover,
              ));
    } catch (e) {
      return Icon(
        color: Colors.grey,
        Icons.person,
        size: 120,
      );
    }
  }
}
