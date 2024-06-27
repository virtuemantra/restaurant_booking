import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get/get.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:restaurant_booking/utils/extensions.dart';
import 'package:restaurant_booking/utils/helper.dart';
import '../values/theme_colors.dart';
import 'const.dart';
import 'logger.dart';

export '../values/dimen.dart';
export '../values/size_config.dart';
export '../values/theme_colors.dart';
export 'const.dart';
export 'extensions.dart';
export 'preference.dart';
export 'toasty.dart';

typedef RefreshCallback = void Function();

class Helper {
  // static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static const String DATE_FORMAT_1 = "yyyy_MM_dd_HH_mm_ss";
  static const String DATE_FORMAT_2 = "yyyy-MM-dd HH:mm:ss";
  static const String DATE_FORMAT_3 = "dd MMM yyyy, hh:mm a";
  static const String DATE_FORMAT_4 = "dd MMM yyyy";
  static const String DATE_FORMAT_5 = "EEE, dd MMM yyyy, hh:mm a";
  static const String DATE_FORMAT_6 = "EEE, dd MMM yy";
  static const String DATE_FORMAT_7 = "EEE, dd MMM, hh:mm a";
  static const String DATE_FORMAT_8 = "EEE, dd MMM, yyyy";
  static const String DATE_FORMAT_9 = "MMM yyyy";
  static const String TIME_FORMAT_1 = "hh:mm a";
  static const String TIME_FORMAT_2 = "hh:mm:ss";
  static Map<String, RefreshCallback> fastRefreshCallbacks = <String, RefreshCallback>{};
  static Map<String, RefreshCallback> refreshCallbacks = <String, RefreshCallback>{};
  static Timer? _timer;
  static double buttonWidth = 70.w;

  static final RxBool networkAvailable = true.obs;
  static bool connectivityAlertShown = false;
  static final RxString errorTitle = ''.obs;
  static final RxString errorMessage = ''.obs;
  static int WIN_SOUND = 0;

  static setError(String title, String message) {
    errorTitle.value = title;
    errorMessage.value = message;
  }

  static clearError() {
    errorTitle.value = '';
    errorMessage.value = '';
  }





  // static Soundpool soundPool = Soundpool.fromOptions(
  //     options: SoundpoolOptions(androidOptions: SoundpoolOptionsAndroid(), iosOptions: SoundpoolOptionsIos()));
  //
  // static void initSoundPool() async {
  //   WIN_SOUND = await rootBundle.load("assets/audios/win.mp3").then((ByteData soundData) {
  //     return soundPool.load(soundData);
  //   });
  // }

  static const List<String> validImageExtensions = ['png', 'jpg', 'jpeg', 'webp'];


  static int get generateNumber => Random().nextInt(900000) + 100000;
  static void initAutoRefreshTimer({int delayInSeconds = 4}) {
    // if (Const.isDeveloper) return; //TODO

    if (_timer != null) {
      _timer?.cancel();
    }

    _timer = Timer.periodic(Duration(seconds: delayInSeconds), (timer) {
      if (Const.lifecycleState == AppLifecycleState.resumed) {
        int delay1 = 0;
        fastRefreshCallbacks.forEach((key, callback) {
          // value();
          Future.delayed(Duration(microseconds: delay1), () {
            callback();
            delay1 += 500;
          });
        });

        if (timer.tick.isOdd) {
          int delay2 = 0;
          refreshCallbacks.forEach((key, callback) {
            // value();
            Future.delayed(Duration(microseconds: delay2), () {
              callback();
              delay2 += 500;
            });
          });
        }
      }
    });

    checkNetworkAvailability();
    addRefreshCallback('checkNetworkAvailability', checkNetworkAvailability, fastRefresh: true);
  }

