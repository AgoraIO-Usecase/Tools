package io.agora.scene.statistic.http;

import retrofit2.Call;
import retrofit2.http.Body;
import retrofit2.http.POST;

/**
 * Description:
 *
 * @author xcz
 * @since 3/12/21
 */
public interface StatisticService {

    @POST("/v1/evaluation/report")
    Call<Void> report(
            @Body ReportReq body
    );
}
