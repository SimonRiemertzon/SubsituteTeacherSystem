package se.yrgo.schedule;

/**
 * A factory to get a formatter (only HTML is implemented)
 */
public class FormatterFactory {

    private static Formatter XML_FORMATTER;
    private static Formatter JSON_FORMATTER = new JsonFormatter();

    /**
     * Returns a formatter for the given contentType
     *
     * @param contentType The content type you want to format to (HTML is the only implemented)
     * @return Formatter A Formatter of the correct type, depending on the provided contentType. Defaults to HTML.
     * Cannot handle null.
     */
    public static Formatter getFormatter(String contentType) {
        if (contentType.equalsIgnoreCase("xml")) {
            return XML_FORMATTER;
        } else if (contentType.equalsIgnoreCase("json")) {
            return JSON_FORMATTER;
        } else {
            throw new IllegalArgumentException(String.format("Format %s not supported", contentType));
        }
    }
}
