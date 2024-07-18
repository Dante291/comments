class EmailMaskingUtil {
  static String maskEmail(String email) {
    final indexOfAt = email.indexOf('@');
    if (indexOfAt <= 3) {
      return '${email.substring(0, 1)}**${email.substring(indexOfAt)}';
    }
    final namePart = email.substring(0, 3);
    final domainPart = email.substring(indexOfAt);
    return '$namePart****$domainPart';
  }
}
