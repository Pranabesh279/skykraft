import 'package:get/get.dart';

import '../modules/AddUserProfile/bindings/add_user_profile_binding.dart';
import '../modules/AddUserProfile/views/add_user_profile_view.dart';
import '../modules/PrivacyPolicy/bindings/privacy_policy_binding.dart';
import '../modules/PrivacyPolicy/views/privacy_policy_view.dart';
import '../modules/TermsAndConditions/bindings/terms_and_conditions_binding.dart';
import '../modules/TermsAndConditions/views/terms_and_conditions_view.dart';
import '../modules/activity/bindings/activity_binding.dart';
import '../modules/activity/views/activity_view.dart';
import '../modules/address_input/bindings/address_input_binding.dart';
import '../modules/address_input/views/address_input_view.dart';
import '../modules/authPhone/bindings/auth_phone_binding.dart';
import '../modules/authPhone/views/auth_phone_view.dart';
import '../modules/authPhoneVerify/bindings/auth_phone_verify_binding.dart';
import '../modules/authPhoneVerify/views/auth_phone_verify_view.dart';
import '../modules/bio/bindings/bio_binding.dart';
import '../modules/bio/views/bio_view.dart';
import '../modules/booking_details/bindings/booking_details_binding.dart';
import '../modules/booking_details/views/booking_details_view.dart';
import '../modules/booking_list/bindings/booking_list_binding.dart';
import '../modules/booking_list/views/booking_list_view.dart';
import '../modules/chatRoom/bindings/chat_room_binding.dart';
import '../modules/chatRoom/views/chat_room_view.dart';
import '../modules/create_booking/bindings/create_booking_binding.dart';
import '../modules/create_booking/views/create_booking_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/discover/bindings/discover_binding.dart';
import '../modules/discover/views/discover_view.dart';
import '../modules/edit_profile/bindings/edit_profile_binding.dart';
import '../modules/edit_profile/views/edit_profile_view.dart';
import '../modules/gallary/bindings/gallary_binding.dart';
import '../modules/gallary/views/gallary_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/locationPermission/bindings/location_permission_binding.dart';
import '../modules/locationPermission/views/location_permission_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/email_view.dart';
import '../modules/mediaviewer/bindings/mediaviewer_binding.dart';
import '../modules/mediaviewer/views/mediaviewer_view.dart';
import '../modules/permissions/bindings/permissions_binding.dart';
import '../modules/permissions/views/permissions_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/setUserRole/bindings/set_user_role_binding.dart';
import '../modules/setUserRole/views/set_user_role_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/uploadMedia/bindings/upload_media_binding.dart';
import '../modules/uploadMedia/views/upload_media_view.dart';
import '../modules/view_chat/bindings/view_chat_binding.dart';
import '../modules/view_chat/views/view_chat_view.dart';

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
        // binding: DashboardBinding(),
        bindings: [
          DashboardBinding(),
          HomeBinding(),
          ProfileBinding(),
          DiscoverBinding(),
          GallaryBinding()
        ]),
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
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => const EditProfileView(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: _Paths.TERMS_AND_CONDITIONS,
      page: () => const TermsAndConditionsView(),
      binding: TermsAndConditionsBinding(),
    ),
    GetPage(
      name: _Paths.PRIVACY_POLICY,
      page: () => const PrivacyPolicyView(),
      binding: PrivacyPolicyBinding(),
    ),
    GetPage(
      name: _Paths.LOCATION_PERMISSION,
      page: () => const LocationPermissionView(),
      binding: LocationPermissionBinding(),
    ),
    GetPage(
      name: _Paths.AUTH_PHONE,
      page: () => const AuthPhoneView(),
      binding: AuthPhoneBinding(),
    ),
    GetPage(
      name: _Paths.AUTH_PHONE_VERIFY,
      page: () => const AuthPhoneVerifyView(),
      binding: AuthPhoneVerifyBinding(),
    ),
    GetPage(
      name: _Paths.ADD_USER_PROFILE,
      page: () => const AddUserProfileView(),
      binding: AddUserProfileBinding(),
    ),
    GetPage(
      name: _Paths.UPLOAD_MEDIA,
      page: () => const UploadMediaView(),
      binding: UploadMediaBinding(),
    ),
    GetPage(
      name: _Paths.CHAT_ROOM,
      page: () => const ChatRoomView(),
      binding: ChatRoomBinding(),
    ),
    GetPage(
      name: _Paths.MEDIAVIEWER,
      page: () => const MediaviewerView(),
      binding: MediaviewerBinding(),
    ),
    GetPage(
      name: _Paths.VIEW_CHAT,
      page: () => const ViewChatView(),
      binding: ViewChatBinding(),
    ),
    GetPage(
      name: _Paths.GALLARY,
      page: () => const GallaryView(),
      binding: GallaryBinding(),
    ),
  ];
}
