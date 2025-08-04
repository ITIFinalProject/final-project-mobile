// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 's.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class SAr extends S {
  SAr([String locale = 'ar']) : super(locale);

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get register => 'إنشاء حساب';

  @override
  String get welcome => 'مرحبًا';

  @override
  String get entertainment => 'ترفيه';

  @override
  String get educationalAndbusiness => 'تعليمي وأعمال';

  @override
  String get culturalAndarts => 'ثقافة وفنون';

  @override
  String get sportsAndfitness => 'رياضة ولياقة';

  @override
  String get technologyAndinnovation => 'تقنية وابتكار';

  @override
  String get travelAndadventure => 'سفر ومغامرة';

  @override
  String get events => 'الفعاليات';

  @override
  String get edit_event => 'تعديل الفعالية';

  @override
  String get event_updated_successfully => 'تم تحديث الفعالية بنجاح';

  @override
  String get end_datetime_must_be_after_start_datetime =>
      'يجب ان يكون تاريخ/وقت الانتهاء بعد تاريخ/وقت البدء';

  @override
  String get no_events => 'لا توجد فعاليات';

  @override
  String start_text(Object start) {
    return 'البداية: $start';
  }

  @override
  String get please_enter_number_of_attendees => 'من فضلك أدخل عدد الحضور';

  @override
  String get please_enter_host_name => 'من فضلك أدخل اسم المنظم';

  @override
  String get no_created_events => 'لم تقم بإنشاء أي أحداث بعد.';

  @override
  String get no_events_created => 'لم يتم إنشاء أي فعاليات';

  @override
  String get confirm_delete_event => 'هل أنت متأكد أنك تريد حذف هذه الفعالية؟';

  @override
  String get delete_event => 'حذف الفعالية';

  @override
  String get ok => 'حسنًا';

  @override
  String get interestedEvents => 'الفعاليات المهتم بها';

  @override
  String get joinedSuccessfully => 'تم الانضمام بنجاح';

  @override
  String get noInterestedEvents => 'لا توجد فعاليات مهتم بها حتى الآن.';

  @override
  String get eventDeletedSuccessfully => 'تم حذف الفعالية بنجاح';

  @override
  String get update_event => 'تحديث الفعالية';

  @override
  String get create_event => 'انشئ فعاليه';

  @override
  String get customize => 'تخصيص';

  @override
  String get your_event_cover_here => 'غلاف الفعالية هنا';

  @override
  String get upload_image => 'رفع صورة';

  @override
  String get choose_template => 'اختر قالبًا';

  @override
  String get messages => 'الرسائل';

  @override
  String get no_joined_events_yet => 'لم تنضم الى اى احداث بعد';

  @override
  String get next_event_details => 'التالي: تفاصيل الفعالية';

  @override
  String get step_2_of_5_event_details => '2 من 5: تفاصيل الفعالية';

  @override
  String get event_title => 'عنوان الفعالية';

  @override
  String get enter_event_title => 'أدخل عنوان الفعالية';

  @override
  String get please_enter_your_event_title => 'من فضلك ادخل اسم الفعالية';

  @override
  String get event_category => 'فئة الفعالية';

  @override
  String get select_event_category => 'اختر فئة الفعالية';

  @override
  String get pleaseselect_event_category => 'من فضلك اختر فئة الفعالية';

  @override
  String get event_description => 'وصف الفعالية';

  @override
  String get write_your_event_description => 'اكتب وصف الفعالية';

  @override
  String get please_enter_your_event_description => 'من فضلك ادخل وصف الفعالية';

  @override
  String get event_type => 'نوع الفعالية';

  @override
  String get select_event_type => 'اختر نوع الفعالية';

  @override
  String get please_select_event_type => 'من فضلك اختر نوع الفعالية';

  @override
  String get private => 'خاصة';

  @override
  String get public => 'عامة';

  @override
  String get pick_location => 'اختيار الموقع';

  @override
  String get event_timing => 'موعد الفعالية';

  @override
  String get addguests => '٤ من ٥: أضف الضيوف';

  @override
  String get start_date => 'تاريخ البدء';

  @override
  String get start_time => 'وقت البدء';

  @override
  String get search_contacts => 'ابحث عن جهات الاتصال';

  @override
  String get no_number => 'لا يوجد رقم';

  @override
  String get done => 'تم';

  @override
  String get see_all => 'عرض الكل';

  @override
  String get next_review_send => 'التالي: المراجعة والإرسال';

  @override
  String get invitations_sent => 'تم إرسال الدعوات بنجاح';

  @override
  String get create_contact => 'إنشاء جهة اتصال';

  @override
  String get guest_email => 'البريد الإلكتروني للضيف';

  @override
  String get capacity_reached => 'تم الوصول إلى الحد الأقصى للسعة';

  @override
  String get cancel => 'إلغاء';

  @override
  String get please_add_one_guest => 'يرجى إضافة ضيف واحد على الأقل';

  @override
  String get no_valid_users_found =>
      'لم يتم العثور على مستخدمين مسجلين صالحين.';

  @override
  String get error_fetching_guest_data => 'حدث خطأ أثناء جلب بيانات الضيوف';

  @override
  String get save => 'حفظ';

  @override
  String get failed_to_create_event => 'فشل في إنشاء الحدث';

  @override
  String get event_details_step => '٢ من ٥: تفاصيل الحدث';

  @override
  String get end_date => 'تاريخ الانتهاء';

  @override
  String get please_enter_your_start_date => 'من فضلك ادخل تاريخ البدء';

  @override
  String get please_enter_your_end_date => 'من فضلك ادخل تاريخ الانتهاء';

  @override
  String get please_enter_your_start_time => 'من فضلك ادخل وقت البدء';

  @override
  String get please_enter_your_end_time => 'من فضلك ادخل وقت الانتهاء';

  @override
  String get yyyymmdd => 'عام-شهر-يوم';

  @override
  String get end_time => 'وقت الانتهاء';

  @override
  String get location => 'الموقع';

  @override
  String get enter_event_location => 'ادخل مكان الفعالية';

  @override
  String get please_enter_your_event_location => 'من فضلك ادخل مكان الفعالية';

  @override
  String get category => 'الفئة';

  @override
  String get select_category => 'اختر الفئة';

  @override
  String get please_select_category => 'من فضلك اختر الفئة';

  @override
  String get open_google_maps => 'افتح خرائط جوجل';

  @override
  String get attendees => 'الحضور';

  @override
  String get enter_number_of_attendees => 'أدخل عدد الحضور';

  @override
  String get hosted_by => 'بواسطة';

  @override
  String get enter_host_name => 'أدخل اسم المنظم';

  @override
  String get next_preview => 'التالي: المعاينة';

  @override
  String get upcoming_events => 'الفعاليات القادمة';

  @override
  String get recommended_events => 'الفعاليات المقترحة';

  @override
  String get search => 'بحث';

  @override
  String get no_events_desc => 'انشئ حدث وكون بعض الذكريات';

  @override
  String get change_theme => 'تغيير النمط';

  @override
  String get change_language => 'تغيير اللغة';

  @override
  String get edit_profile => 'تعديل الملف الشخصي';

  @override
  String get name => 'الاسم';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get phone => 'رقم الهاتف';

  @override
  String get address => 'العنوان';

  @override
  String get save_changes => 'حفظ التغييرات';

  @override
  String get profile_updated_successfully => 'تم تحديث الملف الشخصي بنجاح';

  @override
  String get notification => 'الإشعارات';

  @override
  String get contact_us => 'اتصل بنا';

  @override
  String get sign_out => 'تسجيل الخروج';

  @override
  String get change_password => 'تغيير كلمة المرور';

  @override
  String get forgot_password => 'نسيت كلمة المرور؟';

  @override
  String get verify_password => 'تأكيد كلمة المرور';

  @override
  String get verify => 'تحقق';

  @override
  String get enter_old_password1 => 'أدخل كلمة المرور القديمة';

  @override
  String get new_password => 'كلمة المرور الجديدة';

  @override
  String get confirm_password => 'تأكيد كلمة المرور';

  @override
  String get password_updated_successfully => 'تم تحديث كلمة المرور بنجاح';

  @override
  String get save_password => 'حفظ كلمة المرور';

  @override
  String get my_events => 'فعالياتي';

  @override
  String get capacity => 'السعة';

  @override
  String get please_enter_capacity => 'من فضلك ادخل عدد الحضور';

  @override
  String get enter_valid_number => 'ادخل رقم صالح';

  @override
  String get edit => 'تعديل';

  @override
  String get delete => 'حذف';

  @override
  String get event_memories => 'ذكريات الفعاليات';

  @override
  String get no_ended_events_yet => 'لا توجد فعاليات منتهية بعد';

  @override
  String get no_user_data_found => 'لم يتم العثور على بيانات المستخدم';

  @override
  String get take_a_photo => 'التقط صورة';

  @override
  String get choose_from_gallery => 'اختر من المعرض';

  @override
  String get no_events_found_in_this_category =>
      'لم يتم العثور على اى أحداث فى هذه الفئة';

  @override
  String get join => 'انضم';

  @override
  String get ask_ai_about_anything => 'اسأل الذكاء الاصطناعى عن اى شئ';

  @override
  String get ai_chat => 'دردشة مع الذكاء الاصطناعى';

  @override
  String get write_your_message_here => 'اكتب رسالتك هنا';

  @override
  String get no_results_found => 'لا توجد نتائج';

  @override
  String get login_required_message => 'يجب تسجيل الدخول للوصول إلى الدردشة';

  @override
  String get chat => 'الدردشة';

  @override
  String get no_messages_yet => 'لا توجد رسائل بعد';

  @override
  String get write_a_message => 'اكتب رسالة...';

  @override
  String get send_a_message_to_your_guests => 'ارسل رسالة الى ضيوفك';

  @override
  String get enter_old_password => 'من فضلك أدخل كلمة المرور القديمة';

  @override
  String get password_min_length => 'كلمة المرور يجب أن تكون على الأقل 6 أحرف';

  @override
  String get passwords_do_not_match => 'كلمتا المرور غير متطابقتين';

  @override
  String get wrong_password => 'كلمة سر خاطئة حاول مرة اخرى';

  @override
  String get customize_step_title => '١ من ٥: التخصيص';

  @override
  String get createEventAndMakeMemories => 'أنشئ فعالية واصنع بعض الذكريات';

  @override
  String get noEventsForThatDay => 'لا توجد فعاليات لهذا اليوم';

  @override
  String get eventMemories => 'ذكريات الفعالية';

  @override
  String get noEndedEventsYet => 'لا توجد فعاليات منتهية بعد.';

  @override
  String get eventMemory => 'ذكرى الفعالية';
}
