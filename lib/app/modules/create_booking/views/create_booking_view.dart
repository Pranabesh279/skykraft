import 'dart:developer';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:skycraft/app/constants/theme_data.dart';
import 'package:skycraft/app/models/addresss_data.dart';
import 'package:skycraft/app/modules/address_input/bindings/address_input_binding.dart';
import 'package:skycraft/app/modules/address_input/views/address_input_view.dart';
import 'package:skycraft/app/widgets/buttons/gradient_button.dart';
import 'package:skycraft/app/widgets/card.dart';
import 'package:skycraft/app/widgets/profile_image.dart';
import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';

import '../controllers/create_booking_controller.dart';

class CreateBookingView extends GetView<CreateBookingController> {
  const CreateBookingView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SuperScaffold(
        body: Column(
          children: <Widget>[
            CalendarDatePicker2(
              config: CalendarDatePicker2Config(
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 30)),
                calendarType: CalendarDatePicker2Type.multi,
                daySplashColor: Theme.of(context).primaryColor.withOpacity(0.1),
              ),
              value: controller.selectedDates,
              onValueChanged: (value) {
                controller.selectedDates.value = value;
                log('selected dates: ${controller.selectedDates}');
              },
            ),
            // add service location button
            Obx(
              () => CustomCard(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: ListTile(
                  leading: controller.fromAddress.value != null
                      ? const Icon(Icons.location_on, color: Colors.red)
                      : null,
                  title: controller.fromAddress.value != null
                      ? Text(controller.fromAddress.value?.city ?? '',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w600))
                      : const Text('Add Fly Location'),
                  subtitle: controller.fromAddress.value != null &&
                          controller.fromAddress.value?.address != null
                      ? Text(
                          controller.fromAddress.value?.address ?? '',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      : null,
                  trailing: controller.fromAddress.value != null
                      ? TextButton(
                          child: const Text('Change'),
                          onPressed: () async {
                            final addressData = await Get.to<AddressData?>(
                                () => const AddressInputView(),
                                binding: AddressInputBinding(
                                  initialCordinate: LatLng(
                                      controller.user?.location?.latitude ?? 0,
                                      controller.user?.location?.longitude ??
                                          0),
                                ));
                            if (addressData != null) {
                              controller.fromAddress.value = addressData;
                            }
                          },
                        )
                      : //  change button to add button
                      TextButton(
                          child: const Text('Add'),
                          onPressed: () async {
                            final addressData = await Get.to<AddressData?>(
                                () => const AddressInputView(),
                                binding: AddressInputBinding(
                                  initialCordinate: LatLng(
                                      controller.user?.location?.latitude ?? 0,
                                      controller.user?.location?.longitude ??
                                          0),
                                ));
                            if (addressData != null) {
                              controller.fromAddress.value = addressData;
                            }
                          },
                        ),
                  onTap: () async {
                    final addressData = await Get.to<AddressData?>(
                        () => const AddressInputView(),
                        binding: AddressInputBinding(
                          initialCordinate: LatLng(
                              controller.user?.location?.latitude ?? 0,
                              controller.user?.location?.longitude ?? 0),
                        ));
                    if (addressData != null) {
                      controller.fromAddress.value = addressData;
                    }
                  },
                ),
              ),
            ),
            const Spacer(),
            Obx(() => controller.coins.value >= 0
                ? Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Your Coins Balance',
                              style: TextStyle(
                                color: kPrimaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            controller.coins.value > controller.getBookingPrice
                                ? const Text(
                                    'You can use your coins to pay for this booking',
                                    style: TextStyle(
                                      color: Colors.black26,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                : const Text(
                                    'You do not have enough coins to pay for this booking',
                                    style: TextStyle(
                                      color: Colors.orangeAccent,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                          ],
                        ),
                        const Spacer(),
                        Image.asset(
                          'assets/icons/coins.png',
                          width: 20,
                          height: 20,
                        ),
                        Text(
                          '${controller.coins.value.toInt()}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox()),
            Obx(
              () => Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: GradientButton(
                    isLoading: controller.isLoading.value,
                    disable: controller.fromAddress.value == null ||
                        controller.selectedDates.isEmpty ||
                        controller.coins.value < 0 ||
                        controller.coins.value < controller.getBookingPrice,
                    onPressed: () async {
                      await controller.createBooking();
                    },
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Total Price',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/icons/coins.png',
                                    width: 20,
                                    height: 20,
                                  ),
                                  Text(
                                    '${controller.getBookingPrice}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Text(
                          'Request Booking',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 20,
                        )
                      ],
                    )),
              ),
            ),
          ],
        ),
        appBar: SuperAppBar(
          height: 40,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          largeTitle: SuperLargeTitle(
            largeTitle: 'Request Booking',
            textStyle: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 24,
              fontWeight: FontWeight.w800,
            ),
          ),
          actions: Container(
            margin: const EdgeInsets.only(right: 10),
            child: ProfileImage(
                size: 30,
                name: controller.user!.name!,
                userRole: controller.user!.role!),
          ),
          title: Text('Request Booking',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              )),
          searchBar: SuperSearchBar(enabled: false),
        ),
      ),
    );
  }
}
