package com.example.bridge

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example/native"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->
            if (call.method == "getNativeData") {
                if (!call.hasArgument("num")) {
                    result.error("MissingArgumentError", "You must provide num parameter", null)
                }
                val num: Int = call.argument<Int>("num")!!
                val data = getNativeData(num)
                result.success(data)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun getNativeData(num: Int): String {
        // Implement your native code logic here
        return "From Native: $num"
    }
}