class CompanyData {
  String name;
  String email;
  String ipAddress;
  String password;

  CompanyData({
    required this.name,
    required this.email,
    required this.ipAddress,
    required this.password,
  });

  Map<String, String> toJson() {
    return {
      'name': name,
      'email': email,
      'ipAddress': ipAddress,
      'password': password
    };
  }
}
