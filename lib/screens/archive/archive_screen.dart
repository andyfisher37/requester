import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:requester/controllers/archive_controller.dart';
import 'package:requester/routes/routes.dart';
import 'package:requester/utils/theme.dart';

class ArchiveScreen extends GetView<ArchiveController> {
  ArchiveScreen({super.key});

  final ctrl = Get.find<ArchiveController>();
  late TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Get.isDarkMode
              ? Theme.of(context).scaffoldBackgroundColor
              : Colors.white,
          title: Text(
            'Архив',
            style: TextStyle(fontFamily: 'Lobster'),
          ),
          elevation: 1,
          centerTitle: true,
          actions: [
            GestureDetector(
              onTap: (() {
                Get.toNamed(Routes.notificatonScreen);
              }),
              child: Padding(
                padding: EdgeInsets.only(right: 25.w, left: 0),
                child: const Icon(
                  Icons.notifications_none_rounded,
                  size: 30,
                ),
              ),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(70),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: TabBar(
                labelColor: mainColor,
                indicatorColor: mainColor,
                unselectedLabelColor: Colors.grey,
                tabs: const [
                  Tab(
                    text: 'Не исполненные',
                  ),
                  Tab(
                    text: 'Исполненные',
                  ),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            TapBarScreen(executeFlag: false),
            TapBarScreen(executeFlag: true),
          ],
        ),
      ),
    );
  }
}
/* appBar: AppBar(
          title: const Text(
            'Архив',
            style: TextStyle(fontFamily: 'Lobster'),
          ),
          centerTitle: true,
          actions: [
            DropdownButtonHideUnderline(
              child: DropdownButton(
                icon: Icon(
                  Icons.more_vert,
                  color: Theme.of(context).appBarTheme.foregroundColor,
                ),
                items: [
                  DropdownMenuItem(
                    value: 'logout',
                    child: Row(
                      children: [
                        Icon(
                          Icons.exit_to_app,
                          color: Theme.of(context).appBarTheme.foregroundColor,
                        ),
                        SizedBox(width: 10),
                        Text('Выход')
                      ],
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'clear',
                    child: Row(
                      children: [
                        Icon(
                          Icons.cleaning_services_outlined,
                          color: Theme.of(context).appBarTheme.foregroundColor,
                        ),
                        SizedBox(width: 10),
                        Text('Очистить всё')
                      ],
                    ),
                  )
                ],
                onChanged: (value) {
                  // ArvhiveClear();
                },
              ),
            ),
          ]), */
/* body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...getArchiveList(),
            ],
          ),
        ),
      ),
    ); */

class TapBarScreen extends StatelessWidget {
  final bool executeFlag;

  TapBarScreen({Key? key, required this.executeFlag}) : super(key: key);
  List item = [
    {"title": "Button One", "color": 50},
    {"title": "Button Two", "color": 100},
    {"title": "Button Three", "color": 200},
    {"title": "No show", "color": 0, "hide": '1'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: 40.w,
          left: 20.w,
          right: 20.w,
        ),
        child: ListView.builder(
          itemCount: 8,
          itemBuilder: (context, i) {
            return Card(
              child: ListTile(
                title: Row(
                  children: [
                    ClipRRect(
                      child: SizedBox.fromSize(
                        size: Size.fromRadius(30), // Image radius
                        child: !executeFlag
                            ? Image.asset('assets/images/cashflow_black.png',
                                fit: BoxFit.cover)
                            : Image.asset('assets/images/cashflow_white.png',
                                fit: BoxFit.cover),
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Заявка',
                          style: TextStyle(
                              color:
                                  Get.isDarkMode ? Colors.white : Colors.black,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            Text(
                              'ID:',
                              style: TextStyle(
                                  color:
                                      Get.isDarkMode ? Colors.white : mainColor,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Number',
                              style: TextStyle(
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 40.h,
                    ),
                    Text(
                      'Загрузка...',
                      style: TextStyle(
                          color: Get.isDarkMode ? Colors.white : Colors.green,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// Создаем список виджетов архивных заявок
List<Widget> getArchiveList() {
  List<Widget> list = [];
  for (var i = 0; i < 50; i++) {
    list.add(
      // Добавляем элементы смахивания и удаляемости
      Dismissible(
        background: Container(
          color: Colors.green,
          child: Text('Восстановить...'),
        ),
        secondaryBackground: Container(
          color: Colors.red,
          child: Text('Удалить...'),
        ),
        key: ValueKey<int>(i),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('${i + 1}) Архивная заявка...'),
        ),
      ),
    );
  }
  return list;
}

class PreferredSizeInAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const PreferredSizeInAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      // ignore: sort_child_properties_last
      child: Container(
        color: appBarPreferredSizeColor.withOpacity(.8),
        height: .5,
      ),
      preferredSize: const Size.fromHeight(4.0),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(4.0);
}

class FilterAppBar extends StatelessWidget implements PreferredSizeWidget {
  const FilterAppBar({
    Key? key,
  }) : super(key: key);
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      bottom: PreferredSizeInAppBar(),
      elevation: 0,
      leading: GestureDetector(
        onTap: () => Get.back(),
        child: Icon(
          Icons.arrow_back_ios,
          color: Get.isDarkMode ? Colors.white : Colors.black,
          size: 20,
        ),
      ),
      centerTitle: true,
      title: Text(
        'Фильтр:',
        style: TextStyle(
          fontSize: 20.sp,
          fontFamily: 'PoiretOne',
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}
