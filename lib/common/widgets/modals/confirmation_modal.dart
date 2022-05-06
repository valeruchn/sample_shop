// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:routemaster/routemaster.dart';

// Project imports:
import 'package:sample_shop/common/helpers/constants/colors_constants.dart';
import 'package:sample_shop/common/widgets/buttons/modal_dialog_button.dart';

void confirmationModal(
    {required BuildContext context,
    required String dialog,
    required Function() action}) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Container(
            decoration: BoxDecoration(
                color: kBackGroundColor,
                borderRadius: BorderRadius.circular(20)),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(dialog,
                    style: const TextStyle(
                      fontSize: 17.00,
                      color: kDefaultTextColor,
                      decoration: TextDecoration.none,
                    )),
                Container(
                  margin: const EdgeInsets.only(top: 20.00),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ModalDialogButton.cancel(
                          action: () => Routemaster.of(context).pop()),
                      const SizedBox(
                        width: 30.00,
                      ),
                      ModalDialogButton.apply(action: action),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      });
}
