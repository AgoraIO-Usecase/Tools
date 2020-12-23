package io.agora.log;

import android.text.TextUtils;

import androidx.annotation.NonNull;

import com.elvishew.xlog.Logger;
import com.elvishew.xlog.XLog;
import com.elvishew.xlog.printer.file.FilePrinter;

import static com.elvishew.xlog.LogLevel.ALL;

/**
 * @author cjw
 */
public class AgoraLogManager {
    private Logger logger;
    private CheckUtil checkUtil = new CheckUtil();

    public AgoraLogManager(@NonNull String folderPath, @NonNull String filePrefix,
                           int maximumNumberOfFiles) throws Exception {
        this(folderPath, filePrefix, maximumNumberOfFiles, null);
    }

    public AgoraLogManager(@NonNull String folderPath, @NonNull String filePrefix,
                           int maximumNumberOfFiles, @NonNull String tag) throws Exception {
        this(folderPath, filePrefix, maximumNumberOfFiles, tag, AgoraConsolePrintType.NONE);
    }

    public AgoraLogManager(@NonNull String folderPath, @NonNull String filePrefix,
                           int maximumNumberOfFiles, String tag,
                           int consolePrintType) throws Exception {
        if (TextUtils.isEmpty(folderPath) || TextUtils.isEmpty(filePrefix) || maximumNumberOfFiles <= 0) {
            throw new Exception("Parameter is invalid");
        }

        try {
            checkUtil.checkFolder(folderPath, filePrefix, maximumNumberOfFiles);
        } catch (Exception e) {
            e.printStackTrace();
        }

        XLog.init();
        logger = XLog.tag(tag)
                .logLevel(ALL)
                .printers(
                        new AgoraAndroidLogPrinter(consolePrintType),
                        new FilePrinter.Builder(folderPath)
                                .fileNameGenerator(new AgoraFileNameGenerator(filePrefix))
                                .flattener(new AgoraFlattener())
                                .build())
                .build();
    }

    public void logMsg(String msg, AgoraLogType type) {
        switch (type) {
            case DEBUG:
                d(msg);
                break;
            case WARNING:
                w(msg);
                break;
            case ERROR:
                e(msg);
                break;
            case INFO:
            default:
                i(msg);
                break;
        }
    }

    public void i(String msg, Object... args) {
        msg = checkUtil.check(msg, args);
        logger.i(msg, args);
    }

    public void d(String msg, Object... args) {
        msg = checkUtil.check(msg, args);
        logger.d(msg, args);
    }

    public void w(String msg, Object... args) {
        msg = checkUtil.check(msg, args);
        logger.w(msg, args);
    }

    public void e(String msg, Object... args) {
        msg = checkUtil.check(msg, args);
        logger.e(msg, args);
    }
}
