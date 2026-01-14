package cn.qihangerp.common.csv;

import org.apache.commons.csv.CSVFormat;
import org.apache.commons.csv.CSVParser;
import org.apache.commons.csv.CSVRecord;
import java.io.*;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class CSVReaderWithApacheCommons {

    /**
     * 读取CSV文件到List
     */
    public static List<List<String>> readCSVToList(File csvFile) throws IOException {
        List<List<String>> data = new ArrayList<>();

        try (Reader reader = new FileReader(csvFile);
             CSVParser parser = CSVFormat.DEFAULT.parse(reader)) {

            for (CSVRecord record : parser) {
                List<String> row = new ArrayList<>();
                for (String value : record) {
                    row.add(value);
                }
                data.add(row);
            }
        }

        return data;
    }

    /**
     * 读取CSV文件到List of Maps（第一行为表头）
     */
    public static List<LinkedHashMap<String, String>> readCSVToMap(File csvFile) throws IOException {
        List<LinkedHashMap<String, String>> data = new ArrayList<>();

        try (Reader reader = new FileReader(csvFile);
             CSVParser parser = CSVFormat.DEFAULT
                     .withFirstRecordAsHeader()  // 第一行作为表头
                     .withTrim()
                     .parse(reader)) {

            List<String> headers = parser.getHeaderNames();

            for (CSVRecord record : parser) {
                LinkedHashMap<String, String> row = new LinkedHashMap<>();
                for (String header : headers) {
                    row.put(header, record.get(header));
                }
                data.add(row);
            }
        }

        return data;
    }

    /**
     * 使用不同格式读取CSV
     */
    public static List<Map<String, String>> readCSVWithFormat(File csvFile) throws IOException {
        List<Map<String, String>> data = new ArrayList<>();

        try (Reader reader = new FileReader(csvFile);
             CSVParser parser = CSVFormat.newFormat(',')  // 指定分隔符
                     .withQuote('"')                     // 指定引号字符
                     .withEscape('\\')                   // 指定转义字符
                     .withIgnoreEmptyLines(true)         // 忽略空行
                     .withTrim()                         // 去除空格
                     .withFirstRecordAsHeader()          // 第一行作为表头
                     .withIgnoreHeaderCase()             // 忽略表头大小写
                     .parse(reader)) {

            List<String> headers = parser.getHeaderNames();

            for (CSVRecord record : parser) {
                Map<String, String> row = new LinkedHashMap<>();
                for (String header : headers) {
                    row.put(header, record.get(header));
                }
                data.add(row);
            }
        }

        return data;
    }
}