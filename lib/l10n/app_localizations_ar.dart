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

  @override
  String get audio => 'الصوت';

  @override
  String get monitoring => 'المراقبة';

  @override
  String get isStarting => 'جاري البدء';

  @override
  String get isStopping => 'جاري الإيقاف';

  @override
  String get quickAudioControl => 'التحكم السريع في الصوت';

  @override
  String get obsOffline => 'OBS غير متصل';

  @override
  String get muted => 'كتم الصوت';

  @override
  String get recordingDecibelsLive => 'تفعيل / إيقاف الميكروفون مباشرة';

  @override
  String get connectToActiveObsServer => 'الاتصال بخادم OBS النشط';

  @override
  String get scenesDirectory => 'دليل المشاهد';

  @override
  String get chooseVisibleMainScenes => 'اختر المشاهد الرئيسية المرئية';

  @override
  String selected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count محدد',
      many: '$count محددًا',
      few: '$count محددة',
      two: '2 محدد',
      one: '1 محدد',
      zero: '0 محدد',
    );
    return '$_temp0';
  }

  @override
  String get noScenesDetected => 'لم يتم اكتشاف مشاهد في OBS';

  @override
  String get connectToObsToListScenes => 'الاتصل بـ OBS لعرض المشاهد';

  @override
  String get systemLogsAndMetadata => 'سجلات النظام';

  @override
  String get clearLogs => 'مسح السجلات';

  @override
  String get systemOnlineStandby => 'النظام متصل. في وضع الاستعداد.';

  @override
  String get cacheClear => 'مسح ذاكرة التخزين المؤقت';

  @override
  String get systemPurgeRequest => 'طلب تطهير النظام';

  @override
  String get purgeWarningText =>
      'تحذير: ستقوم هذه العملية بمسح جميع سجلات قاعدة البيانات المحلية، أوراق الاعتماد المخزنة مؤقتًا، وسجل النظام بشكل دائم.\n\nسيتم تسجيل خروجك من المحطة. هل أنت متأكد أنك تريد الاستمرار؟';

  @override
  String get cancel => 'إلغاء';

  @override
  String get purge => 'تطهير';

  @override
  String get cachePurgedSuccess => 'تم مسح ذاكرة التخزين المؤقت بالكامل وتم تسجيل الخروج بنجاح';

  @override
  String get closeConsole => 'إغلاق وحدة التحكم';

  @override
  String get connect => 'اتصال';

  @override
  String get disconnect => 'قطع الاتصال';

  @override
  String get connectionConsole => 'وحدة تحكم الاتصال';

  @override
  String get obsWebsocketV5Configuration => 'تكوين OBS WebSocket v5';

  @override
  String get obsWebSocketIp => 'عنوان IP لـ OBS WebSocket';

  @override
  String get ipRequired => 'عنوان IP مطلوب';

  @override
  String get obsWebSocketPort => 'منفذ OBS WebSocket';

  @override
  String get portRequired => 'المنفذ مطلوب';

  @override
  String get obsAuthenticationKey => 'كلمة المرور';

  @override
  String get obsPassword => 'كلمة مرور OBS';

  @override
  String get orConnectViaQrCode => 'أو الاتصال عبر رمز QR';

  @override
  String get scanQr => 'مسح رمز QR';

  @override
  String get obsStationConfiguredSuccess => 'تم تكوين محطة OBS وتأمينها عبر الإنترنت';

  @override
  String get qrCodeScanner => 'قارئ رمز QR';

  @override
  String get alignObsConsoleQrCode => 'قم بمحاذاة رمز QR لوحدة تحكم OBS';

  @override
  String get enterManually => 'إدخال يدوي';

  @override
  String get panelControl => 'لوحة التحكم';

  @override
  String get onAir => 'على الهواء';

  @override
  String get recStandby => 'تسجيل: في الاستعداد';

  @override
  String presetsLoaded(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count إعداد مسبق محمل',
      many: '$count إعدادًا مسبقًا محملًا',
      few: '$count إعدادات مسبقة محملة',
      two: 'إعدادين مسبقين محملين',
      one: 'إعداد مسبق واحد محمل',
      zero: '0 إعداد مسبق محمل',
    );
    return '$_temp0';
  }

  @override
  String get noSourcesDetected => 'لم يتم العثور على مصادر';

  @override
  String get sourcesOffline => 'المصادر غير متصلة';

  @override
  String get connectObsToLoadInputs => 'اتصل بخادم OBS لتحميل مدخلات المشهد النشطة.';

  @override
  String get obsDisconnected => 'OBS غير متصل';

  @override
  String get sceneCommandCenterOffline =>
      'مدير المشاهد غير متصل. يرجى تهيئة الاتصال الخاص بك باستخدام وحدة تحكم المحطة في الشريط الجانبي.';

  @override
  String get openControlConsole => 'افتح الاتصال';

  @override
  String get coreInitializationShowcase => 'عرض التهيئة الأساسي';

  @override
  String get selectLanguage => 'اختر اللغة (اختبار الترجمة)';

  @override
  String get activeTranslations => 'الترجمات النشطة';

  @override
  String get mappedErrorsAlerts => 'الأخطاء والتنبيهات المخططة';

  @override
  String get clientServiceTitle => 'خدمة العميل (OBS WebSocket)';

  @override
  String get clientServiceDescription => 'يدمج تخطيط مجال الاستثناء إلى الفشل الوظيفي باستخدام حدود Either من dartz.';

  @override
  String get simulateObsFailure => 'محاكاة فشل OBS';

  @override
  String get apiServiceTitle => 'خدمة API (عميل REST Dio)';

  @override
  String get apiServiceDescription => 'عميل SOLID يدير طلبات HTTP العامة، والاعتراضات المخصصة، واستجابات الأخطاء المنظمة.';

  @override
  String get simulateHttpError => 'محاكاة خطأ HTTP';

  @override
  String get simulationLogsMetadata => 'سجلات المحاكاة والبيانات الوصفية';

  @override
  String get systemOffline => 'النظام غير متصل';

  @override
  String get noWifiMessage =>
      'يلزم وجود اتصال بشبكة WiFi المحلية للتواصل مع OBS Broadcaster Studio عبر WebSocket المحلي.\n\nيرجى التحقق من إعدادات النظام والاتصال بشبكة WiFi.';

  @override
  String get scanningSystem => 'جاري فحص النظام...';

  @override
  String get rescanConnection => 'إعادة فحص الاتصال';

  @override
  String get linkRestoration => 'استعادة الاتصال';

  @override
  String get reconnectingMessage =>
      'تم اكتشاف اتصال بشبكة WiFi.\n\nجاري إعادة إنشاء روابط WebSocket المحلية الآمنة ومزامنة خطوط المشهد مع OBS Studio...';

  @override
  String get themeMode => 'وضع المظهر';

  @override
  String get themeLight => 'فاتح';

  @override
  String get themeDark => 'داكن';

  @override
  String get themeSystem => 'النظام';
}
