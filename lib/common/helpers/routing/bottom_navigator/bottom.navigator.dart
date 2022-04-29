// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:routemaster/routemaster.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavigator extends StatefulWidget {
  BottomNavigator({Key? key}) : super(key: key);

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  @override
  Widget build(BuildContext context) {
    final tabPage = TabPage.of(context);
    return Scaffold(
        body: TabBarView(
          controller: tabPage.controller,
          children: [
            for (final stack in tabPage.stacks)
              PageStackNavigator(stack: stack),
          ],
        ),
        bottomNavigationBar: Container(
          color: const Color(0xFF313E44),
          child: TabBar(
            controller: tabPage.controller,
            labelColor: Theme.of(context).primaryColor,
            unselectedLabelColor: Colors.grey,
            indicator: const UnderlineTabIndicator(
                borderSide: BorderSide(width: 0), insets: EdgeInsets.all(0)),
            tabs: const <Widget>[
              Tab(text: 'Домашня', icon: FaIcon(FontAwesomeIcons.house)),
              Tab(text: 'Замовлення', icon: FaIcon(FontAwesomeIcons.cartShopping)),
              Tab(text: 'Додатково', icon: FaIcon(FontAwesomeIcons.bars)),
              // Tab(text: 'Cart', icon: Icon(Icons.shopping_cart)),
            ],
          ),
        ));
  }
}
