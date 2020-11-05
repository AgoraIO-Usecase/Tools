package io.agora.log;

import android.text.TextUtils;

import com.elvishew.xlog.LogLevel;
import com.elvishew.xlog.flattener.Flattener2;

import java.text.SimpleDateFormat;

public class AgoraFlattener implements Flattener2 {

    private SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss:SSS");

    @Override
    public CharSequence flatten(long timeMillis, int logLevel, String tagInLine, String message) {
        StringBuilder stringBuilder = new StringBuilder();
        stringBuilder = stringBuilder.append(simpleDateFormat.format(timeMillis)).append("|")
                .append(LogLevel.getLevelName(logLevel)).append("|");
        /**有行内tag就打印*/
        if (!TextUtils.isEmpty(tagInLine)) {
            stringBuilder = stringBuilder.append(tagInLine).append("|");
        }
        return stringBuilder.append(message).toString();
    }
}
