import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

Widget CommentShimmer() {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade200,
    child: Column(
      children: [
        ...List.generate(
          2,
          (index) => Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey.shade200),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 10,
                        width: Get.width - 300,
                        color: Colors.grey.shade200,
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Container(
                        height: 10,
                        width: Get.width - 200,
                        color: Colors.grey.shade200,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    ),
  );
}
