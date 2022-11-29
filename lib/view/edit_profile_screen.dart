import 'dart:io';

import 'package:expert_parrot_app/Models/apis/api_response.dart';
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
    print('================= > ${GetStorageServices.getUserHeight()}');

    // TODO: implement initState
    super.initState();
    nameController =
        TextEditingController(text: GetStorageServices.getUserBMI());
    heightController =
        TextEditingController(text: GetStorageServices.getUserHeight());
    weightController =
        TextEditingController(text: GetStorageServices.getUserWeight());
    ageController =
        TextEditingController(text: GetStorageServices.getUserBMI());
    // print(
    //     'getIsEmailOrPhone set prof   ${GetStorageServices.getIsEmailOrPhone()}');
    // if (GetStorageServices.getIsEmailOrPhone() != null) {
    //   if (GetStorageServices.getIsEmailOrPhone() == true) {
    //     emailController =
    //         TextEditingController(text: GetStorageServices.getEmail());
    //     mobileController = TextEditingController();
    //   } else {
    //     mobileController =
    //         TextEditingController(text: GetStorageServices.getMobile());
    //     emailController = TextEditingController();
    //   }
    // } else {
    //   mobileController = TextEditingController();
    //   emailController = TextEditingController();
    // } // print(
    //     'getIsEmailOrPhone set prof   ${GetStorageServices.getIsEmailOrPhone()}');
    // if (GetStorageServices.getIsEmailOrPhone() != null) {
    //   if (GetStorageServices.getIsEmailOrPhone() == true) {
    //     emailController =
    //         TextEditingController(text: GetStorageServices.getEmail());
    //     mobileController = TextEditingController();
    //   } else {
    //     mobileController =
    //         TextEditingController(text: GetStorageServices.getMobile());
    //     emailController = TextEditingController();
    //   }
    // } else {
    //   mobileController = TextEditingController();
    //   emailController = TextEditingController();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CommonWidget.commonBackGround(
          body: Column(
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
                    image: DecorationImage(
                      image: AssetImage('assets/png/person.png'),
                    )),
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
                // border: OutlineInputBorder(
                //   borderRadius: BorderRadius.circular(5.0),
                //   borderSide: const BorderSide(
                //       color: ConstColors.widgetDividerColor, width: 1.0),
                // ),
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

              if (image != null ||
                  nameController!.text.isNotEmpty &&
                      heightController!.text.isNotEmpty) {
                var _req = {
                  "name": "${nameController!.text}",
                  "height": "${heightController!.text.trim()}",
                  "weight": "${weightController!.text.trim()}",
                  "Age": "${ageController!.text.trim()}",
                  "image": "$image"
                };

                editProfileViewModel.editProfileViewModel(model: _req);

                if (editProfileViewModel.editProfileApiResponse.status ==
                    Status.COMPLETE) {
                  print('complete');
                }
                if (editProfileViewModel.editProfileApiResponse.status ==
                    Status.ERROR) {}
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

    setState(() {});
  }

