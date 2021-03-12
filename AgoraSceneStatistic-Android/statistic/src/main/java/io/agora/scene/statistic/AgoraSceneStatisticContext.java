package io.agora.scene.statistic;

import android.content.Context;
import android.os.Build;

import io.agora.scene.statistic.utils.AppUtil;

/**
 * Description:
 *
 * @author xcz
 * @since 3/12/21
 */
public final class AgoraSceneStatisticContext {

    public String os = "android";
    public String device = Build.DEVICE;
    public String app;
    public String userCase;
    public String userId;
    public String sessionId;

    /**
     * @param context   上下文
     * @param userId    用户id
     * @param userCase  场景（例如 ent, ent, edu, meeting）
     * @param sessionId 使用 rte 的 sceneId
     */
    public AgoraSceneStatisticContext(Context context,
                                      String userId,
                                      String userCase,
                                      String sessionId) {
        this.app = AppUtil.getAppName(context);
        this.userId = userId;
        this.userCase = userCase;
        this.sessionId = sessionId;
    }
}
