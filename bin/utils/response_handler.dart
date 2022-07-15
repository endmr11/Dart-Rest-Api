mixin ResponseHandler {
  Map<String, dynamic> generateOkResMap(String path, String message, dynamic data, bool success) {
    if (success) {
      final responseMap = {
        'status': 200,
        'message': message,
        'path': path,
        'model': data,
      };
      return responseMap;
    } else {
      final responseMap = {
        'status': 400,
        'message': message,
        'path': path,
        'model': data,
      };
      return responseMap;
    }
  }

  Map<String, dynamic> generateJwtExpired(dynamic data) {
    final responseMap = {
      'status': 401,
      'message': 'Token Error!',
      'model': data,
    };

    return responseMap;
  }
}
