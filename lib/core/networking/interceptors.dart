import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

/// This interceptor is used to show request and response logs
class LoggerInterceptor extends Interceptor {
  Logger logger = Logger(
    printer: PrettyPrinter(methodCount: 0, colors: true, printEmojis: true),
  );

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final options = err.requestOptions;
    final requestPath = '${options.baseUrl}${options.path}';

    logger.e('${options.method} request ==> $requestPath'); //Error log
    logger.d(
      'Error type: ${err.type} \n '
      'Error response: ${err.response} \n '
      'Error message: ${err.message}',
    ); //Debug log
    handler.next(err); //Continue with the Error

    if (err.type == DioExceptionType.connectionError) {
      // Navigator.of(
      //   navigatorKey.currentContext!,
      // ).pushReplacementNamed(lostInthernetSc);
    }
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final requestPath = '${options.baseUrl}${options.path}';
    logger.i(
      '--------------------------------\n'
      '${options.method} request ==> $requestPath\n'
      '--------------------------------'
      '${options.data != null ? '\n REQUEST Data: ${options.data is FormData ? options.data?.fields : jsonEncode(options.data ?? {})}  ' : ''}'
      // '${options.headers.isEmpty ? '' : 'REQUEST Headers: ${options.headers}  \n'}' //headers
      '${options.queryParameters.isEmpty ? '' : ' \n REQUEST QueryParametr: ${options.queryParameters} '}',
    );
    handler.next(options); // continue with the Request
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.d(
      'STATUSCODE: ${response.statusCode} \n '
      'STATUSMESSAGE: ${response.statusMessage} \n'
      'HEADERS: ${response.headers} \n'
      'Data: ${jsonEncode(response.data ?? {})}',
    );
    handler.next(response);
  }
}
