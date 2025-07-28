// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get login => 'تسجيل دخول';

  @override
  String get register => 'انشاء حساب';

  @override
  String get hello => 'مرحباً ديلان!';

  @override
  String get now_set =>
      'الآن كل شيء جاهز.\nلنصنع فعالياتك استثنائية،\nابدأ من هنا!';

  @override
  String get plan_event => 'أنشئ فعالية';

  @override
  String get invitations => 'الدعوات';

  @override
  String get no_invitations => 'لا توجد دعوات';

  @override
  String get no_invitations_desc =>
      'لم تستلم أي دعوة؟ بادر وأنشئ فعاليتك الخاصة مع EventJoy. الأمر سهل وممتع!';

  @override
  String get upcoming_events => 'الفعاليات القادمة';

  @override
  String get no_events => 'لا توجد فعاليات';

  @override
  String get no_events_desc =>
      'تقويم فعالياتك فارغ. استخدم EventJoy لملئه بلحظات لا تُنسى.';

  @override
  String get change_theme => 'تغيير الثيم';

  @override
  String get change_language => 'تغيير اللغة';

  @override
  String get edit_profile => 'تعديل الملف الشخصي';

  @override
  String get notification => 'الإشعارات';

  @override
  String get contact_us => 'تواصل معنا';

  @override
  String get sign_out => 'تسجيل الخروج';
}