  static Future<bool> checkNetworkAvailability() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Helper.networkAvailable.value = true;
        return true;
      }
    } on SocketException catch (_) {
      Helper.networkAvailable.value = false;
    }
    return false;
  }

  static void addRefreshCallback(String key, VoidCallback callback, {bool fastRefresh = false}) {
    if (fastRefresh) {
      fastRefreshCallbacks.putIfAbsent(key, () => callback);
    } else {
      refreshCallbacks.putIfAbsent(key, () => callback);
    }
  }

  static void removeAutoRefreshCallback(String key) {
    if (fastRefreshCallbacks.containsKey(key)) fastRefreshCallbacks.remove(key);
    if (refreshCallbacks.containsKey(key)) refreshCallbacks.remove(key);
    Logger.m(tag: 'Removed From Refresh Callback', value: key);
  }

  //testbrain.dev+2@gmail.com

  static int parseInt(dynamic value) {
    if (value == null || value.toString().empty) {
      Logger.m(tag: 'INTEGER PARSE ERROR', value: 'EMPTY VALUE');
      return 0;
    }

    if (value is int) {
      return value;
    }

    if (value is String) {
      try {
        if (value.contains('.')) {
          value = (value as String).split('.')[0];
        }
        return value != null && value.isNotEmpty ? int.parse(value) : 0;
      } catch (e) {
        Logger.m(tag: 'INTEGER PARSE ERROR (' + value + ")", value: e);
      }
    }

    if (value is double) {
      return value.toInt();
    }

    return 0;
  }

  static double parseDouble(dynamic value) {
    if (value == null) {
      return 0.0;
    }

    if (value is int) {
      return value.toDouble();
    }

    if (value is String) {
      try {
        if (!value.contains('.')) {
          value = (value as String) + '.0';
        }
        return value.isNotEmpty ? double.parse(value) : 0;
      } catch (e) {
        return 0.0;
      }
    }

    if (value is double) {
      return value;
    }

    return 0.0;
  }

  static String checkNull(String value, {String defaultValue = ''}) {
    if (!isEmpty(value)) {
      return value;
    }
    return defaultValue.nullSafe;
  }

  static bool isEmpty(String? value) {
    return value == null || value == '' || value.isEmpty || value == 'null' || value.trim().isEmpty;
  }

  static bool isEmptyAny(List<String> values) {
    if (values == null) {
      return true;
    }

    for (int i = 0; i < values.length; i++) {
      if (isEmpty(values[i])) {
        return true;
      }
    }
    return false;
  }



  static Future<bool> requestPermission() async {
    DeviceInfoPlugin plugin = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo android = await plugin.androidInfo;
      if (android.version.sdkInt! < 33) {
        if (await Permission.storage.request().isGranted) {
          return true;
        } else if (await Permission.storage.request().isPermanentlyDenied) {
          await openAppSettings();
        } else if (await Permission.audio.request().isDenied) {
          return false;
        }
      } else {
        if (await Permission.photos.request().isGranted) {
          return true;
        } else if (await Permission.photos.request().isPermanentlyDenied) {
          await openAppSettings();
        } else if (await Permission.photos.request().isDenied) {
          return false;
        }
      }
    } else if (Platform.isIOS) {
      // IosDeviceInfo iosInfo = await plugin.iosInfo;
      if (await Permission.storage.request().isGranted) {
        return true;
      } else if (await Permission.storage.request().isPermanentlyDenied) {
        await openAppSettings();
      } else if (await Permission.storage.request().isDenied) {
        return false;
      }
    }
    return false;
  }

  // static Future<bool> requestPermission(Permission p) async {
  //   var permission = await p.request();
  //
  //   if (permission != PermissionStatus.granted) {
  //     permission = await p.request();
  //   }
  //
  //   return permission == PermissionStatus.granted;
  // }



  static bool isValidUrl(String path,
      {String imageName = '',
        List<String> validExtensions = const ['png', 'jpg', 'jpeg', 'webp', 'pdf', 'doc', 'docx']}) {
    if (isEmpty(path)) {
      return false;
    }

    path = path + imageName.nullSafe;

    String ext = path.split('.').last;

    if (path.startsWith('http') && validExtensions.contains(ext)) {
      return true;
    }

    return false;
  }

  static Widget spaceVertical([double space = 5]) => SizedBox(width: 0, height: space);

  static Widget spaceHorizontal(double space) => Container(width: space, height: 0);

  static BoxDecoration get dialogBoxDecoration => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),
    // boxShadow: [
    //   BoxShadow(color: Colors.grey.withOpacity(0.5), spreadRadius: 5, blurRadius: 7, offset: Offset(0, 3))
    // ],
  );

  static String getEveryFirstDigit(String? name) {
    if (Helper.isEmpty(name)) {
      return '?';
    }

    List<String> li = name.nullSafe.trim().split(' ');

    String str = '';

    if (li.length == 1 && li[0].length >= 2) {
      return li[0].substring(0, 2).toUpperCase();
    }

    li.forEach((element) => str += element.substring(0, 1));

    return str.toUpperCase();
  }

  // static String formatDays(String days) {
  //   if (isEmpty(days)) {
  //     return '';
  //   }
  //
  //   if (days == 'Mon,Tue,Wed,Thu,Fri,Sat,Sun') {
  //     return Strings.get('allDays');
  //   }
  //
  //   if (days == 'Mon,Tue,Wed,Thu,Fri,Sat') {
  //     return Strings.get('monday') + ' - ' + Strings.get('saturday');
  //   }
  //
  //   if (days == 'Mon,Tue,Wed,Thu,Fri') {
  //     return Strings.get('monday') + ' - ' + Strings.get('friday');
  //   }
  //
  //   if (days == 'Mon,Tue,Wed,Thu') {
  //     return Strings.get('monday') + ' - ' + Strings.get('thursday');
  //   }
  //
  //   if (days == 'Mon,Tue,Wed') {
  //     return Strings.get('monday') + ' - ' + Strings.get('wednesday');
  //   }
  //
  //   if (days == 'Mon,Tue') {
  //     return Strings.get('monday') + ' - ' + Strings.get('tuesday');
  //   }
  //
  //   if (days == 'Mon') {
  //     return Strings.get('monday');
  //   }
  //
  //   return days;
  // }


  static Future<File> cropImageFile(String? path) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: path.nullSafe,
        maxWidth: 200,
        maxHeight: 200,
        aspectRatioPresets: [CropAspectRatioPreset.square],
        uiSettings: [
    AndroidUiSettings(
    toolbarTitle: 'Crop',
      toolbarColor: ThemeColors.colorPrimary,
      toolbarWidgetColor: Colors.white,
      initAspectRatio: CropAspectRatioPreset.square,
      lockAspectRatio: true,
    ),
        IOSUiSettings(title: 'Crop', minimumAspectRatio: 1.0, aspectRatioLockEnabled: true)

    ],);

    return File(croppedFile!.path);
  }

  static String getTimeAgo(dynamic time) {
    if (time == null) {
      return '';
    }

    try {
      Duration diff;

      if (time.toString().isNumeric) {
        diff = DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(time.toString().toInt));
      } else {
        diff = DateTime.now().difference(DateTime.parse(time));
      }

      if (diff.inDays > 365)
        return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
      if (diff.inDays > 30)
        return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
      if (diff.inDays > 7)
        return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
      if (diff.inDays > 0) return "${diff.inDays} ${diff.inDays == 1 ? "day" : "days"} ago";
      if (diff.inHours > 0) return "${diff.inHours} ${diff.inHours == 1 ? "hour" : "hours"} ago";
      if (diff.inMinutes > 0) return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago";
      return "Just now";
    } catch (e) {
      Logger.ex(tag: 'GET TIME AGO', value: e);
      return time;
    }
  }

  static double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    if (lat1 == null ||
        lat2 == null ||
        lon1 == null ||
        lon2 == null ||
        lat1 <= 0.0 ||
        lat2 <= 0 ||
        lon1 <= 0 ||
        lon2 <= 0) {
      return -1;
    }
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p) / 2 + c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  static int get currentMillis => DateTime.now().microsecondsSinceEpoch;

  static String getCurrentDate(String format) {
    final DateFormat formatter = DateFormat(format);
    return formatter.format(DateTime.now());
  }

  static String formatDate(DateTime dateTime, String format) {
    final DateFormat formatter = DateFormat(format);
    return formatter.format(dateTime);
  }

  static String formatMilliseconds(int milli, String format) {
    final DateFormat formatter = DateFormat(format);
    return formatter.format(DateTime.fromMillisecondsSinceEpoch(milli));
  }

  static String format(String? dateTime, String? format) {
    try {
      final DateFormat formatter = DateFormat(format);
      return formatter.format(DateTime.parse(dateTime!.trim().nullSafe));
    } catch (e) {
      Logger.e(tag: "DATE FORMAT : ", value: e.toString());
      return dateTime.nullSafe;
    }
  }

  static DateTime formatDateTime(String dateTime) {
    try {
      return DateTime.parse(dateTime);
    } catch (e) {
      Logger.e(tag: "DATE FORMAT : ", value: e.toString());
      return DateTime(1990);
    }
  }

  static int convertToMillis(String dateTime) {
    try {
      return DateTime.parse(dateTime).millisecondsSinceEpoch;
    } catch (e) {
      Logger.e(tag: "DATE FORMAT : ", value: e.toString());
      return DateTime(1990).millisecondsSinceEpoch;
    }
  }

  static String getDay(String dateTime) {
    try {
      final DateFormat formatter = DateFormat('d');
      return formatter.format(DateTime.parse(dateTime));
    } catch (e) {
      Logger.e(tag: "DATE FORMAT : ", value: e.toString());
      return '';
    }
  }

  static String createGroupId(String first, String second) {
    if (first.hashCode > second.hashCode) {
      return first + '__' + second;
    } else {
      return second + '__' + first;
    }
  }

  static bool isContainKeyword(String? keyword, List<String?>? values) {
    if (!Helper.isEmpty(keyword) && values != null && values.length != 0) {
      for (int i = 0; i < values.length; i++) {
        if (!Helper.isEmpty(values[i]) && values[i]!.toLowerCase()!.contains(keyword?.toLowerCase() as Pattern)) {
          return true;
        }
      }
    }
    return false;
  }




  static String getTimeTile(String time, {bool isUtc = false}) {
    if (time.empty) {
      return '';
    }

    try {
      DateTime dateTime = DateTime.parse(time);
      DateTime onlyDate = DateTime(dateTime.year, dateTime.month, dateTime.day);
      Duration diff;

      diff = DateTime.timestamp().difference(dateTime);

      DateTime now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final yesterday = DateTime(now.year, now.month, now.day - 1);


      if (onlyDate == today) {
        return 'Today';
      }

      if (onlyDate == yesterday) {
        return 'Yesterday';
      }

      if (diff.inDays < 365) {
        return formatDate(dateTime, 'dd MMM');
      }

      return "${dateTime.year}";
    } catch (e) {
      Logger.ex(tag: 'GET TIME AGO', value: e.toString() + ' (' + time.toString() + ')');
      return '';
    }
  }

  static List<String> toList(String? s) {
    if (isEmpty(s)) {
      return <String>[];
    }

    List<String> li = s.nullSafe.split(',');
    return li.where((element) => !isEmpty(element)).toList();
  }

  static void currencyFormatter(String value, TextEditingController controller) {
    int dotCount = value.charCount('.');
    int allowedDigitBeforeDot = 8;
    int allowedDigitAfterDot = 4;

    if (dotCount > 1) {
      var v = value.split('.');

      value = v[0] + '.' + v[1];

      controller.value = TextEditingValue(text: value, selection: TextSelection.collapsed(offset: value.length));
    }

    if (dotCount > 0) {
      var v = value.split('.');

      if (v[0].length > allowedDigitBeforeDot) {
        v[0] = v[0].substring(0, allowedDigitBeforeDot);
      }

      if (v[1].length > allowedDigitAfterDot) {
        v[1] = v[1].substring(0, allowedDigitAfterDot);
      }

      value = v[0] + '.' + v[1];

      controller.value = TextEditingValue(text: value, selection: TextSelection.collapsed(offset: value.length));
    } else if (value.length > allowedDigitBeforeDot) {
      value = value.substring(0, allowedDigitBeforeDot);
      controller.value = TextEditingValue(text: value, selection: TextSelection.collapsed(offset: value.length));
    }
  }

  // static void logOut() {
  //   MyAlertDialog().
  //   disableIcon()
  //       .setButtonAlignment(Alignment.bottomCenter)
  //       .setTitleAlignment(Alignment.bottomCenter)
  //       .setMessageAlignment(Alignment.bottomCenter)
  //       .setFirstSpacing(30)
  //       .setSecondSpacing(15)
  //       .setTitle(Strings.get('logout') + '?')
  //       .setMessage(Strings.get('youWantToLogOut'))
  //       .setPositiveButton('yes'.t, () {
  //     logOutWithoutAlert();
  //   })
  //       .setNegativeButton('no'.t, null)
  //       .show();
  // }

  static void logOutWithoutAlert() {
    // Preference.setLogin(false);
    // Preference.clear();
    Get.back();
    Get.deleteAll();
    Helper.refreshCallbacks.clear();
    Helper.fastRefreshCallbacks.clear();
    // Get.offAll(() => LoginScreen());
  }

  static Future<bool> exitAlert() async {
    // MyAlertDialog()
    //     .setButtonAlignment(Alignment.bottomCenter)
    //     .setTitleAlignment(Alignment.bottomCenter)
    //     .setMessageAlignment(Alignment.bottomCenter)
    //     .setFirstSpacing(30)
    //     .setSecondSpacing(15)
    //     .setTitle(Strings.get('exit'))
    //     .setMessage(Strings.get('youWantToExitFromApp'))
    //     .setPositiveButton('yes'.t, () {
    //   SystemNavigator.pop();
    //
    // })
    //     .setNegativeButton('no'.t, null)
    //     .show();
    return false;
  }


  static String numberToString(int number) {
    switch (number) {
      case 0:
        return 'First';
      case 1:
        return 'Second';
      case 2:
        return 'Third';
      default:
        return (number + 1).toString() + "th";
    }
  }

  static formatNumber(String s, {bool withPlus = false}) {
    if (s.empty) {
      return '';
    }

    for (String c in [' ', '+', '-', '(', ')']) {
      s = s.replaceAll(c, '');
    }

    return (withPlus ? '+' : '') + s;
  }

  static String getFileNamePrefix(String pathType) {
    switch (pathType) {
      case FileUploadType.FILE:
        return 'FILE_';
      case FileUploadType.PROFILE_IMG:
        return 'PROFILE_';
      case FileUploadType.SMS_IMG:
        return 'SMS_IMG_';
    }
    return 'UNKNOWN_';
  }

  static String starred(String str, int count) {
    if (str.empty) return '';

    if (str.length < count) return str;

    return str.substring(0, count) + List.generate(min(str.length - count, 20), (index) => '*').join('');
  }

