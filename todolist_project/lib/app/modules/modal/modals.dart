import 'package:flutter/material.dart';
import 'package:todolist_project/app/modules/modal/erro_modal.dart';
import 'package:todolist_project/app/modules/modal/sucess_modal.dart';

class ShowModal {
  static error({
    required BuildContext context,
    required String textMsg,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (context) => ShowModalError(errorText: textMsg),
      isScrollControlled: true,
      isDismissible: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
    );
  }

  static success({
    required BuildContext context,
    required String textMsg,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (context) => ShowSuccessModal(successText: textMsg),
      isScrollControlled: true,
      isDismissible: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
    );
  }
}
