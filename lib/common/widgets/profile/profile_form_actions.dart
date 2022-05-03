import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sample_shop/store/actions/user.action.dart';
import 'package:sample_shop/store/models/user/user.model.dart';
import 'package:sample_shop/store/reducers/reducer.dart';

class ProfileFormActions extends StatelessWidget {
  const ProfileFormActions(
      {Key? key,
      required this.isAllowEditing,
      required this.toggleAllowEditing,
      required this.createUserData,
      required this.cancelEditing})
      : super(key: key);
  final bool isAllowEditing;
  final void Function() toggleAllowEditing;
  final void Function() cancelEditing;
  final UserModel Function() createUserData;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (!isAllowEditing)
            IconButton(
                iconSize: 15.00,
                color: Theme.of(context).primaryColor,
                onPressed: toggleAllowEditing,
                icon: const FaIcon(FontAwesomeIcons.pen)),
          if (isAllowEditing)
            IconButton(
                iconSize: 22.00,
                color: Theme.of(context).primaryColor,
                onPressed: cancelEditing,
                icon: const FaIcon(FontAwesomeIcons.xmark)),
          if (isAllowEditing)
            StoreConnector<AppState, dynamic>(
                converter: (store) => (UserModel user) =>
                    store.dispatch(UpdateProfilePending(user: user)),
                builder: (context, updateProfile) => IconButton(
                    iconSize: 22.00,
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      updateProfile(createUserData());
                      toggleAllowEditing();
                    },
                    icon: const FaIcon(FontAwesomeIcons.floppyDisk))),
        ],
      ),
    );
  }
}
