class AppUtils {
  Map<String, dynamic> generateOkResMap(dynamic data) {
    final responseMap = {
      'status': 200,
      'message': 'success',
      'model': data,
    };

    return responseMap;
  }

  Map<String, dynamic> generateErrorResMap(dynamic data) {
    final responseMap = {
      'message': 'error',
      'model': data,
    };

    return responseMap;
  }
}
