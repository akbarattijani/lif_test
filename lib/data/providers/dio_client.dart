import 'package:dio/dio.dart';

class DioClient {
    final Dio _dio = Dio(
        BaseOptions(
            baseUrl: 'https://reqres.in/api',
            connectTimeout: const Duration(seconds: 5),
            receiveTimeout: const Duration(seconds: 3),
        ),
    );

    Dio get dio => _dio;

    Future<Response> fetchSampleData() async {
        try {
            return await _dio.get('/users');
        } catch (e) {
            rethrow;
        }
    }
}