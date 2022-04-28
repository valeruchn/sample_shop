// Flutter imports:
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

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
        bottomNavigationBar: TabBar(
          controller: tabPage.controller,
          labelColor: Theme.of(context).primaryColor,
          unselectedLabelColor: Colors.grey,
          indicator: const UnderlineTabIndicator(
              borderSide: BorderSide(width: 0), insets: EdgeInsets.all(0)),
          tabs: const <Widget>[
            Tab(text: 'Домашня', icon: Icon(Icons.home)),
            Tab(text: 'Замовлення', icon: Icon(Icons.shopping_basket)),
            Tab(text: 'Додатково', icon: Icon(Icons.settings)),
            // Tab(text: 'Cart', icon: Icon(Icons.shopping_cart)),
          ],
        ));
  }
}
