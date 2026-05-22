// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get mainTitle => 'مدير OBS';

  @override
  String get settings => 'الإعدادات';

  @override
  String get connectToObs => 'الاتصال بـ OBS';

  @override
  String get startStream => 'بدء البث';

  @override
  String get stopStream => 'إيقاف البث';

  @override
  String get scenes => 'المشاهد';

  @override
  String get sources => 'المصادر';

  @override
  String get unknownError => 'حدث خطأ غير معروف';

  @override
  String get connectionRefused => 'تم رفض الاتصال من قبل خادم OBS';

  @override
  String get wifiRequired => 'مطلوب اتصال Wi-Fi';

  @override
  String get cacheEmpty => 'لم يتم العثور على إعدادات اتصال محفوظة';

  @override
  String get timeoutError => 'انتهت مهلة الاتصال';
}
