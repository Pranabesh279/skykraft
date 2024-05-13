import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:skycraft/app/constants/theme_data.dart';
import 'package:skycraft/app/modules/create_booking/bindings/create_booking_binding.dart';
import 'package:skycraft/app/modules/create_booking/views/create_booking_view.dart';
import 'package:skycraft/app/widgets/buttons/gradient_button.dart';
import 'package:skycraft/app/widgets/profile_image.dart';

import '../controllers/bio_controller.dart';

class BioView extends GetView<BioController> {
  const BioView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor.withOpacity(0.9),
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 10),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  ProfileImage(
                    name: controller.user!.name!,
                    userRole: controller.user!.role!,
                    size: 60,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    controller.user!.name!,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Total post count
                      Column(
                        children: [
                          Text(
                            'Total Posts',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.5),
                            ),
                          ),
                          Text(
                            '${0}',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),

                      // Level count
                      Column(
                        children: [
                          Text(
                            'Level',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.5),
                            ),
                          ),
                          Text(
                            '${controller.user?.level ?? 1}',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                      // Total followers count
                      Column(
                        children: [
                          Text(
                            'Connections',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.5),
                            ),
                          ),
                          Text(
                            '${0}',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  if (controller.isNotSameUser())
                    // add tree buttons in row for follow and message and book
                    SizedBox(
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // follow button
                          // Expanded(
                          //   child: GradientButton(
                          //     disable: true,
                          //     onPressed: () {},
                          //     child: const Text('Connect',
                          //         style: TextStyle(
                          //             fontSize: 16, color: Colors.white)),
                          //   ),
                          // ),
                          // const SizedBox(width: 10),
                          // // message button
                          // Expanded(
                          //   child: GradientButton(
                          //     onPressed: () {},
                          //     child: const Text('Message',
                          //         style:
                          //             TextStyle(fontSize: 16, color: Colors.white)),
                          //   ),
                          // ),
                          // const SizedBox(width: 10),
                          // book request button
                          Expanded(
                            child: GradientButton(
                              onPressed: () {
                                Get.to(
                                  () => const CreateBookingView(),
                                  binding: CreateBookingBinding(
                                      user: controller.user),
                                  transition: Transition.fade,
                                );
                                // Get.back();
                              },
                              child: const Text('Book',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 10),
                  Divider(
                    color: Colors.grey.withOpacity(0.25),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                      child: Container(
                    child: const Center(
                      child: Text('No posts yet'),
                    ),
                  ))
                ],
              ),
            ),
            // close button
            Positioned(
                top: 10,
                right: 10,
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
