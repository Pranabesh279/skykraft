import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skycraft/app/widgets/buttons/gradient_button.dart';
import 'package:skycraft/app/widgets/screen.dart';

import '../controllers/login_controller.dart';

class OtpView extends GetView<LoginController> {
  const OtpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Screen(
      body: Container(
        padding:
            const EdgeInsets.only(top: 100, left: 20, right: 20, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Verify your phone number',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20),
            // SizedBox(
            //   child: PinInputTextField(
            //     pinLength: 6,
            //     decoration: BoxLooseDecoration(
            //         // colorBuilder:
            //         //     PinListenColorBuilder(kGreenColor, kPrimaryColor),
            //         bgColorBuilder: const FixedColorBuilder(kSecondaryColor),
            //         obscureStyle: ObscureStyle(
            //           isTextObscure: false,
            //           obscureText: '😂',
            //         ),
            //         strokeColorBuilder: PinListenColorBuilder(
            //           kGreenColor,
            //           kPrimaryColor,
            //         )),
            //     textInputAction: TextInputAction.go,
            //     keyboardType: TextInputType.number,
            //     textCapitalization: TextCapitalization.characters,
            //     onSubmit: (pin) {
            //       debugPrint('submit pin:$pin');
            //     },
            //     onChanged: (pin) {
            //       debugPrint('onChanged execute. pin:$pin');
            //     },
            //     enableInteractiveSelection: false,
            //   ),
            // ),
            const SizedBox(height: 20),
            const Text(
              'Enter the 6-digit code sent to you at',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            GradientButton(
              onPressed: () {
                controller.verifyOtp();
              },
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Verify',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
