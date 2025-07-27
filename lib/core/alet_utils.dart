import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

void showErrorQuickAlert({
  required BuildContext context,
  required String title,
  required String message,
  void Function()? onConfirmBtnTap,
  bool disableBackBtn = false,
  bool barrierDismissible = true,
}) {
  QuickAlert.show(
    context: context,
    type: QuickAlertType.error,
    disableBackBtn: disableBackBtn,
    barrierDismissible: barrierDismissible,
    animType: QuickAlertAnimType.slideInUp,
    confirmBtnText: 'تأكيد',
    cancelBtnText: 'إلغاء',
    title: '',
    widget: Center(child: Column(children: [Text(title), Text(message)])),
    onConfirmBtnTap: onConfirmBtnTap,
  );
}

void showWarningQuickAlert({
  required BuildContext context,
  required String title,
  String? message,
  String messageBody = '',
  bool showCancleBtn = true,
  String cancelBtnText = 'cancel',
  String confirmBtnText = 'ok',
  String decrption = '',
  void Function()? onPressed,
}) {
  QuickAlert.show(
    context: context,
    type: QuickAlertType.warning,
    animType: QuickAlertAnimType.slideInUp,
    confirmBtnText: confirmBtnText,

    onConfirmBtnTap: onPressed,
    cancelBtnText: cancelBtnText,
    showCancelBtn: showCancleBtn,
    // onConfirmBtnTap: () => Navigator.pop(context),
    cancelBtnTextStyle: const TextStyle(
      color: Colors.red,
      fontWeight: FontWeight.bold,
      fontSize: 18,
    ),
    showConfirmBtn: true,
    onCancelBtnTap: () => Navigator.pop(context),
    widget: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(messageBody),

        Text(decrption, softWrap: true, overflow: TextOverflow.visible),
      ],
    ),
    title: title,
    text: message,
  );
}

void showSuccessQuickAlert({
  required BuildContext context,
  required String title,
  required String message,
}) {
  QuickAlert.show(
    context: context,
    type: QuickAlertType.success,
    animType: QuickAlertAnimType.slideInUp,
    confirmBtnText: 'تأكيد',
    cancelBtnText: 'إلغاء',
    title: title,
    text: message,
  );
}

void showWarrningQuickAlert({
  required BuildContext context,
  required String title,
  String? warn,
  required String message,
}) {
  QuickAlert.show(
    context: context,
    type: QuickAlertType.info,
    animType: QuickAlertAnimType.slideInUp,
    confirmBtnText: 'تأكيد',
    cancelBtnText: 'إلغاء',
    title: title,
    widget: Column(
      mainAxisSize: MainAxisSize.min, // يضمن عدم تمدد العمود أكثر من اللازم
      children: [
        if (warn != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(warn, textAlign: TextAlign.center),
          ),
        SizedBox(
          height: 150,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(message, textAlign: TextAlign.center),
            ),
          ),
        ),
      ],
    ),
  );
}
