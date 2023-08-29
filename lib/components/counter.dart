import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';

class CounterView extends StatefulWidget {
  const CounterView({Key? key}) : super(key: key);

  static Future backgroundCallback(Uri? uri) async {
    if (uri?.host == 'updateCounter') {
      int counter = 0;
      await HomeWidget.getWidgetData('_counter', defaultValue: 0).then((value) {
        counter = value!;
        counter++;
      });
      await HomeWidget.saveWidgetData('_counter', counter);
      await HomeWidget.updateWidget(
        name: 'HomeScreenWidgetProvider',
        iOSName: 'HomeScreenWidgetProvider',
      );
    }
  }

  @override
  State<CounterView> createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {
  int counter = 0;

  @override
  void initState() {
    super.initState();
    HomeWidget.widgetClicked.listen((Uri? uri) => loadData());
    loadData();
  }

  Future loadData() async {
    await HomeWidget.getWidgetData('_counter', defaultValue: 0).then((value) {
      counter = value!;
    });
    setState(() {});
  }

  Future updateData() async {
    await HomeWidget.saveWidgetData('_counter', counter);
    await HomeWidget.saveWidgetData('_counter', counter);
    await HomeWidget.updateWidget(
      name: 'HomeScreenWidgetProvider',
      iOSName: 'HomeScreenWidgetProvider',
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          counter++;
        });
        updateData();
      },
      child: Text('Counter: $counter'),
    );
  }
}
