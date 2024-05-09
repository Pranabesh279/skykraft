import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:skycraft/app/constants/constants.dart';
import 'package:skycraft/app/widgets/buttons/gradient_button.dart';
import 'package:skycraft/app/widgets/card.dart';

import '../controllers/set_user_role_controller.dart';

class SetUserRoleView extends GetView<SetUserRoleController> {
  const SetUserRoleView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 160,
            ),
            //  set user role - dron pilot or client
            const Text(
              'Select Your User Preference, Please!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomCard(
              height: 50,
              child: Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  const Text(
                    'Client',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  // radio button
                  Obx(
                    () => Radio(
                      value: UserRole.client,
                      groupValue: controller.userRole.value,
                      onChanged: (value) {
                        controller.userRole.value = value.toString();
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomCard(
              height: 50,
              child: Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  const Text(
                    'Drone Pilot',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  // radio button
                  Obx(
                    () => Radio(
                      value: UserRole.dronePilot,
                      groupValue: controller.userRole.value,
                      onChanged: (value) {
                        controller.userRole.value = value.toString();
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            // continue button
            GradientButton(
              onPressed: () {
                controller.submit();
              },
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Obx(() => controller.isLoading.value
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : const Text(
                      'Done!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    )),
            ),
          ],
        ),
      ),
    );
  }
}
