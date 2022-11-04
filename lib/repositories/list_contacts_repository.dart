import 'dart:convert';
import 'dart:io';

import 'package:pixbit_test/helpers/shared_preferences.dart';

import '../helpers/api_endpoints.dart';
import 'package:http/http.dart' as http;

class ContactsRepository {
  getAllContacts({page}) async {
    
    var bearer = await Preferences().getToken();
    print("my hearders $bearer");
    var headers = {HttpHeaders.authorizationHeader: "Bearer $bearer"};

    var url = "${ApiEndPoints.baseUrl}${ApiEndPoints.employees}?page=${page}";

    var data = await http.get(Uri.parse(url), headers: headers);

    var response = await jsonDecode(data.body);
    print("hh${response}");
    return response;
  }
}
