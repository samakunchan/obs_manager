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

  @override
  String get audio => '音频';

  @override
  String get monitoring => '监控';

  @override
  String get isStarting => '正在启动';

  @override
  String get isStopping => '正在停止';

  @override
  String get quickAudioControl => '快速音频控制';

  @override
  String get obsOffline => 'OBS 离线';

  @override
  String get muted => '已静音';

  @override
  String get recordingDecibelsLive => '实时分贝录制中';

  @override
  String get connectToActiveObsServer => '连接到活动的 OBS 服务器';

  @override
  String get scenesDirectory => '场景目录';

  @override
  String get chooseVisibleMainScenes => '选择可见的主场景';

  @override
  String selected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '已选择 $count',
    );
    return '$_temp0';
  }

  @override
  String get noScenesDetected => '在 OBS 中未检测到场景';

  @override
  String get connectToObsToListScenes => '连接到 OBS 以列出场景';

  @override
  String get systemLogsAndMetadata => '系统日志';

  @override
  String get clearLogs => '清除日志';

  @override
  String get systemOnlineStandby => '系统在线。待机中。';

  @override
  String get cacheClear => '清除缓存';

  @override
  String get systemPurgeRequest => '系统清除请求';

  @override
  String get purgeWarningText => '警告：此操作将永久清除所有本地数据库注册表、缓存凭据和系统日志历史记录。\n\n您将退出控制台。确定要继续吗？';

  @override
  String get cancel => '取消';

  @override
  String get purge => '清除';

  @override
  String get cachePurgedSuccess => '缓存已完全清除并正常登出';

  @override
  String get closeConsole => '关闭控制台';

  @override
  String get connect => '连接';

  @override
  String get disconnect => '断开连接';

  @override
  String get connectionConsole => '连接控制台';

  @override
  String get obsWebsocketV5Configuration => 'OBS WebSocket v5 配置';

  @override
  String get obsWebSocketIp => 'OBS WebSocket IP 地址';

  @override
  String get ipRequired => 'IP 地址是必需的';

  @override
  String get obsWebSocketPort => 'OBS WebSocket 端口';

  @override
  String get portRequired => '端口是必需的';

  @override
  String get obsAuthenticationKey => '密码';

  @override
  String get obsPassword => 'OBS 密码';

  @override
  String get orConnectViaQrCode => '或通过二维码连接';

  @override
  String get scanQr => '扫描二维码';

  @override
  String get obsStationConfiguredSuccess => 'OBS 控制台已配置并在线安全连接';

  @override
  String get qrCodeScanner => '二维码扫描器';

  @override
  String get alignObsConsoleQrCode => '对齐 OBS 控制台二维码';

  @override
  String get enterManually => '手动输入';

  @override
  String get panelControl => '控制面板';

  @override
  String get onAir => '直播中';

  @override
  String get recStandby => '录制：待机';

  @override
  String presetsLoaded(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '已加载 $count 个预设',
    );
    return '$_temp0';
  }

  @override
  String get noSourcesDetected => '未检测到来源';

  @override
  String get sourcesOffline => '来源离线';

  @override
  String get connectObsToLoadInputs => '连接到 OBS 服务器以加载活动场景输入。';

  @override
  String get obsDisconnected => 'OBS 已断开连接';

  @override
  String get sceneCommandCenterOffline => '场景管理器已离线。请使用侧边栏中的控制台初始化您的连接。';

  @override
  String get openControlConsole => '打开连接';

  @override
  String get coreInitializationShowcase => '核心初始化展示';

  @override
  String get selectLanguage => '选择语言（本地化测试）';

  @override
  String get activeTranslations => '活动翻译';

  @override
  String get mappedErrorsAlerts => '映射错误与警报';

  @override
  String get clientServiceTitle => '客户端服务 (OBS WebSocket)';

  @override
  String get clientServiceDescription => '使用 dartz Either 边界集成函数式异常到失败的领域映射。';

  @override
  String get simulateObsFailure => '模拟 OBS 故障';

  @override
  String get apiServiceTitle => 'API 服务 (Dio REST 客户端)';

  @override
  String get apiServiceDescription => '管理通用 HTTP 请求、自定义拦截和结构化错误响应的 SOLID 客户端。';

  @override
  String get simulateHttpError => '模拟 HTTP 错误';

  @override
  String get simulationLogsMetadata => '模拟日志与元数据';

  @override
  String get systemOffline => '系统已离线';

  @override
  String get noWifiMessage => '需要本地 WiFi 网络连接才能通过本地 WebSocket 与 OBS Broadcaster Studio 进行通信。\n\n请检查您的系统设置并连接到 WiFi。';

  @override
  String get scanningSystem => '正在扫描系统...';

  @override
  String get rescanConnection => '重新扫描连接';

  @override
  String get linkRestoration => '链接恢复';

  @override
  String get reconnectingMessage => '已检测到 WiFi 网络连接。\n\n正在重新建立安全的本地 WebSocket 链接并与 OBS Studio 同步场景管道...';

  @override
  String get themeMode => '主题模式';

  @override
  String get themeLight => '浅色';

  @override
  String get themeDark => '深色';

  @override
  String get themeSystem => '系统';
}
