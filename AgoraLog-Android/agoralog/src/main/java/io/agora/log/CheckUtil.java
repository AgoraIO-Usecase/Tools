package io.agora.log;

import android.text.TextUtils;

import java.io.File;
import java.io.FilenameFilter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;

public class CheckUtil {

    public void checkFolder(String folderPath, String filePrefix, int max) throws Exception {
        File file = new File(folderPath);
        if (!file.exists()) {
            if (!file.mkdirs()) {
                throw new Exception("mkdir failed!");
            }
        } else {
            File[] files = file.listFiles(new FilenameFilter() {
                @Override
                public boolean accept(File dir, String name) {
                    if (new File(dir, name).isFile()) {
                        return name.startsWith(filePrefix);
                    }
                    return false;
                }
            });
            List<File> fileList = Arrays.asList(files);
            checkCount(new ArrayList(fileList), max);
        }
    }

    private void checkCount(List<File> files, int max) {
        if (files.size() > (max - 1)) {
            Iterator<File> iterator = files.iterator();
            File oldest = iterator.next();
            while (iterator.hasNext()) {
                File file = iterator.next();
                oldest = older(oldest, file);
            }
            files.remove(oldest);
            oldest.delete();
            checkCount(files, max);
        }
    }

    private File older(File first, File second) {
        try {
            long firstCreateTime = getCreateTime(first);
            long secondCreateTime = getCreateTime(second);
            return firstCreateTime > secondCreateTime ? second : first;
        } catch (ParseException e) {
            e.printStackTrace();
            return first;
        }
    }

    private SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMddHHmmss");

    private long getCreateTime(File file) throws ParseException {
        String fileName = file.getName();
        int start = fileName.lastIndexOf("_");
        int end = fileName.lastIndexOf(".log");
        if (start < end) {
            return -1;
        }
        String time = fileName.substring(start + 1, end);
        return isDigit(time) ? simpleDateFormat.parse(time).getTime() : -1;
    }


    private final String p0 = "%", p1 = "%%";

    public String check(String msg, Object... args) {
        if (args.length == 0 && msg.contains(p0)) {
            msg = msg.replaceAll(p0, p1);
        }
        return msg;
    }

    private boolean isDigit(String str) {
        if (TextUtils.isEmpty(str)) {
            return false;
        }
        for (int i = str.length(); --i >= 0; ) {
            int c = str.charAt(i);
            if (c < 48 || c > 57) {
                return false;
            }
        }
        return true;
    }
}
