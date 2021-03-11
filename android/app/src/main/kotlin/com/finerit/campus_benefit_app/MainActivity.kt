package com.finerit.campus_benefit_app

import android.os.Bundle
import com.tencent.bugly.Bugly
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    Bugly.init(applicationContext, "b4466397a1", false)
  }
}
