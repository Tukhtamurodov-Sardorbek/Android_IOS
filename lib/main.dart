import 'package:call_platform_specific_code/components/counter.dart';
import 'package:call_platform_specific_code/constants.dart';
import 'package:flutter/material.dart';
import 'package:call_platform_specific_code/app.dart';
import 'package:home_widget/home_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HomeWidget.setAppGroupId(Constants.groupId);
  await HomeWidget.registerBackgroundCallback(
    CounterView.backgroundCallback,
  );
  runApp(const App());
}
