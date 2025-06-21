class DataResponse<T> {
  ResponseStatus status;
  T? responseData;
  String? responseMessage;
  String? responseModelType;
  int? responseStatusCode;

  DataResponse.loading(String? message)
    : status = ResponseStatus.loading,
      responseMessage = message;

  DataResponse.success(T? data, {String? modelType})
    : status = ResponseStatus.success,
      responseData = data,
      responseModelType = modelType;

  DataResponse.error(String? message, [int? statusCode])
    : status = ResponseStatus.error,
      responseMessage = message,
      responseStatusCode = statusCode;

  DataResponse.connectivityError() : status = ResponseStatus.connectivityError;

  @override
  String toString() {
    return '''
Status: $status
Message: $responseMessage
Data: $responseData
Model Type: $responseModelType
Status Code: $responseStatusCode
''';
  }
}

enum ResponseStatus { loading, success, error, connectivityError }
