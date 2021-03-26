package io.agora.scene.statistic;

import android.text.TextUtils;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import java.util.Locale;

import io.agora.scene.statistic.http.ReportReq;
import io.agora.scene.statistic.http.StatisticService;
import io.agora.scene.statistic.utils.CryptoUtil;
import okhttp3.OkHttpClient;
import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;
import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;

/**
 * Description:
 *
 * @author xcz
 * @since 3/12/21
 */
public final class AgoraSceneStatistic {
    private final static String DEFAULT_SERVER_URL = "https://evaluation.bj2.agoralab.co";
    private final StatisticService statisticService;
    private AgoraSceneStatisticContext mContext;

    public AgoraSceneStatistic() {
        this(null);
    }

    public AgoraSceneStatistic(OkHttpClient client) {
        if (client == null) {
            client = new OkHttpClient.Builder()
                    .build();
        }
        statisticService = new Retrofit.Builder()
                .client(client)
                .baseUrl(DEFAULT_SERVER_URL)
                .addConverterFactory(GsonConverterFactory.create())
                .build()
                .create(StatisticService.class);
    }

    public AgoraSceneStatistic setContent(AgoraSceneStatisticContext context) {
        mContext = context;
        return this;
    }

    /**
     * 评分
     *
     * @param rate    评分
     * @param comment 评论
     * @param success 成功回调
     * @param failed  错误回调
     */
    public void userRating(@NonNull AgoraUserRatingValue rate,
                           @Nullable String comment,
                           @Nullable Runnable success,
                           @Nullable ErrorCallback failed) {

        final String _comment = TextUtils.isEmpty(comment) ? "" : comment;
        final long currentTs = System.currentTimeMillis();
        ReportReq body = new ReportReq();
        body.src = mContext.app;
        body.ts = currentTs;
        body.sign = CryptoUtil.md5(String.format(Locale.US, "src=%s&ts=%d", mContext.app, currentTs));
        body.evaluation = new ReportReq.Evaluation();
        body.evaluation.os = mContext.os;
        body.evaluation.device = mContext.device;
        body.evaluation.app = mContext.app;
        body.evaluation.user_id = mContext.userId;
        body.evaluation.user_case = mContext.userCase;
        body.evaluation.session_id = mContext.sessionId;
        body.evaluation.time = currentTs;
        body.evaluation.rating = rate;
        body.evaluation.comment = _comment;
        statisticService.report(body).enqueue(new Callback<Void>() {
            @Override
            public void onResponse(Call<Void> call, Response<Void> response) {
                if (success != null) {
                    success.run();
                }
            }

            @Override
            public void onFailure(Call<Void> call, Throwable t) {
                if (failed != null) {
                    failed.onError(t);
                }
            }
        });
    }

    public interface ErrorCallback {
        void onError(Throwable erro);
    }
}
