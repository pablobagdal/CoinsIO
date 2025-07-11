// data/datasources/remote/account_remote_data_source.dart
import 'package:coinio_app/core/network/api_client.dart';
import 'package:coinio_app/data/models/account_model.dart';
import 'package:dio/dio.dart';

class AccountRemoteDataSource {
  final ApiClient apiClient;

  AccountRemoteDataSource({required this.apiClient});

  Future<List<AccountResponse>> getAccounts() async {
    try {
      final response = await apiClient.dio.get('/accounts');
      return (response.data as List)
          .map((json) => AccountResponse.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<AccountResponse> createAccount(AccountCreateRequest request) async {
    try {
      final response = await apiClient.dio.post(
        '/accounts',
        data: request.toJson(),
      );
      return AccountResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<void> deleteAccount(int id) async {
    try {
      await apiClient.dio.delete('/accounts/$id');
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  // Обработка ошибок Dio
  Exception _handleDioError(DioException e) {
    if (e.response != null) {
      return Exception(
        'Server error: ${e.response?.statusCode} - ${e.response?.statusMessage}',
      );
    } else {
      return Exception('Network error: ${e.message}');
    }
  }
}