// static bool isValidPhoneNumber(String value) {
//   if (isEmpty(value)) {
//     return false;
//   }
//
//   if (value.length < 6 || value.length > 15) {
//     return false;
//   }

// String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
// RegExp regExp = new RegExp(pattern);
// if (!regExp.hasMatch(value)) {
//   return false;
// }
//   return true;
// }

  static String readableSeconds(int value) {
    Duration d = Duration(seconds: value);
    var seconds = d.inSeconds;
    final days = seconds ~/ Duration.secondsPerDay;
    seconds -= days * Duration.secondsPerDay;
    final hours = seconds ~/ Duration.secondsPerHour;
    seconds -= hours * Duration.secondsPerHour;
    final minutes = seconds ~/ Duration.secondsPerMinute;
    seconds -= minutes * Duration.secondsPerMinute;

    List<String> li = [];

    if (seconds > 0) {
      li.add(twoDigit(seconds));
      // timeUnit.value = 'Seconds Left';
    }

    if (minutes > 0) {
      li.add(twoDigit(minutes));
      // timeUnit.value = 'Minutes Left';
    }

    if (hours > 0) {
      li.add(twoDigit(hours));
      // timeUnit.value = 'Hours Left';
    }

    if (days > 0) {
      li.add(twoDigit(days));
      // timeUnit.value = 'Days Left';
    }

    // timeUnit.value = 'Left';
    return li.reversed.join(':');
  }

  static String twoDigit(int v) => v.toString().length < 2 ? '0' + v.toString() : v.toString();

  static double addDiscount(double amount, int discount) {
    // Discount = Listed Price × Discount Rate
    // Rate of Discount = Discount% = (Discount/Listed Price) ×100
    // Selling Price = Listed Price [(100−discount%)/100]
    // Listed Price = (Selling Price × 100)/(100−discount%)
    double discountAmount=amount*(discount/100);
double am=  amount-discountAmount;
    return    am;
  }

  static String getVerboseDateTimeRepresentation(int millis) {
    try {
      if (millis < 24 * 60 * 60 * 1000) {
        return 'Today ' + Helper.formatMilliseconds(millis, 'hh:mm a');
      } else if (millis < 7 * 24 * 60 * 60 * 1000) {
        return Helper.formatMilliseconds(millis, 'EEEE dd,MMM');
      }
      if (millis < 365 * 24 * 60 * 60 * 1000) {
        return Helper.formatMilliseconds(millis, 'dd, MMM');
      } else {
        return Helper.formatMilliseconds(millis, 'dd, MMM, yyyy');
      }
    } catch (e) {
      Logger.e(tag: 'DateTimeRepresentation', value: e);
      return '';
    }
  }


  static  Future<void> requestNotificationPermissions() async {
    if(Platform.isAndroid) {
      final PermissionStatus status = await Permission.notification.request();
      if (status.isGranted) {
        // NotificationServices notificationServices = NotificationServices();
        // notificationServices.firebaseInit(Get.context!);
        // notificationServices.handleBackgroundMessage(Get.context!);
      } else if (status.isDenied) {
        // Notification permissions denied
      } else if (status.isPermanentlyDenied) {
        await openAppSettings();
      }
    } else {
      await Permission.notification.request();
    }
  }
}
