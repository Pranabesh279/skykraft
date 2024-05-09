import 'package:get/get.dart';

import '../modules/activity/bindings/activity_binding.dart';
import '../modules/activity/views/activity_view.dart';
import '../modules/address_input/bindings/address_input_binding.dart';
import '../modules/address_input/views/address_input_view.dart';
import '../modules/bio/bindings/bio_binding.dart';
import '../modules/bio/views/bio_view.dart';
import '../modules/booking_details/bindings/booking_details_binding.dart';
import '../modules/booking_details/views/booking_details_view.dart';
import '../modules/booking_list/bindings/booking_list_binding.dart';
import '../modules/booking_list/views/booking_list_view.dart';
import '../modules/create_booking/bindings/create_booking_binding.dart';
import '../modules/create_booking/views/create_booking_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/discover/bindings/discover_binding.dart';
import '../modules/discover/views/discover_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/email_view.dart';
import '../modules/permissions/bindings/permissions_binding.dart';
import '../modules/permissions/views/permissions_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/setUserRole/bindings/set_user_role_binding.dart';
import '../modules/setUserRole/views/set_user_role_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;
  static const MAIN = Routes.DASHBOARD;

  static final routes = [
    GetPage(
      name: _Paths.LOGIN,
      page: () => const EmailView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.DISCOVER,
      page: () => const DiscoverView(),
      binding: DiscoverBinding(),
    ),
    GetPage(
      name: _Paths.ACTIVITY,
      page: () => const ActivityView(),
      binding: ActivityBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.SET_USER_ROLE,
      page: () => const SetUserRoleView(),
      binding: SetUserRoleBinding(),
    ),
    GetPage(
      name: _Paths.PERMISSIONS,
      page: () => const PermissionsView(),
      binding: PermissionsBinding(),
    ),
    GetPage(
      name: _Paths.BIO,
      page: () => const BioView(),
      binding: BioBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_BOOKING,
      page: () => const CreateBookingView(),
      binding: CreateBookingBinding(),
    ),
    GetPage(
      name: _Paths.BOOKING_DETAILS,
      page: () => const BookingDetailsView(),
      binding: BookingDetailsBinding(),
    ),
    GetPage(
      name: _Paths.ADDRESS_INPUT,
      page: () => const AddressInputView(),
      binding: AddressInputBinding(),
    ),
    GetPage(
      name: _Paths.BOOKING_LIST,
      page: () => const BookingListView(),
      binding: BookingListBinding(),
    ),
  ];
}
