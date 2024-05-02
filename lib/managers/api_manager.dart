import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:async/async.dart';
import '../utilities/api_constants.dart';

class ApiManager {
  String baseurl = APIConstants.baseURL;
  String name = "";
  late Map<String, String> apiBody;
  late Map<String, String> apiHeader;

  late String? rawBody;

  ApiManager(
      this.name, this.apiBody, bool addToken, Map<String, String> header1,
      {this.rawBody}) {
    apiHeader = header1;

    // this.apiHeader[HttpHeaders.contentTypeHeader] = "application/json";
    apiHeader["Accept"] = "application/json";
    var username = "ck_a59aeae456ffc09d457c6bdb51abc1e129af9fd8";
    var password = "cs_9c8fa1ad41909bc494c85045d17f8e2b6aae3cb3";
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    apiHeader["Authorization"] = basicAuth;
  }

  Future<Map<String, dynamic>> callPostAPI(bool printResponse) async {
    final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());

    if (
    connectivityResult.contains(ConnectivityResult.wifi) ||
        connectivityResult.contains(ConnectivityResult.mobile
        )
    ) {
      // Internet is available
      String url123 = baseurl + name;
      print(url123);

      try {
        // final responseOfAPI = await http.post(url123,
        //     body: jsonEncode(apiBody), headers: apiHeader);
        final responseOfAPI = await http.post(Uri.parse(url123),
            body: rawBody ?? apiBody, headers: apiHeader);
        if (printResponse) log(responseOfAPI.body);
        Map<String, dynamic> fResponse = json.decode(responseOfAPI.body);
        return fResponse;
        //this.delegate.apiCallback(fResponse);

      } on TimeoutException catch (error) {
        print("TimeoutException:" + error.message!);
        //noInternet(context);
        Map<String, dynamic> fResponse = {};
        fResponse['status'] = "fail";
        fResponse['msg'] = "Please check your internet and try again";
        return fResponse;
      } catch (error) {
        print(error);
        rethrow;
      }
    } else {
      print('error');
      // Internet is not available
      Map<String, dynamic> fResponse = <String, dynamic>{};
      fResponse['status'] = "fail";
      fResponse['msg'] = "Please check your internet and try again";
      return fResponse;
    }
  }

  Future<Map<String, dynamic>> callGetAPI(bool printResponse) async {
    print('In call of Get');

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (
    connectivityResult.contains(ConnectivityResult.wifi) ||
        connectivityResult.contains(ConnectivityResult.mobile
        )
    ) {
      String url123 = baseurl + name;
      print(url123);
      try {
        final responseOfAPI = await http
            .get(Uri.parse(url123),
                //body: apiBody,
                headers: apiHeader)
            .timeout(const Duration(seconds: 30), onTimeout: () {
          throw TimeoutException(
              'The connection has timed out, Please try again!');
        });

        if (printResponse) print(responseOfAPI.body);
        Map<String, dynamic> fResponse = {};
        if (json.decode(responseOfAPI.body) is List) {
          fResponse = {'data': json.decode(responseOfAPI.body)};
        } else {
          fResponse = json.decode(responseOfAPI.body);
        }
        return fResponse;
        //this.delegate.apiCallback(fResponse);
      } on TimeoutException catch (error) {
        print("TimeoutException:" + error.message!);
        //noInternet(context);
        Map<String, dynamic> fResponse = {};
        fResponse['status'] = "fail";
        fResponse['msg'] = "Please check your internet and try again";
        return fResponse;
      } catch (error) {
        print(error);
        rethrow;
      }
    } else {
      print('error');
      Map<String, dynamic> fResponse = <String, dynamic>{};
      fResponse['status'] = "fail";
      fResponse['msg'] = "Please check your internet and try again";
      return fResponse;
    }
  }

  ///delete
  Future<Map<String, dynamic>> callDeleteAPI() async {
    print('In call of Delete');

    final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      String url123 = baseurl + name;

      print("*********  REQUEST  *********");
      print("Base URL: $url123");
      print("Request: $apiBody");
      print("Headers: $apiHeader");
      print("*********  REQUEST  *********");

      try {
        final responseOfAPI =
            await http.delete(Uri.parse(url123), headers: apiHeader);
        print(responseOfAPI.body);
        Map<String, dynamic> fResponse = json.decode(responseOfAPI.body);

        print("*********  RESPONSE  *********");
        print("Base URL: $url123");
        print("Response: $fResponse");
        print("*********  RESPONSE  *********");

        return fResponse;
      } on FormatException catch (error) {
        print("FormatException: " + error.message);
        rethrow;
      } on SocketException catch (error) {
        print("SocketException: " + error.message);
        rethrow;
      } on ArgumentError catch (error) {
        print("ArgumentError: " + error.message);
        rethrow;
      } catch (error) {
        print(error);
        rethrow;
      }
    } else {
      print('error');
      Map<String, dynamic> fResponse = <String, dynamic>{};
      fResponse['success'] = false;
      fResponse['msg'] = "Please check your internet and try again";
      return fResponse;
    }
  }

  //multipart
  Future<Map<String, dynamic>> callMultipartPostAPI(
      List<CustomMultipartObject> files) async {
    print('In call of Multipart');

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      String url123 = baseurl + name;
      Uri uri = Uri.parse(url123);

      var request = http.MultipartRequest("POST", uri);
      request.headers.addAll(apiHeader);
      // Map<String,String>accept;
      // accept["Accept"]="*/*";
      // request.headers.(accept);
      request.fields.addAll(apiBody);

      for (var file in files) {
        var stream = http.ByteStream(DelegatingStream(file.file.openRead()));
        // var length = await file.file.length();

        file.file.length().then((length) {
          var multipartFile = http.MultipartFile(file.param, stream, length,
              filename: basename(file.file.path));
          request.files.add(multipartFile);
          print("Name: " + multipartFile.field);
          print("Image: " + multipartFile.filename!);
          print("Files: " + request.files.length.toString());
        });
      }

      print("*********  REQUEST  *********");
      print("Base URL: $uri");
      print("Request: " + request.fields.toString());
      print("Headers: " + request.headers.toString());
      print("Files: " + request.files.length.toString());
      print("*********  REQUEST  *********");

      try {
        print("Requesting");
        var streamedResponse = await request.send();
        var response = await http.Response.fromStream(streamedResponse);
        print(streamedResponse);
        print("Code: " + response.statusCode.toString());
        print("Code: " + response.request.toString());

        const prefix = "ï»¿";
        var body = response.body;
        if (body.startsWith(prefix)) {
          body = body.substring(prefix.length);
        }

        print("Responses" + body);
        Map<String, dynamic> fResponse = json.decode(body);

        print("*********  RESPONSE  *********");
        print("Base URL: $uri");
        print("Response: $fResponse");
        print("*********  RESPONSE  *********");

        return fResponse;
      } on FormatException catch (error) {
        print("FormatException: " + error.message);
        rethrow;
      } on ArgumentError catch (error) {
        print("ArgumentError: " + error.message);
        rethrow;
      } catch (error) {
        print("ArgumentError: " + error.toString());
        rethrow;
      }
    } else {
      print('error');
      Map<String, dynamic> fResponse = <String, dynamic>{};
      fResponse['success'] = false;
      fResponse['msg'] = "Please check your internet and try again";
      return fResponse;
    }
  }

////For Google palce AutoComplete
  Future<Map<String, dynamic>> callGetAddressAPI() async {
    print('In call of Get');

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      String url123 = name;
      print(url123);
      try {
        final responseOfAPI = await http.get(Uri.parse(url123),
            //body: apiBody,
            headers: apiHeader);

        print(responseOfAPI.body);
        Map<String, dynamic> fResponse = json.decode(responseOfAPI.body);
        return fResponse;
        //this.delegate.apiCallback(fResponse);
      } catch (error) {
        print(error);
        rethrow;
      }
    } else {
      print('error');
      Map<String, dynamic> fResponse = <String, dynamic>{};
      fResponse['success'] = "fail";
      fResponse['msg'] = "Please check your internet and try again";
      return fResponse;
    }
  }
}

class CustomMultipartObject {
  final File file;
  final String param;

  CustomMultipartObject({required this.file, required this.param});
}
