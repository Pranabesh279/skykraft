import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:skycraft/app/constants/theme_data.dart';
import 'package:skycraft/app/modules/home/views/home_view.dart';
import 'package:skycraft/app/modules/profile/views/profile_view.dart';
import 'package:skycraft/app/widgets/custom_tab_.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        // show dialog for exit app
        Get.dialog(
          AlertDialog(
            backgroundColor: kBackgroundColor,
            title: const Text('Exit App'),
            content: const Text('Do you want to exit the app?'),
            actions: [
              TextButton(
                onPressed: () => Get.back(),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () {
                  SystemNavigator.pop();
                },
                child: const Text('Yes'),
              ),
            ],
          ),
        );
        return Future.value(false);
      },
      child: AnnotatedRegion(
        value: const SystemUiOverlayStyle(
          statusBarColor: kBackgroundColor,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: kBackgroundColor,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
          extendBody: true,
          bottomNavigationBar: CustomTabBar(
            onTabChange: (index) {
              controller.changePage(index);
            },
            icons: controller.icons,
          ),
          body: Obx(
            () => IndexedStack(
              index: controller.selectedIndex.value,
              children: [
                const HomeView(),
                Container(
                  child: const Center(
                    child: Text('Discover Coming Soon'),
                  ),
                ),
                Container(
                  child: const Center(
                    child: Text('Flash Coming Soon'),
                  ),
                ),
                const ProfileView(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
