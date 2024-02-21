import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:requester/controllers/settings_controller.dart';
import 'package:requester/controllers/theme_controller.dart';
import 'package:requester/routes/routes.dart';
import 'package:requester/utils/shared_prefs.dart';
import 'package:requester/utils/firebase_constants.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'package:requester/utils/theme.dart';
import 'dart:math' as math;

class SettingsScreen extends GetView<SettingsController> {
  SettingsScreen({super.key});

  final ctrl = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Настройки',
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
                    onTap: () => authController.signOut(),
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
                        Text('Сбросить...')
                      ],
                    ),
                  )
                ],
                onChanged: (value) {
                  // ClearSettings();
                },
              ),
            ),
          ]),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: UserDetails(
                  settingsController: ctrl,
                ),
              ),
              Divider(
                color: Colors.grey.shade400,
                thickness: 2,
              ),
              SizedBox(height: 20.h),
              // Редактировать профиль пользователя
              RowWithoutSwitchProfile(
                text: 'Профиль пользователя',
                icon: Icons.person_outline,
                paddingSize: 0,
                sizedBoxWidth: 120.w,
              ),
              SizedBox(height: 20.h),
              // Смена пароля
              RowWithoutSwitchPassword(
                text: 'Сменить пароль',
                icon: Icons.lock_outline,
                paddingSize: 0,
                sizedBoxWidth: Get.locale!.languageCode == 'en' ? 100.w : 124.w,
              ),
              SizedBox(height: 20.h),
              // Режим уведомлений
              RowWithSwitchNotification(
                text: 'Уведомления',
                icon: Icons.notifications_none_outlined,
                paddingSize: 110.w,
              ),
              SizedBox(height: 20.h),
              // Смена темы оформления
              RowWithSwitchTheme(
                text: 'Выбор темы',
                icon: Icons.color_lens_outlined,
                paddingSize: 100.w,
              ),
              SizedBox(height: 20.h),
              // Выход из профиля
              GestureDetector(
                onTap: () {
                  authController.signOut();
                },
                child: ListTile(
                  leading: Transform.rotate(
                      angle: 180 * math.pi / 180,
                      child: Icon(
                        Icons.logout_outlined,
                        color: Theme.of(context).textTheme.headline1!.color,
                      )),
                  title: Text(
                    'Выход из профиля',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontFamily: 'Anton',
                      fontWeight: FontWeight.normal,
                      color: Theme.of(context).textTheme.headline1!.color,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Редактировать профиль пользователя
class RowWithoutSwitchProfile extends StatelessWidget {
  const RowWithoutSwitchProfile({
    super.key,
    required this.text,
    required this.icon,
    required this.paddingSize,
    required this.sizedBoxWidth,
  });

  final String text;
  final IconData icon;
  final double paddingSize;
  final double sizedBoxWidth;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Icon(
          icon,
          color: Theme.of(context).iconTheme.color,
        ),
        title: Text(
          text,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.normal,
            fontFamily: 'Anton',
            color: Theme.of(context).textTheme.headline1!.color,
          ),
        ),
        trailing: GestureDetector(
          onTap: () {
            Get.toNamed(Routes.profileSetting);
          },
          child: Icon(
            Icons.arrow_forward_ios_rounded,
            size: 20,
            color: Theme.of(context).iconTheme.color,
          ),
        )
        // ],
        );
  }
}

// Смена пароля
class RowWithoutSwitchPassword extends StatelessWidget {
  const RowWithoutSwitchPassword({
    super.key,
    required this.text,
    required this.icon,
    required this.paddingSize,
    required this.sizedBoxWidth,
  });

  final String text;
  final IconData icon;
  final double paddingSize;
  final double sizedBoxWidth;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      // children: [
      // Icons.person_outline
      leading: Icon(
        icon,
        color: Theme.of(context).iconTheme.color,
      ),

      title: Text(
        text,
        style: TextStyle(
          fontSize: 16.sp,
          fontFamily: 'Anton',
          fontWeight: FontWeight.normal,
          color: Theme.of(context).textTheme.headline1!.color,
        ),
      ),
      //  Icons.arrow_forward_ios_rounded
      trailing: GestureDetector(
        onTap: () {
          Get.toNamed(Routes.updatePassword);
        },
        child: Icon(
          Icons.arrow_forward_ios_rounded,
          size: 20,
          color: Theme.of(context).iconTheme.color,
        ),
      ),

