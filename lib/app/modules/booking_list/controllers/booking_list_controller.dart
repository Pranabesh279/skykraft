import 'package:get/get.dart';
import 'package:skycraft/app/constants/constants.dart';
import 'package:skycraft/app/models/bookings/booking_mlodel.dart';
import 'package:skycraft/app/providers/auth_provider.dart';
import 'package:skycraft/app/providers/booking_provider.dart';
import 'package:skycraft/app/providers/wallet_provider.dart';

class BookingListController extends GetxController {
  AuthProvider authProvider = Get.find<AuthProvider>();
  BookingProvider bookingProvider = Get.find<BookingProvider>();
  WalletProvider walletProvider = Get.find<WalletProvider>();
  Rx<String> search = ''.obs;
  final RxList<BookingModel> _bookings = <BookingModel>[].obs;
  RxBool isAcceptLoading = false.obs;
  RxBool isRejectLoading = false.obs;
  RxBool isCompleteLoading = false.obs;

  List<BookingModel> get bookings => _bookings.where((element) {
        if (search.value.isEmpty) {
          return true;
        }
        return element.id!.contains(search.value) ||
            element.userId!.contains(search.value) ||
            element.dronUserId!.contains(search.value) ||
            element.totalAmount!.toString().contains(search.value) ||
            element.bookingStatus!.contains(search.value);
      }).toList();

  @override
  void onInit() {
    super.onInit();
    getBookings();
  }

  getBookings() {
    _bookings.bindStream(bookingProvider.getBookingsStream(
        authProvider.userModel.value!.uid!,
        userRole: authProvider.userModel.value!.role!));
  }

  String get curentUserRole => authProvider.userModel.value!.role!;

  void acceptBooking(String bookingId) {
    isAcceptLoading.value = true;
    Map<String, dynamic> data = {
      'bookingStatus': BookingStatus.accepted,
    };
    bookingProvider.updateBooking(bookingId, data).then((value) {
      isAcceptLoading.value = false;
      update();
      getBookings();
      _bookings.refresh();
    });
  }

  void rejectBooking(String bookingId) {
    isRejectLoading.value = true;
    Map<String, dynamic> data = {
      'bookingStatus': BookingStatus.rejected,
    };
    bookingProvider.updateBooking(bookingId, data).then((value) {
      isRejectLoading.value = false;
      update();
      getBookings();
      _bookings.refresh();
    });
  }

  bool isShowButtonSegment(String bookingStatus) {
    bool condition = true;
    if ((bookingStatus == BookingStatus.accepted ||
        bookingStatus == BookingStatus.rejected)) {
      condition = false;
    }

    return condition;
  }

  void completeBooking(String bookingId,
      {required String pilotId, required double totalAmount}) {
    isCompleteLoading.value = true;
    Map<String, dynamic> data = {
      'bookingStatus': BookingStatus.completed,
    };
    bookingProvider.updateBooking(bookingId, data).then((value) async {
      await walletProvider
          .updateWallet(pilotId, totalAmount,
              refId: bookingId, refType: 'bookings')
          .then((value) {
        isCompleteLoading.value = false;
        update();
        getBookings();
        _bookings.refresh();
      });
    });
  }
}
