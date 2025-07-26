import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as pth;
import '../view_model/splash_view_model.dart';

typedef ResSuccess = Future<void> Function(Map<String, dynamic>);
typedef ResFailure = Future<void> Function(dynamic);

class ServiceCall {
 

static void post(Map<String, dynamic> parameter, String path,
    {bool isToken = false, Map<String, String>? headers, ResSuccess? withSuccess, ResFailure? failure}) {
    Future(() {
      try {
        var defaultHeaders = {'Content-Type': 'application/x-www-form-urlencoded'};
        if (isToken) {
          var token = Get.find<SplashViewModel>().userPayload.value.authToken;
          defaultHeaders["access_token"] = token ?? "";
        }
        if (headers != null) {
          defaultHeaders.addAll(headers);
        }
        if (kDebugMode) {
          print('ServiceCall.post URL: $path');
          print('ServiceCall.post Headers: $defaultHeaders');
          print('ServiceCall.post Body: $parameter');
        }
        http
            .post(Uri.parse(path), body: parameter, headers: defaultHeaders)
            .then((value) {
          if (kDebugMode) {
            print('ServiceCall.post Response status: ${value.statusCode}');
            print('ServiceCall.post Response body: ${value.body}');
          }
          try {
            var jsonObj =
                json.decode(value.body) as Map<String, dynamic>? ?? {};
            if (withSuccess != null) withSuccess(jsonObj);
          } catch (err) {
            if (failure != null) failure(err.toString());
          }
        }).catchError((e) {
          if (failure != null) failure(e.toString());
        });
      } catch (err) {
        if (failure != null) failure(err.toString());
      }
    });
  }

  static void multipart(Map<String, String> parameter, String path,
      {bool isToken = false, Map<String, File>? imgObj, ResSuccess? withSuccess, ResFailure? failure}) {
    Future(() {
      try {

        var uri = Uri.parse(path);
        var request = http.MultipartRequest('POST', uri);
        request.fields.addAll(parameter);


        if (isToken) {
          var token = Get.find<SplashViewModel>().userPayload.value.authToken;
          request.headers.addAll({"access_token": token ?? ""});
        }

        if(kDebugMode) {
          print("ServiceCall: $path");
          print("ServiceCall para: ${ parameter.toString() }");
          print("ServiceCall header: ${request.headers.toString()}");
        }

        if(imgObj != null) {
          imgObj.forEach((key, value) {
              var multipartFile = http.MultipartFile(key, value.readAsBytes().asStream(), value.lengthSync(), filename: pth.basename(value.path) );
              request.files.add(multipartFile);
          });
        }

        request.send().then((response) async {

          var value = await response.stream.transform(utf8.decoder).join();

          if (kDebugMode) {
            print(value);
          }
          try {
            var jsonObj =
                json.decode(value) as Map<String, dynamic>? ?? {};

            if (withSuccess != null) withSuccess(jsonObj);
          } catch (err) {
            if (failure != null) failure(err.toString());
          }

        }).catchError((e) {
          if (failure != null) failure(e.toString());
        });
       
      } catch (err) {
        if (failure != null) failure(err.toString());
      }
    });
  }

  static void multipartNew(Map<String, String> parameter, String path,
      {bool isToken = false,
      Map<File, String>? imgObj,
      ResSuccess? withSuccess,
      ResFailure? failure}) {
    Future(() {
      try {
        var uri = Uri.parse(path);
        var request = http.MultipartRequest('POST', uri);
        request.fields.addAll(parameter);

        if (isToken) {
          var token = Get.find<SplashViewModel>().userPayload.value.authToken;
          request.headers.addAll({"access_token": token ?? ""});
        }

        if (kDebugMode) {
          print("ServiceCall: $path");
          print("ServiceCall para: ${parameter.toString()}");
          print("ServiceCall header: ${request.headers.toString()}");
        }

        if (imgObj != null) {
          imgObj.forEach((key, value) {
            var multipartFile = http.MultipartFile(
                value, key.readAsBytes().asStream(), key.lengthSync(),
                filename: pth.basename(key.path));
            request.files.add(multipartFile);
          });
        }

        request.send().then((response) async {
          var value = await response.stream.transform(utf8.decoder).join();

          if (kDebugMode) {
            print(value);
          }
          try {
            var jsonObj = json.decode(value) as Map<String, dynamic>? ?? {};

            if (withSuccess != null) withSuccess(jsonObj);
          } catch (err) {
            if (failure != null) failure(err.toString());
          }
        }).catchError((e) {
          if (failure != null) failure(e.toString());
        });
      } catch (err) {
        if (failure != null) failure(err.toString());
      }
    });
  }
}
