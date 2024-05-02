class StringUtils {
  static String toCapitalized(String str) =>
      str[0].toUpperCase() + str.substring(1).toLowerCase();

  static String toTitleCase(String str) =>
      str.split(" ").map((str) => toCapitalized(str)).join(" ");
}
