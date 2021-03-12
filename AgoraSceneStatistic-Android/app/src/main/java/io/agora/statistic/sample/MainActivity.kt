package io.agora.statistic.sample

import android.os.Bundle
import android.util.Log
import androidx.appcompat.app.AppCompatActivity
import io.agora.scene.statistic.AgoraSceneStatistic
import io.agora.scene.statistic.AgoraSceneStatisticContext
import io.agora.scene.statistic.AgoraUserRatingValue
import okhttp3.OkHttpClient
import okhttp3.logging.HttpLoggingInterceptor




class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val interceptor = HttpLoggingInterceptor()
        interceptor.setLevel(HttpLoggingInterceptor.Level.BODY);
        val okHttpClient = OkHttpClient.Builder().addInterceptor(interceptor).build()

        AgoraSceneStatistic(okHttpClient)
                .setContent(AgoraSceneStatisticContext(this, "1234", "meeting", "112233"))
                .userRating(
                        AgoraUserRatingValue(1.0f, 1.0f, 1.0f),
                        "",
                        { Log.d("AgoraSceneStatistic", "success") },
                        { error -> Log.d("AgoraSceneStatistic", "error: $error") })

    }
}
