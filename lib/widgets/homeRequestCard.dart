import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:requester/models/request.dart';

class HomeRequestCard extends StatelessWidget {
  const HomeRequestCard({
    super.key,
    required this.requestItem,
  });
  final Request requestItem;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              height: 75,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                color: Theme.of(context).cardColor,
                child: Row(
                  children: [
                    const SizedBox(
                      width: 15,
                    ),
                    Container(
                      height: 27,
                      width: 27,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: requestItem.isExecute
                            ? Colors.red
                            : Theme.of(context).cardColor,
                      ),
                      child: Icon(
                        Icons.edit_document,
                        color: Theme.of(context).indicatorColor,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Text(
                        requestItem.title,
                        style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).indicatorColor,
                            letterSpacing: 1,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Text(
                      requestItem.returndate.format('d.m.Y'),
                      style: TextStyle(
                          fontSize: 15,
                          color: Theme.of(context).indicatorColor,
                          fontWeight: FontWeight.w300),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
    /* Padding(
      padding: EdgeInsets.only(right: 5.w, bottom: 0, left: 10.w, top: 55.h),
      child: Text(
        requestItem.title,
        maxLines: 1,
        style: GoogleFonts.roboto(
          textStyle: TextStyle(
            color: Colors.white.withOpacity(1),
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    ); */
  }
}
