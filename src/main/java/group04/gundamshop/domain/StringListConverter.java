package group04.gundamshop.domain;

import jakarta.persistence.AttributeConverter;
import jakarta.persistence.Converter;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Converter to persist List<String> as a single String in the database and vice versa.
 * Uses comma as separator. Commas in strings are escaped as \\,
 */
@Converter
public class StringListConverter implements AttributeConverter<List<String>, String> {

    private static final String SPLIT_CHAR = ",";
    private static final String ESCAPE_CHAR = "\\\\";

    @Override
    public String convertToDatabaseColumn(List<String> attribute) {
        if (attribute == null || attribute.isEmpty()) {
            return "";
        }
        return attribute.stream()
                .map(this::escapeCommas)
                .collect(Collectors.joining(SPLIT_CHAR));
    }

    @Override
    public List<String> convertToEntityAttribute(String dbData) {
        if (dbData == null || dbData.isEmpty()) {
            return Collections.emptyList();
        }
        // Split by comma not preceded by escape
        // For simplicity, split by comma and then unescape
        String[] items = dbData.split("(?<!\\\\),");
        return Arrays.stream(items)
                .map(this::unescapeCommas)
                .collect(Collectors.toList());
    }

    private String escapeCommas(String input) {
        if (input == null) {
            return "";
        }
        return input.replace(",", ESCAPE_CHAR + ",");
    }

    private String unescapeCommas(String input) {
        if (input == null) {
            return "";
        }
        return input.replace(ESCAPE_CHAR + ",", ",");
    }
}
