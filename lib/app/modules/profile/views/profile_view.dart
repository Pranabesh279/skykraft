import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:skycraft/app/constants/constants.dart';

import 'package:skycraft/app/constants/theme_data.dart';
import 'package:skycraft/app/providers/auth_provider.dart';
import 'package:skycraft/app/routes/app_pages.dart';
import 'package:skycraft/app/widgets/card.dart';
import 'package:skycraft/app/widgets/profile_image.dart';
import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return SuperScaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // profile details with edit button dummy
                  Row(
                    children: [
                      // profile image
                      Obx(() => controller.user?.uid == null
                          ? const SizedBox()
                          : ProfileImage(
                              name: controller.user?.name ?? "",
                              userRole: controller.user?.role ?? "",
                            )),

                      const SizedBox(
                        width: 16,
                      ),
                      // profile details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(() => Text(
                                  controller.user?.name ?? '',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                )),
                            const SizedBox(
                              height: 2,
                            ),
                            Obx(() => Text(controller.user?.email ?? '')),
                            const SizedBox(
                              height: 5,
                            ),
                            //  posts , connects
                            Row(
                              children: [
                                // coins
                                Obx(
                                  () => (controller.user?.role ??
                                              UserRole.client) ==
                                          UserRole.client
                                      ? const SizedBox()
                                      : Expanded(
                                          child: Container(
                                            height: 24,
                                            width: 150,
                                            decoration: BoxDecoration(
                                              color: kTextColor,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Level ${(controller.user?.level ?? 1)}',
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(
              color: kTextColor,
              thickness: 0.25,
            ),
            SingleChildScrollView(
              child: Column(children: [
                Obx(() => controller.user?.location != null
                    ? const SizedBox()
                    : Container(
                        color: Colors.orangeAccent.withOpacity(0.1),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.warning,
                              color: Colors.orangeAccent,
                              size: 12,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Expanded(
                              child: Text(
                                'Please update your location, for visibility',
                                style: TextStyle(
                                  color: Colors.orangeAccent,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            controller.permissionsController.isLoading.value
                                ? const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  Colors.orangeAccent),
                                        )),
                                  )
                                : TextButton(
                                    onPressed: () {
                                      controller.permissionsController
                                          .determinePosition();
                                    },
                                    child: const Text(
                                      'Update',
                                      style: TextStyle(
                                        color: Colors.orangeAccent,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      )),

                // menu [edit profile ,posts, bookings, wallet, logout]
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.EDIT_PROFILE);
                  },
                  child: const CustomCard(
                    height: 50,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Icon(
                          Icons.edit,
                          color: kTextColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Edit Profile',
                          style: TextStyle(
                            color: kTextColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const CustomCard(
                  height: 50,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Icon(
                        Icons.post_add,
                        color: kTextColor,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Posts',
                        style: TextStyle(
                          color: kTextColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.BOOKING_LIST);
                  },
                  child: const CustomCard(
                    height: 50,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Icon(
                          Icons.bookmark_add_outlined,
                          color: kTextColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Bookings',
                          style: TextStyle(
                            color: kTextColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),

                const CustomCard(
                  height: 50,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Icon(
                        Icons.account_balance_wallet_outlined,
                        color: kTextColor,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Wallet',
                        style: TextStyle(
                          color: kTextColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                // logout in red
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () async {
                    await Get.find<AuthProvider>().signOutUser();
                  },
                  child: const CustomCard(
                    height: 50,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Icon(
                          Icons.logout,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Logout',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
            const SizedBox(
              height: 65,
            ),
          ],
        ),
      ),
      appBar: SuperAppBar(
        backgroundColor: kBackgroundColor,
        height: 0,
        searchBar: SuperSearchBar(enabled: false),
        largeTitle: SuperLargeTitle(
            largeTitle: 'Profile',
            textStyle: const TextStyle(
              color: kTitleColor,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
            actions: [
              // user Coins
              Obx(() => CustomCard(
                    height: 40,
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/icons/coins.png',
                          height: 20,
                          width: 20,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${(controller.coins.value.toInt())}',
                          style: const TextStyle(
                            color: kTextColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  )),
            ]),
      ),
    );
  }
}
