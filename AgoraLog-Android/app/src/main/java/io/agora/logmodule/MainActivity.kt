package io.agora.logmodule

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import io.agora.log.AgoraConsolePrintType.*
import io.agora.log.AgoraLogType
import io.agora.log.AgoraLogManager
import java.lang.Exception

class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

//        val logManager0 = AgoraLogManager(
//            "/sdcard/0/5/6/",
//            "AgoraLog",
//            2,
//            "AgoraEducationSDK",
//            NONE
//        )
        val logManager1 = AgoraLogManager(
            "/sdcard/0/5/7/",
            "AgoraLog",
            2,
            "AgoraEducationSDK",
            ERROR
        )
//        val logManager2 = AgoraLogManager(
//            "/sdcard/1/",
//            "AgoraLog",
//            2,
//            "AgoraEducationSDK",
//            WARNING
//        )
//        val logManager1 = AgoraLogManager(
//            "/sdcard/2/",
//            "Agora.log_",
//            2,
//            "AgoraEducationSDK",
//            ALL
//        )

        for (i in 0..9) {
            logManager1.logMsg("log-1---$i", AgoraLogType.DEBUG)
            logManager1.logMsg("log-1---$i", AgoraLogType.INFO)
            logManager1.logMsg("log-1---$i", AgoraLogType.WARNING)
            logManager1.logMsg("log-1---$i", AgoraLogType.ERROR)
        }

        try {

        } catch (ex: Exception) {

        }
    }
}
