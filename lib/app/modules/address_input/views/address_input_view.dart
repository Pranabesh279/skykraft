import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:skycraft/app/models/addresss_data.dart';
import 'package:skycraft/app/widgets/buttons/gradient_button.dart';
import 'package:skycraft/app/widgets/googlemap_cordinate_picker.dart';
import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';

import '../controllers/address_input_controller.dart';

class AddressInputView extends GetView<AddressInputController> {
  const AddressInputView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
            margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton.icon(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black54,
                    size: 16,
                  ),
                  label: const Text(
                    'Back',
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text('Set Location',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    )),
              ],
            )),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Obx(() => GoogleMapCordinatePicker(
                    initialCordinate: controller.cordinate.value!,
                    onCordinateChanged: controller.onCordinateChanged,
                  )),
            ),
            Obx(
              () => Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        controller.isLoading.value
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator())
                            : const Icon(
                                Icons.location_on,
                                color: Colors.red,
                                size: 30,
                              ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.addressData.value?.city ?? '',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Text(controller.addressData.value?.address ?? ''),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Obx(
                    () => Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: GradientButton(
                          isLoading: controller.isLoading.value,
                          onPressed: () {
                            Get.back<AddressData?>(
                                result: controller.addressData.value);
                          },
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: const Text(
                            'Set Location',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          )),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
