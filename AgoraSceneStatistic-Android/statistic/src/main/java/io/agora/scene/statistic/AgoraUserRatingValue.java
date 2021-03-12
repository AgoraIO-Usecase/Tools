package io.agora.scene.statistic;

/**
 * Description:
 *
 * @author xcz
 * @since 3/12/21
 */
public final class AgoraUserRatingValue {
    final float call_quality;
    final float function_completeness;
    final float general_experience;

    public AgoraUserRatingValue(float call_quality, float function_completeness, float general_experience) {
        this.call_quality = call_quality;
        this.function_completeness = function_completeness;
        this.general_experience = general_experience;
    }
}
