package io.agora.scene.statistic.http;

import io.agora.scene.statistic.AgoraUserRatingValue;

/**
 * Description:
 *
 * @author xcz
 * @since 3/12/21
 */
public final class ReportReq {
    public String src;
    public long ts;
    public String sign;
    public Evaluation evaluation;

    public static final class Evaluation{
        public String os;
        public String device;
        public String app;
        public String user_case;
        public String user_id;
        public String session_id;
        public long time;
        public String comment;
        public AgoraUserRatingValue rating;

    }
}
