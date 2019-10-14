import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkAPI {

  final host = "https://www.google.com";
  Map<String, String> commonHeaders = {'Agent' : 'iPhone', 'App-Version' : '1.0.0'}; //common header proerties for all requests


  void httpGetRequest(
      String serviceUrl,
      Map<String, dynamic> headers,
      void completionHandler(
          bool status, List<Map<String, dynamic>> responseData)) async {

    var httpHeaders = this.commonHeaders;
    if (headers != null) {
      httpHeaders.addAll(headers);
    }

    try {
      final response = await http.get(this.host + serviceUrl, headers: httpHeaders);
      if (response.statusCode == 200) {
        final d = response.body;
        //print('WebServiceRequest - $serviceUrl \n Response - $d');
        completionHandler(true, json.decode(d));
      } else {
        completionHandler(false, null);
      }
    } catch (e) {
      completionHandler(false, null);
    }
  }

  void httpPostRequest(
      String serviceUrl,
      Map<String, dynamic> headers,
      Map<String, dynamic> postData,
      void completionHandler(
          bool status, Map<String, dynamic> responseData)) async {
    // var res = await http.get('https://www.google.com');
    // print(res.statusCode);
    var httpHeaders = this.commonHeaders;
    if (headers != null) {
      httpHeaders.addAll(headers);
    }

    try {
      final response = await http.post(this.host + serviceUrl,
          body: json.encode(postData), headers: httpHeaders);
      if (response.statusCode == 200) {
        final d = response.body;
        //print('WebServiceRequest - $serviceUrl \nResponse - $d');
        completionHandler(true, json.decode(d));
      } else {
        completionHandler(false, null);
      }
    } catch (e) {
      print('Exception - $e');
      completionHandler(false, null);
    }
  }
}
