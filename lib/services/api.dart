import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';

class ApiConnect extends GetConnect {
  final timers = <String, RestartableTimer>{};

  ApiConnect() {
    baseUrl = 'https://payments.agribank.co.zw/api';

    var timeout = const Duration(seconds: 60);

    httpClient.timeout = timeout;
    httpClient.addResponseModifier((request, response) async {
      timers[request.url.toString()]!.cancel();
      debugPrint(
        '[Http] Response(${response.isOk}) - ${response.statusCode} ${response.statusText} / ${request.method} ${request.url}\n'
        '[Http] Timer Cancel ${request.url}',
      );

      request.headers['Content-Type'] = 'application/json; charset=UTF-8';
      if (response.statusCode == 401) {
        print(response);
      } else {
        throw Exception('no connection made');
      }
      return response;
    });

    httpClient.addRequestModifier((Request request) {
      timers[request.url.toString()] = RestartableTimer(
        timeout,
        () {
          debugPrint(
            '[Http] Timer Elapsed ${request.url}\n'
            '[Http] Internet maybe slow, please check your connection',
          );

          timers[request.url.toString()]?.cancel();
        },
      );

      debugPrint(
        '[Http] Request - ${request.method} ${request.url}\n'
        '[Http] Timer Start ${request.url}',
      );

      return request;
    });
  }
}
