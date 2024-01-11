import 'dart:ffi' as ffi;

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:requester/controllers/details_request_controller.dart';
import 'package:requester/controllers/request_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DetailsRequestScreen extends GetView<DetailsRequestController> {
  DetailsRequestScreen({super.key});

  final ctrl = Get.find<DetailsRequestController>();

  Future<Null> _refreshLocalGallery() async {
    //ctrl.viewById(ctrl.request.value.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      RefreshIndicator(
          onRefresh: _refreshLocalGallery,
          child: SingleChildScrollView(
            child: Obx(
              () => controller.isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(children: [
                      Stack(
                        children: [
                          Stack(
                            children: [
                              ShowImage(
                                imageUrl:
                                    'https://source.unsplash.com/random/300x300',
                              ),
                              ImageShadow(),
                            ],
                          ),
                          SafeArea(
                            minimum: EdgeInsets.all(1),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10.h,
                                ),
                                BackIcon(),
                                SizedBox(
                                  height: ScreenUtil().screenHeight * 0.2,
                                ),
                                SizedBox(
                                  height: ScreenUtil().screenHeight * 0.7,
                                  width: ScreenUtil().screenWidth,
                                  child: Stack(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 30.0),
                                        child: Container(
                                          height: ScreenUtil().screenHeight,
                                          width: ScreenUtil().screenWidth,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 30),
                                          decoration: ShapeDecoration(
                                            color: Theme.of(context).cardColor,
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(40),
                                                topRight: Radius.circular(40),
                                              ),
                                            ),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              TitleText(
                                                title:
                                                    ctrl.request.value.title!,
                                              ),

                                              SupTitle(
                                                summa: ctrl.request.value.summa
                                                    .toString(),
                                                stavka: ctrl
                                                    .request.value.stavka
                                                    .toString(),
                                                cat: ctrl
                                                    .request.value.category!,
                                              ),
                                              // "Description",
                                              SizedBox(
                                                height: 20.h,
                                              ),
                                              Description(
                                                  desc: ctrl.request.value
                                                      .description!),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5),
                                                child: Divider(
                                                  color: Colors.grey.shade400,
                                                  thickness: 2,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20.h,
                                              ),
                                              GetBuilder<RequestController>(
                                                builder: (_) => Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 20),
                                                  child: AuthButton(
                                                    press: null,
                                                    // SharedPrefs.instance
                                                    //             .getString(
                                                    //                 'token') ==
                                                    //         null
                                                    //     ? null
                                                    //     : () => chicke(),
                                                    text: 'Редактировать',
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),

                                      // Область нажатия на которую меняет актуальность заявки...
                                      GestureDetector(
                                        onTap: () {
                                          ctrl.manageExecuting(
                                              ctrl.request.value);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            right: 20,
                                          ),
                                          child: Align(
                                            alignment: Alignment.topRight,
                                            child: Container(
                                              child: ClipPath(
                                                clipper: CustomTriangle(),
                                                child: Container(
                                                  width: 60,
                                                  height: 60,
                                                  color: Theme.of(context)
                                                      .cardColor,
                                                  child: Icon(Icons.handshake,
                                                      color:
                                                          Get.theme.hintColor,
                                                      size: 40),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ]),
            ),
          ))
    ]));
  }
}

// Фишечка сверху с логотипом
class CustomTriangle extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Offset controlpoint = Offset(size.width * 0, size.height * 0.5);
    Offset endpoint = Offset(size.width * 0.2, size.height * 0.85);
    Offset controlpoint2 = Offset(size.width * 0.33, size.height);
    Offset endpoint2 = Offset(size.width * 0.6, size.height * 0.9);
    Offset controlpoint3 = Offset(size.width * 1.4, size.height * 0.5);
    Offset endpoint3 = Offset(size.width * 0.6, size.height * 0.1);
    Offset controlpoint4 = Offset(size.width * 0.33, size.height * 0);
    Offset endpoint4 = Offset(size.width * 0.2, size.height * 0.15);

    Path path = Path()
      ..moveTo(size.width * 0.2, size.height * 0.15)
      ..quadraticBezierTo(
        controlpoint.dx,
        controlpoint.dy,
        endpoint.dx,
        endpoint.dy,
      )
      ..quadraticBezierTo(
        controlpoint2.dx,
        controlpoint2.dy,
        endpoint2.dx,
        endpoint2.dy,
      )
      ..quadraticBezierTo(
        controlpoint3.dx,
        controlpoint3.dy,
        endpoint3.dx,
        endpoint3.dy,
      )
      ..quadraticBezierTo(
        controlpoint4.dx,
        controlpoint4.dy,
        endpoint4.dx,
        endpoint4.dy,
      );

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class AuthButton extends StatelessWidget {
  final String text;
  final Function? press;

  const AuthButton({
    required this.text,
    Key? key,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: press as void Function()?,
      style: ElevatedButton.styleFrom(
        // shadowColor: Colors.white,
        side: BorderSide.none,
        minimumSize: Size(337.w, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // <-- Radius
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// Значок возврата (аля iOS)
class BackIcon extends StatelessWidget {
  const BackIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.white,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}

class ShowImage extends StatelessWidget {
  const ShowImage({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.52,
      width: MediaQuery.of(context).size.width,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}

// Генерация тени задника
class ImageShadow extends StatelessWidget {
  const ImageShadow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.0, 0.4],
          colors: [
            Colors.black.withOpacity(0.9),
            Colors.black.withOpacity(0.0),
          ],
        ),
      ),
    );
  }
}

// Описание (description)
class Description extends StatelessWidget {
  const Description({
    super.key,
    required this.desc,
  });

  final String desc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        'Описание: $desc',
      ),
    );
  }
}

// Заголовок (title)
class TitleText extends StatelessWidget {
  TitleText({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        "Заявка от: $title",
        style: Get.theme.textTheme.titleLarge,
        //   TextStyle(
        //       color: Get.theme.textTheme.,
        //       fontSize: 20.sp,
        //       fontFamily: 'Anton',
        //       fontWeight: FontWeight.bold),
        // ),
      ),
    );
  }
}

// Подзаголовок (summa, stavka, category)
class SupTitle extends StatelessWidget {
  const SupTitle({
    Key? key,
    required this.summa,
    required this.stavka,
    required this.cat,
  }) : super(key: key);
  final String summa;
  final String stavka;
  final String cat;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "На сумму: $summa руб.",
          ),
          const SizedBox(width: 2),
          Text(
            "Ставка: $stavka",
          ),
          const SizedBox(width: 2),
          Row(
            children: [
              cat == 'срочная'
                  ? Image.asset('assets/images/cat_quick.png')
                  : Image.asset('assets/images/cat_ord.png'),
              const SizedBox(width: 5),
              Text(
                'Категория срочности - $cat ',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