// Widget _body() {
  //   var width = MediaQuery.of(context).size.width;
  //   var safearea = MediaQuery.of(context).padding.top;
  //
  //   return ProgressHUD(child: Builder(
  //     builder: (context) {
  //       final progress = ProgressHUD.of(context);
  //
  //       return SingleChildScrollView(
  //         child: Container(
  //           child: Column(
  //             mainAxisSize: MainAxisSize.max,
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: <Widget>[
  //               SizedBox(
  //                 height: 10,
  //               ),
  //               Container(
  //                 margin: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
  //                 child: Text(
  //                   "Profile",
  //                   style: GoogleFonts.urbanist(
  //                       fontWeight: FontWeight.w700,
  //                       fontSize: 26.0,
  //                       color: Colors.black),
  //                 ),
  //               ),
  //               Stack(
  //                 alignment: Alignment.bottomRight,
  //                 children: [
  //                   Container(
  //                     height: 150,
  //                     width: 150,
  //                     decoration: BoxDecoration(
  //                         shape: BoxShape.circle,
  //                         color: Colors.grey.withOpacity(0.5)),
  //                     child: image == null
  //                         ? Icon(
  //                       color: Colors.grey,
  //                       Icons.person,
  //                       size: 120,
  //                     )
  //                         : ClipRRect(
  //                         borderRadius: BorderRadius.circular(500),
  //                         child: Image.file(image!, fit: BoxFit.cover)),
  //                   ),
  //                   Positioned(
  //                     //bottom: 20,
  //                     right: 10,
  //                     child: CircleAvatar(
  //                         backgroundColor: ConstColors.darkColor,
  //                         child: IconButton(
  //                             onPressed: () {
  //                               showDialogWidget();
  //                             },
  //                             icon: Icon(
  //                               Icons.edit,
  //                               color: Colors.white,
  //                             ))),
  //                   )
  //                 ],
  //               ),
  //               SizedBox(
  //                 height: 20,
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.symmetric(horizontal: 16),
  //                 child: Align(
  //                   alignment: Alignment.centerLeft,
  //                   child: CommonWidget.textBoldWight500(text: 'User Name'),
  //                 ),
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.all(16.0),
  //                 child: TextField(
  //                   controller: nameController,
  //                   decoration: InputDecoration(
  //                     contentPadding: const EdgeInsets.all(8.0),
  //                     hintText: 'User Name',
  //                     // border: OutlineInputBorder(
  //                     //   borderRadius: BorderRadius.circular(5.0),
  //                     //   borderSide: const BorderSide(
  //                     //       color: ConstColors.widgetDividerColor, width: 1.0),
  //                     // ),
  //                     enabledBorder: OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(5.0),
  //                       borderSide:
  //                       BorderSide(color: Colors.grey.shade300, width: 1.5),
  //                     ),
  //                     focusedBorder: OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(5.0),
  //                       borderSide:
  //                       BorderSide(color: themColors309D9D, width: 1.5),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.symmetric(horizontal: 16),
  //                 child: Align(
  //                   alignment: Alignment.centerLeft,
  //                   child: CommonWidget.textBoldWight500(text: 'Full Name'),
  //                 ),
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.all(16.0),
  //                 child: TextField(
  //                   controller: fullNameController,
  //                   decoration: InputDecoration(
  //                     contentPadding: const EdgeInsets.all(8.0),
  //                     hintText: 'Full Name',
  //                     enabledBorder: OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(5.0),
  //                       borderSide:
  //                       BorderSide(color: Colors.grey.shade300, width: 1.5),
  //                     ),
  //                     focusedBorder: OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(5.0),
  //                       borderSide:
  //                       BorderSide(color: themColors309D9D, width: 1.5),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.symmetric(horizontal: 16),
  //                 child: Align(
  //                   alignment: Alignment.centerLeft,
  //                   child: CommonWidget.textBoldWight500(text: 'Email'),
  //                 ),
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.all(16.0),
  //                 child: TextField(
  //                   controller: emailController,
  //                   decoration: InputDecoration(
  //                     contentPadding: const EdgeInsets.all(8.0),
  //                     hintText: 'Email',
  //                     enabledBorder: OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(5.0),
  //                       borderSide:
  //                       BorderSide(color: Colors.grey.shade300, width: 1.5),
  //                     ),
  //                     focusedBorder: OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(5.0),
  //                       borderSide:
  //                       BorderSide(color: themColors309D9D, width: 1.5),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.symmetric(horizontal: 16),
  //                 child: Align(
  //                   alignment: Alignment.centerLeft,
  //                   child: CommonWidget.textBoldWight500(text: 'Phone no'),
  //                 ),
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.all(16.0),
  //                 child: TextField(
  //                   controller: mobileController,
  //                   decoration: InputDecoration(
  //                     contentPadding: const EdgeInsets.all(8.0),
  //                     hintText: 'Phone no',
  //                     enabledBorder: OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(5.0),
  //                       borderSide:
  //                       BorderSide(color: Colors.grey.shade300, width: 1.5),
  //                     ),
  //                     focusedBorder: OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(5.0),
  //                       borderSide:
  //                       BorderSide(color: themColors309D9D, width: 1.5),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               InkWell(
  //                 onTap: () async {
  //                   print('enter thg escree ');
  //
  //                   if (image != null ||
  //                       nameController.text.isNotEmpty &&
  //                           fullNameController.text.isNotEmpty) {
  //                     try {
  //                       print('enter thg escree ');
  //                       progress!.show();
  //                       if (image != null) {
  //                         var snapshot = await FirebaseStorage.instance
  //                             .ref()
  //                             .child(
  //                             'AllUserImage/${DateTime.now().microsecondsSinceEpoch}')
  //                             .putFile(image!);
  //                         liveImageURL = await snapshot.ref.getDownloadURL();
  //                       } else {
  //                         liveImageURL = '';
  //                       }
  //                       await FirebaseFirestore.instance
  //                           .collection('All_User_Details')
  //                           .doc(GetStorageServices.getToken())
  //                           .update({
  //                         'profile_image': liveImageURL,
  //                         'user_name': nameController.text.toString(),
  //                         'is_Profile_check': true,
  //                         'email': emailController!.text.isNotEmpty
  //                             ? emailController!.text.trim().toString()
  //                             : '',
  //                         'phone_no': mobileController!.text.isNotEmpty
  //                             ? mobileController!.text.trim().toString()
  //                             : '',
  //                         'full_name': fullNameController.text.toString(),
  //                       });
  //
  //                       CommonMethode.setProfileAllDetails(
  //                           uid: await FirebaseAuth.instance.currentUser!.uid,
  //                           fullName: fullNameController.text.toString(),
  //                           email: emailController!.text.trim(),
  //                           mobile: mobileController!.text.trim(),
  //                           imageUrl: liveImageURL!,
  //                           name: nameController.text.toString());
  //                       Navigator.pushAndRemoveUntil(
  //                         context,
  //                         MaterialPageRoute(
  //                             builder: (context) => const MyLocation()),
  //                             (Route<dynamic> route) => false,
  //                       );
  //                       progress.dismiss();
  //                     } catch (e) {
  //                       progress!.dismiss();
  //
  //                       return CommonWidget.getSnackBar(
  //                           message: 'went-wrong',
  //                           title: 'Failed',
  //                           duration: 2,
  //                           color: Colors.red);
  //                     }
  //                   } else {
  //                     CommonWidget.getSnackBar(
  //                         message: 'All fields are required',
  //                         title: 'Required',
  //                         duration: 2,
  //                         color: Colors.red);
  //                   }
  //                 },
  //                 child: Container(
  //                   height: 40,
  //                   decoration: BoxDecoration(
  //                       color: ConstColors.darkColor,
  //                       borderRadius: BorderRadius.circular(10)),
  //                   margin: const EdgeInsets.all(10.0),
  //                   child: Center(
  //                     child: Text(
  //                       'Next',
  //                       style: TextStyle(color: Colors.white, fontSize: 16),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               SizedBox(
  //                 height: 20,
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   ));
  // }
  //
  // imageUpload() async {
  //   var snapshot = await FirebaseStorage.instance
  //       .ref()
  //       .child('AllUserImage/${DateTime.now().microsecondsSinceEpoch}')
  //       .putFile(image!);
  //   liveImageURL = await snapshot.ref.getDownloadURL();
  // }
  //
  // showDialogWidget() {
  //   return showDialog(
  //       context: context,
  //       builder: (_) => SimpleDialog(
  //         children: [
  //           Column(
  //             children: [
  //               InkWell(
  //                 onTap: () async {
  //                   Navigator.of(context).pop();
  //                   await imageFromGallery();
  //                 },
  //                 child: Container(
  //                   height: 40,
  //                   width: 160,
  //                   decoration: BoxDecoration(
  //                       color: ConstColors.darkColor,
  //                       borderRadius: BorderRadius.circular(16)),
  //                   margin: const EdgeInsets.all(10.0),
  //                   child: Center(
  //                     child: Text(
  //                       'Gallery',
  //                       style: TextStyle(color: Colors.white, fontSize: 16),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               InkWell(
  //                 onTap: () async {
  //                   Navigator.of(context).pop();
  //                   await imageFromCamera();
  //                 },
  //                 child: Container(
  //                   height: 40,
  //                   width: 160,
  //                   decoration: BoxDecoration(
  //                       color: ConstColors.darkColor,
  //                       borderRadius: BorderRadius.circular(16)),
  //                   margin: const EdgeInsets.all(10.0),
  //                   child: Center(
  //                     child: Text(
  //                       'Camera',
  //                       style: TextStyle(color: Colors.white, fontSize: 16),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           )
  //         ],
  //       ));
  // }
  //
  // imageFromGallery() async {
  //   final ImagePicker _picker = ImagePicker();
  //   final XFile? pickImage =
  //   await _picker.pickImage(source: ImageSource.gallery);
  //   image = File(pickImage!.path);
  //   setState(() {});
  // }
  //
  // imageFromCamera() async {
  //   final ImagePicker _picker = ImagePicker();
  //   final XFile? pickImage =
  //   await _picker.pickImage(source: ImageSource.camera);
  //   image = File(pickImage!.path);
  //   setState(() {});
  // }

}
