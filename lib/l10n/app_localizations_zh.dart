// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get mainTitle => 'OBS 控制台';

  @override
  String get settings => '设置';

  @override
  String get connectToObs => '连接到 OBS';

  @override
  String get startStream => '开始推流';

  @override
  String get stopStream => '停止推流';

  @override
  String get scenes => '场景';

  @override
  String get sources => '来源';

  @override
  String get unknownError => '发生未知错误';

  @override
  String get connectionRefused => 'OBS 服务器拒绝连接';

  @override
  String get wifiRequired => '需要 Wi-Fi 连接';

  @override
  String get cacheEmpty => '未找到缓存的连接设置';

  @override
  String get timeoutError => '连接超时';
}
