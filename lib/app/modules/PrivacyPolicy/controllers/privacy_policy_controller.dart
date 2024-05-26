import 'package:get/get.dart';
import 'package:skycraft/app/models/points.dart';

class PrivacyPolicyController extends GetxController {
  Rx<String> heading =
      'We are committed to protecting your privacy and ensuring the security of your personal information. This Privacy Policy describes how we collect, use, disclose, and safeguard your information when you use our application'
          .obs;

  RxList<Points> points = <Points>[
    Points(title: 'Information We Collect About Youp', subTitels: [
      'Personal Information: When you register on our app, we collect personal information such as your name, email address',
      'Location Data: For drone pilots, we collect and display your real-time location to users for booking purposes. For users, we collect location data to show nearby drone pilots',
      'Booking Information: We collect information related to bookings, including the date, time, location, and details of the service requested'
    ]),
    Points(title: 'How We Use Your Information', subTitels: [
      'To Provide and Improve Our Services: We use your information to operate, maintain, and improve our app, ensuring a seamless and personalized experience',
      'To Facilitate Bookings: We use your location data and booking information to connect users with drone pilots and manage booking requests',
      'To Communicate with You: We use your contact information to send you updates, notifications, and support-related messages',
      'To Ensure Safety and Security: We use your information to monitor and enhance the security of our app, including detecting and preventing fraudulent activities',
      'To Comply with Legal Obligations: We may use your information to comply with applicable laws, regulations, and legal processes',
    ]),
    Points(title: 'To Whom Do We Disclose Your Information', subTitels: [
      'Service Providers: We may share your information with third-party service providers who assist us in operating our app, such as payment processors, hosting services, and customer support',
      'Business Partners: With your consent, we may share your information with business partners for joint marketing and promotional activities',
      'Legal Requirements: We may disclose your information if required by law, legal process, or government request, and to protect the rights, property, and safety of our users and the public',
      'Corporate Transactions: In the event of a merger, acquisition, or sale of assets, your information may be transferred to the acquiring entity.',
    ]),
    Points(title: 'What Do We Do to Keep Your Information Secure', subTitels: [
      'We implement a variety of security measures to protect your personal information from unauthorized access, use, or disclosure. Access controls, and regular security audits. Despite our efforts, no security measures are completely secure, and we cannot guarantee the absolute security of your information',
    ]),
    Points(title: 'Cookies, Beacons, and Tracking Technologies', subTitels: [
      'We use cookies, web beacons, and other tracking technologies to enhance your experience on our app. These technologies help us understand how you use our app, personalize your experience, and deliver relevant advertisements. You can manage your cookie preferences through your device settings',
    ]),
    Points(title: 'Your Privacy Rights', subTitels: [
      'Depending on your location, you may have certain rights regarding your personal information, such as the right to access, correct, or delete your data. To exercise these rights, please contact us at skykraftdrones@gmail.com',
    ]),
  ].obs;
}
