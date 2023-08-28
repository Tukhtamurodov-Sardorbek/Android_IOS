import 'package:call_platform_specific_code/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MessageButtonView extends StatelessWidget {
  const MessageButtonView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        String messageFromNativeCode;
        try {
          messageFromNativeCode =
              await const MethodChannel(Constants.messageChannelName)
                  .invokeMethod(
            Constants.getMessageMethodName,
          );
        } on PlatformException catch (e) {
          messageFromNativeCode = 'Failed to get message ${e.message}';
        }

        const MethodChannel(Constants.toastChannelName).invokeMethod(
          Constants.showToastMethodName,
          {
            Constants.showToastMethodArgument: messageFromNativeCode,
          },
        );
      },
      child: const Text('Get message from native code'),
    );
  }
}
