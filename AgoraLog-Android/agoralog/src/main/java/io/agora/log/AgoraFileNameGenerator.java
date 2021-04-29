package io.agora.log;

import com.elvishew.xlog.printer.file.naming.FileNameGenerator;

import java.text.SimpleDateFormat;

/**
 * @author cjw
 */
public class AgoraFileNameGenerator implements FileNameGenerator {

    private StringBuilder fileName = new StringBuilder();
    private SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMddHHmmss");

    public AgoraFileNameGenerator(String filePrefix) {
        fileName = fileName.append(filePrefix).append("_");
    }

    @Override
    public boolean isFileNameChangeable() {
        return false;
    }

    @Override
    public String generateFileName(int logLevel, long timestamp) {
        return fileName.append(simpleDateFormat.format(timestamp)).append(".log").toString();
    }
}
