import 'package:get/get.dart';
import 'package:skycraft/app/models/points.dart';

class TermsAndConditionsController extends GetxController {
  Rx<String> heading =
      'These Terms and Conditions ("Terms") govern your use of this mobile application (the "App") provided by  ("we", "us", or "our"). By downloading, installing, or using the App, you agree to be bound by these Terms. If you do not agree to these Terms, do not use the App'
          .obs;

  RxList<Points> points = <Points>[
    Points(title: 'Use of the App', subTitels: [
      'Eligibility: You must be at least 18 years old to use the App. By using the App, you represent and warrant that you are 18 years of age or older',
      'License: We grant you a limited, non-exclusive, non-transferable, revocable license to use the App for your personal, non-commercial use, subject to these Terms',
      'Restrictions: You agree not to: (a) copy, modify, or create derivative works of the App; (b) decompile, reverse engineer, or disassemble the App; (c) distribute, transfer, sublicense, lease, lend, or rent the App to any third party; (d) make the functionality of the App available to multiple users through any means; or (e) use the App in any unlawful manner or for any unlawful purpose.'
    ]),
    Points(title: 'Account Registration', subTitels: [
      'Account Creation: You may be required to create an account to use certain features of the App. You agree to provide accurate and complete information when creating your account',
      'Account Security: You are responsible for maintaining the confidentiality of your account information and for all activities that occur under your account. You agree to notify us immediately of any unauthorized use of your account.'
    ]),
    Points(title: 'User Conduct', subTitels: [
      'Prohibited Conduct: You agree not to use the App to: (a) violate any applicable laws or regulations; (b) infringe the intellectual property or other rights of third parties; (c) transmit any harmful or malicious code; (d) engage in any fraudulent, deceptive, or misleading activities; or (e) post or transmit any content that is unlawful, defamatory, or offensive',
    ]),
    Points(title: 'Intellectual Property', subTitels: [
      'Ownership: All rights, title, and interest in and to the App, including all intellectual property rights, are and will remain the exclusive property of [Your Company Name] and its licensors. These Terms do not grant you any rights to use any trademarks, logos, or service marks displayed in the App'
    ]),
    Points(title: 'Third-Party Services', subTitels: [
      'The App may contain links to third-party websites or services that are not owned or controlled by us. We have no control over, and assume no responsibility for, the content, privacy policies, or practices of any third-party websites or services. You further acknowledge and agree that [Your Company Name] will not be responsible or liable, directly or indirectly, for any damage or loss caused or alleged to be caused by or in connection with use of or reliance on any such content, goods, or services available on or through any such websites or services.'
    ]),
    Points(title: 'Limitation of Liability', subTitels: [
      'Exclusion of Damages: To the fullest extent permitted by applicable law, we will not be liable for any indirect, incidental, special, consequential, or punitive damages, or any loss of profits or revenues, whether incurred directly or indirectly, or any loss of data, use, goodwill, or other intangible losses, resulting from (a) your use of or inability to use the App; (b) any unauthorized access to or use of our servers and/or any personal information stored therein; (c) any interruption or cessation of transmission to or from the App; or (d) any bugs, viruses, trojan horses, or the like that may be transmitted to or through the App by any third party'
    ]),
    Points(title: 'Indemnification', subTitels: [
      "You agree to indemnify, defend, and hold harmless and its officers, directors, employees, and agents from and against any and all claims, liabilities, damages, losses, and expenses, including reasonable attorneys' fees, arising out of or in any way connected with your access to or use of the App, your violation of these Terms, or your infringement of any intellectual property or other rights of any third party."
    ]),
    Points(title: 'Governing Law', subTitels: [
      "These Terms will be governed by and construed in accordance with the laws of [Your Country/State], without regard to its conflict of law principles. Any legal action or proceeding arising under these Terms will be brought exclusively in the federal or state courts located in India, and the parties hereby irrevocably consent to the personal jurisdiction and venue therein"
    ]),
    Points(title: 'Changes to These Terms', subTitels: [
      "We may update these Terms from time to time. If we make material changes to these Terms, we will notify you by posting the updated Terms on the App or through other communications. Your continued use of the App after the effective date of the updated Terms constitutes your acceptance of the updated Terms"
    ]),
    Points(title: 'Contact Us', subTitels: [
      "If you have any questions or concerns about these Terms, please contact us at skykraftdrones@gmail.com"
    ]),
  ].obs;
}
