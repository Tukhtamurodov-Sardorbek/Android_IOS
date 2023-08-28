package com.example.call_platform_specific_code

import android.widget.Toast
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val toastChannelName = "toast-channel";
    private val messageChannelName = "message-channel";

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            toastChannelName,
        ).setMethodCallHandler { call, result ->
            val args = call.arguments as Map<String, String>;
            val message = args["message"];

            if (call.method == "showToast") {
                Toast.makeText(this, message, Toast.LENGTH_LONG).show();
            }
        }


        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            messageChannelName,
        ).setMethodCallHandler { call, result ->
            if (call.method == "getMessageFromNativeCode") {
                val message = getMessage();
                if (message.isNotEmpty()) {
                    result.success(message);
                } else {
                    result.error("Unavailable", "Message from Kotlin code is empty", null);
                }
            } else {
                result.notImplemented();
            }
        }
    }

    private fun getMessage(): String {
        return "Message from Kotlin code";
    }
}
