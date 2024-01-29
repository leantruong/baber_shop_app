class StringHelper {
  static bool isNullOrEmpty(String? str) {
    return str == null || str.isEmpty;
  }

  static String capitalize(String str) {
    if (str.isEmpty) return str;
    return str[0].toUpperCase() + str.substring(1);
  }
}
