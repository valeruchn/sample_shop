import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:sample_shop/common/services/auth.service.dart';

void logoutConfirmation(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Container(
            decoration: BoxDecoration(
                color: const Color(0xFF313E44),
                borderRadius: BorderRadius.circular(20)),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Бажаєте вийти з профілю?',
                    style: TextStyle(
                      fontSize: 17.00,
                      color: Colors.white,
                      decoration: TextDecoration.none,
                    )),
                Container(
                  margin: const EdgeInsets.only(top: 20.00),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 20.00),
                        height: 40.00,
                        width: 100.00,
                        child: ElevatedButton(
                            onPressed: () => Routemaster.of(context).pop(),
                            child: const Text('Відміна')),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 20.00),
                        height: 40.00,
                        width: 100.00,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.grey)),
                            onPressed: () {
                              authService.logOut();
                              Routemaster.of(context)
                                ..pop()
                                ..push('/Settings');
                            },
                            child: const Text('Так')),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      });
}
