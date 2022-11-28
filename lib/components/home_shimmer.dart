import 'package:expert_parrot_app/components/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

Widget HomeShimmer() {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade400,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 20,
                  width: 50.w,
                  color: Colors.grey.shade200,
                ),
                Spacer(),
                Container(
                  height: 27,
                  width: 27,
                  color: Colors.grey.shade200,
                ),
                CommonWidget.commonSizedBox(width: 26),
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey.shade200,
                  ),
                ),
              ],
            ),
            CommonWidget.commonSizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey.shade200,
                  ),
                ),
                SizedBox(
                  width: 40,
                ),
                Column(
                  children: [
                    Container(
                      height: 40,
                      width: 100,
                      color: Colors.grey.shade200,
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: 23,
                      width: 80,
                      color: Colors.grey.shade200,
                    ),
                  ],
                ),
                SizedBox(
                  width: 40,
                ),
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey.shade200,
                  ),
                ),
              ],
            ),
            CommonWidget.commonSizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 30,
                  width: 150,
                  color: Colors.grey.shade200,
                ),
                Container(
                  height: 30,
                  width: 150,
                  color: Colors.grey.shade200,
                ),
              ],
            ),
            CommonWidget.commonSizedBox(height: 15),

            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(bottom: 15),
                  height: 108,
                  width: Get.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade200,
                  ),
                );
              },
            ),
            CommonWidget.commonSizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 30,
                  width: 150,
                  color: Colors.grey.shade200,
                ),
              ],
            ),

            /// TITLE
            CommonWidget.commonSizedBox(height: 16),
            GridView.builder(
              itemCount: 4,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 16,
                  crossAxisCount: 2,
                  childAspectRatio: 2 / 1.5),
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(bottom: 15),
                  height: 108,
                  width: Get.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade200,
                  ),
                );
              },
            ),
            CommonWidget.commonSizedBox(height: 30),

            Container(
              height: 280,
              width: 280,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.shade200,
              ),
            )
          ],
        ),
      ),
    ),
  );
}
