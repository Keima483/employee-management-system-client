import 'dart:convert';

import 'package:employee_management_client/utils/endpoints.dart' as endpoints;
import 'package:http/http.dart' as http;

Future<bool> isEmailAvailable(String email) async {
  var response = await http.get(
    Uri.parse(
      '${endpoints.userNameTaken}?username=$email',
    ),
  );
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  }
  return false;
}
