import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

Widget ReminderShimmer() {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade200,
    child: Column(
      children: [
        ...List.generate(
          8,
          (index) => Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20.sp,
                    backgroundColor: Colors.grey.shade100,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 10,
                        width: 200.sp,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.shade100,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 10,
                        width: 150.sp,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.shade100,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Divider(
                height: 30,
                thickness: 1.3,
                color: Color(0xffDDDADA),
              ),
            ],
          ),
        )
      ],
    ),
  );
}
