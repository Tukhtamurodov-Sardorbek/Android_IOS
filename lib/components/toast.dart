import 'package:call_platform_specific_code/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NativeToast extends StatelessWidget {
  const NativeToast({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        const MethodChannel(Constants.toastChannelName).invokeMethod(
          Constants.showToastMethodName,
          {
            Constants.showToastMethodArgument: 'Show this message in native Toast',
          },
        );
      },
      child: const Text('Show native toast'),
    );
  }
}
