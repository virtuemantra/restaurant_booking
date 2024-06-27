import 'package:flutter/material.dart';
import 'package:get/get.dart';


class Const {
  // ignore: constant_identifier_names
  static const CASH_FREE_APP_KEY = "332361b7d82361494363f63a74163233";

  // static const EMAIL_VERIFICATION_LINK = ApiKeys.baseUrl() + "57fe55ac900525062fd0760984d0578b?s=";

  static final RxInt notificationCount = 0.obs;
  static const razorPayKey = 'rzp_test_afiAHCLY5kWv0k';
  static AppLifecycleState lifecycleState = AppLifecycleState.resumed;

  static RxString selectedTicketValue = ''.obs;

  // static final Rx<Config> config = Config().obs;
  // static final Rx<ReferralConfig> referralConfig = ReferralConfig().obs;
  static RxString name = ''.obs;
  static RxString email = ''.obs;
  static RxString profilePic = ''.obs;
  static bool isDeveloper = true;
  static double loaderSize = 80;
  static double contestGroupHeight = 120;

  // static String currencySymbol = 'Rs.';
  static String currencySymbol = '₹';
  static String currencyCode = 'INR';
  static List<int> templateAmounts = [25,50, 100, 150, 200, 250, 300];

  static String timeZone = '';
  static String packageName = '';
  static String versionCode = '0';
  static String versionName = '0';

  static String dots = '• • •';

  static const alphabets = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M'];

  // static DeviceType deviceType = DeviceType.mobile;
  // static bool get isMobile => deviceType == DeviceType.mobile;
  // static bool get isTablet => deviceType == DeviceType.tablet;
  // static bool get isWeb => deviceType == DeviceType.web;
  // static bool get isMac => deviceType == DeviceType.mac;
  // static bool get isWindows => deviceType == DeviceType.windows;
  // static bool get isLinux => deviceType == DeviceType.linux;
  // static bool get isFuchsia => deviceType == DeviceType.fuchsia;
}

class Status {
  // ignore: constant_identifier_names
  static const NORMAL = 'normal';

  // ignore: constant_identifier_names
  static const PROGRESS = 'progress';

  // ignore: constant_identifier_names
  static const EMPTY = 'empty';

  // ignore: constant_identifier_names
  static const ERROR = 'error';

  // ignore: constant_identifier_names
  static const COMPLETED = 'completed';
}

class PaymentStatus {
  static const String CREDIT = 'CREDIT';
  static const String DEBIT = 'DEBIT';
  static const String WITHDRAW = 'WITHDRAW';
}

class PaymentType {
  static const String NEW_ORDER = 'NEW ORDER';
  static const String TIP = 'TIP';
  static const String REFUND = 'REFUND';
  static const String WITHDRAW = 'WITHDRAW';
}

class PaymentMethodStr {
  static const String PAYPAL = 'PAYPAL';
  static const String STRIPE = 'STRIPE';
  static const String RAZOR_PAY = 'RAZOR PAY';
}

class ContestType {
  static const String ALL = 'ALL';
  static const String UPCOMING = 'UPCOMING';
  static const String LIVE = 'LIVE';
  static const String COMPLETED = 'COMPLETED';
  static const String FULL = 'FULL';
  static const String PLAYED = 'PLAYED';
}

class FileUploadType {
  static const PROFILE_IMG = 'PROFILE_IMG';
  static const FILE = 'FILE';
  static const SMS_IMG = 'SMS_IMG';
}

class WithdrawPaymentMethod {
  static const String PAYPAL = 'PAYPAL';
  static const String ACCOUNT_NUMBER = 'ACCOUNT NUMBER';
}
