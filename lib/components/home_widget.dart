import 'package:call_platform_specific_code/constants.dart';
import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';

class HomeWidgetButtonView extends StatefulWidget {
  const HomeWidgetButtonView({super.key});

  @override
  State<HomeWidgetButtonView> createState() => _HomeWidgetButtonViewState();
}

class _HomeWidgetButtonViewState extends State<HomeWidgetButtonView> {
  final globalKey = GlobalKey();

  String? imagePath;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final path = await HomeWidget.renderFlutterWidget(
          ImageView(globalKey),
          key: 'filename',
          pixelRatio: 0.5,
        );

        setState(() {
          imagePath = path as String?;
        });

        HomeWidget.saveWidgetData<String>('title', 'Flutter');
        HomeWidget.saveWidgetData<String>('description', 'Development');
        HomeWidget.saveWidgetData<String>('filename', imagePath);
        HomeWidget.updateWidget(iOSName: Constants.iOSWidgetName);
      },
      child: const Text('Update Home Widget'),
    );
  }
}

class ImageView extends StatelessWidget {
  final GlobalKey globalKey;

  const ImageView(this.globalKey, {super.key});

  @override
  Widget build(BuildContext context) {
    return const FlutterLogo(size: 100);
  }
}
