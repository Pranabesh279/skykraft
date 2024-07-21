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
  static const TERMS_AND_CONDITIONS = _Paths.TERMS_AND_CONDITIONS;
  static const PRIVACY_POLICY = _Paths.PRIVACY_POLICY;
  static const LOCATION_PERMISSION = _Paths.LOCATION_PERMISSION;
  static const AUTH_PHONE = _Paths.AUTH_PHONE;
  static const AUTH_PHONE_VERIFY = _Paths.AUTH_PHONE_VERIFY;
  static const ADD_USER_PROFILE = _Paths.ADD_USER_PROFILE;
  static const UPLOAD_MEDIA = _Paths.UPLOAD_MEDIA;
  static const CHAT_ROOM = _Paths.CHAT_ROOM;
  static const MEDIAVIEWER = _Paths.MEDIAVIEWER;
  static const VIEW_CHAT = _Paths.VIEW_CHAT;
  static const GALLARY = _Paths.GALLARY;
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
  static const TERMS_AND_CONDITIONS = '/terms-and-conditions';
  static const PRIVACY_POLICY = '/privacy-policy';
  static const LOCATION_PERMISSION = '/location-permission';
  static const AUTH_PHONE = '/auth-phone';
  static const AUTH_PHONE_VERIFY = '/auth-phone-verify';
  static const ADD_USER_PROFILE = '/add-user-profile';
  static const UPLOAD_MEDIA = '/upload-media';
  static const CHAT_ROOM = '/chat-room';
  static const MEDIAVIEWER = '/mediaviewer';
  static const VIEW_CHAT = '/view-chat';
  static const GALLARY = '/gallary';
}
