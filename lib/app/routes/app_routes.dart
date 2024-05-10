part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const HOME = _Paths.HOME;
  static const LOGIN = _Paths.LOGIN;
  static const DASHBOARD = _Paths.DASHBOARD;
  static const DISCOVER = _Paths.DISCOVER;
  static const ACTIVITY = _Paths.ACTIVITY;
  static const PROFILE = _Paths.PROFILE;
  static const SPLASH = _Paths.SPLASH;
  static const SET_USER_ROLE = _Paths.SET_USER_ROLE;
  static const ADDPOST = _Paths.ADDPOST;
  static const GETLOCATION = _Paths.GETLOCATION;
  static const BUY_POST = _Paths.BUY_POST;
  static const PERMISSIONS = _Paths.PERMISSIONS;
  static const BIO = _Paths.BIO;
  static const CREATE_BOOKING = _Paths.CREATE_BOOKING;
  static const BOOKING_DETAILS = _Paths.BOOKING_DETAILS;
  static const ADDRESS_INPUT = _Paths.ADDRESS_INPUT;
  static const BOOKING_LIST = _Paths.BOOKING_LIST;
  static const EDIT_PROFILE = _Paths.EDIT_PROFILE;
}

abstract class _Paths {
  _Paths._();
  static const SPLASH = '/splash';
  static const HOME = '/home';
  static const LOGIN = '/login';
  static const DASHBOARD = '/dashboard';
  static const DISCOVER = '/discover';
  static const ACTIVITY = '/activity';
  static const PROFILE = '/profile';
  static const SET_USER_ROLE = '/set-user-role';
  static const ADDPOST = '/addpost';
  static const GETLOCATION = '/getlocation';
  static const BUY_POST = '/buy-post';
  static const PERMISSIONS = '/permissions';
  static const BIO = '/bio';
  static const CREATE_BOOKING = '/create-booking';
  static const BOOKING_DETAILS = '/booking-details';
  static const ADDRESS_INPUT = '/address-input';
  static const BOOKING_LIST = '/booking-list';
  static const EDIT_PROFILE = '/edit-profile';
}
