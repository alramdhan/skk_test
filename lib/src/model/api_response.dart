class ApiResponse {
  final int code;
  final String message;
  final Map<String, dynamic> data;
  Object? apiError;

  ApiResponse(this.code, this.message, this.data, this.apiError);

  int get getCode => code;
  set setCode(int code) => code = code;

  String get getMessage => message;
  set setMessage(String message) => message = message;

  Map<String, dynamic> get getData => data;
  set setData(Map<String, dynamic> data) => data = data;

  Object get ApiError => apiError!;
  set ApiError(Object apiError) => apiError = apiError;

  ApiResponse.fromJson(Map<String, dynamic> json)
    : code = json["code"],
      message = json["message"],
      data = json["data"],
      apiError = json["error"];
}

class ApiError {
  late String _error;

  ApiError({String? error}) {
    this._error = error!;
  }

  String get error => _error;
  set error(String error) => _error = error;

  ApiError.fromJson(Map<String, dynamic> json) {
    _error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this._error;
    return data;
  }
}