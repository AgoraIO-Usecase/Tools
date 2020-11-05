package io.agora.logmodule

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import io.agora.log.AgoraConsolePrintType.*
import io.agora.log.AgoraLogType
import io.agora.log.LogManager
import java.lang.Exception

class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val logManager0 = LogManager("/sdcard/0/5/6/", "AgoraLog", 2, "AgoraEducationSDK", NONE)
        val logManager1 = LogManager("/sdcard/1/", "AgoraLog", 2, "AgoraEducationSDK", WARNING)
        val logManager2 = LogManager("/sdcard/2/", "AgoraLog", 2, "AgoraEducationSDK", ALL)

        for (i in 0..9) {
            logManager0.logMsg("log-0---$i", AgoraLogType.INFO)
            logManager1.logMsg("log-1---$i", AgoraLogType.WARNING)
            logManager2.logMsg("log-2---$i", AgoraLogType.ERROR)
        }

        try {

        } catch (ex: Exception) {

        }
    }
}