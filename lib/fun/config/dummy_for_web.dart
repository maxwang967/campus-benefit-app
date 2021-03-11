import 'package:dio/dio.dart';

class PersistCookieJar{
  final dir;
  PersistCookieJar({this.dir});
}

class CookieManager extends Interceptor{
  final data;
  CookieManager(this.data);
}

class TemporaryDirectory {
  String path;
}