      // ],
    );
  }
}

// Режим уведомлений
class RowWithSwitchNotification extends StatelessWidget {
  const RowWithSwitchNotification({
    Key? key,
    required this.text,
    required this.icon,
    required this.paddingSize,
  }) : super(key: key);
  final String text;
  final IconData icon;
  final double paddingSize;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: Theme.of(context).iconTheme.color,
      ),
      title: Text(
        text,
        style: TextStyle(
          fontSize: 16.sp,
          fontFamily: 'Anton',
          fontWeight: FontWeight.normal,
          color: Theme.of(context).textTheme.headline1!.color,
        ),
      ),
      trailing: SizedBox(
        width: 50,
        child: FlutterSwitch(
          height: 22.0,
          width: 55.0,
          padding: 1.5,
          toggleSize: 20.0,
          borderRadius: 13.0,
          activeColor: Color.fromRGBO(39, 174, 96, 1),
          value: false,
          onToggle: (value) {},
        ),
      ),
    );
  }
}

// Смена темы оформления
class RowWithSwitchTheme extends StatelessWidget {
  RowWithSwitchTheme({
    Key? key,
    required this.text,
    required this.icon,
    required this.paddingSize,
  }) : super(key: key);
  final String text;
  final IconData icon;
  final double paddingSize;

  final controller = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListTile(
        leading: Icon(
          icon,
          color: Theme.of(context).textTheme.headline1!.color,
        ),
        title: Text(
          text,
          style: TextStyle(
            fontSize: 16.sp,
            fontFamily: 'Anton',
            fontWeight: FontWeight.normal,
            color: Theme.of(context).textTheme.headline1!.color,
          ),
        ),
        trailing: SizedBox(
          width: 50.w,
          child: FlutterSwitch(
            height: 22.0,
            width: 55.0,
            padding: 1.5,
            toggleSize: 20.0,
            borderRadius: 13.0,
            activeColor: Color.fromRGBO(39, 174, 96, 1),
            value: controller.swithchThemwValue.value,
            onToggle: (value) {
              ThemeController().changesTheme();
              controller.swithchThemwValue.value = value;
            },
          ),
        ),
      ),
    );
  }
}

// Инфоормация о пользователе
class UserDetails extends StatelessWidget {
  UserDetails({
    Key? key,
    required this.settingsController,
  }) : super(key: key);

  final SettingsController settingsController;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        children: [
          GestureDetector(
            onTap: () {
              _avatarPressed(ImageSource.camera, context: context);
            },
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Get.isDarkMode ? Colors.white : Colors.blue,
              child: ClipOval(
                child: settingsController.photoURL.value == 'null'
                    ? Image.asset(
                        'assets/icons/person.png',
                        fit: BoxFit.cover,
                      )
                    : CachedNetworkImage(
                        imageUrl: settingsController.photoURL.value,
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Image.asset(
                          'assets/icons/person.png',
                          fit: BoxFit.cover,
                        ),
                        width: 100,
                        height: 100,
                        fit: BoxFit.fill,
                      ),
              ),
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                auth.currentUser == null
                    //SharedPrefs.instance.getString('token') == null
                    ? 'unknown'
                    : auth.currentUser!.displayName
                        .toString(), //settingsController.name.value,
                style: TextStyle(
                  color: Theme.of(context).textTheme.headline1!.color,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Text(
                auth.currentUser == null
                    //SharedPrefs.instance.getString('token') == null
                    ? 'unknown'
                    : auth.currentUser!.email
                        .toString(), //settingsController.email.value,
                style: TextStyle(
                  color: Theme.of(context).textTheme.headline1!.color,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<void> _avatarPressed(
    ImageSource source, {
    required BuildContext context,
  }) async {
    if (context.mounted) {
      try {
        final XFile? pickedFile = await _picker.pickImage(source: source);
        settingsController.updateUserPhoto(pickedFile!);
      } catch (e) {
        print(e);
      }
    }
  }
}
