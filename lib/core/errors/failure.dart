import 'package:dio/dio.dart';

class Failure
{
  String message;
  Failure({required this.message});
}
class ServerFailure extends Failure
{
  ServerFailure({required super.message});

  factory ServerFailure.serverError(DioException e){
    switch(e.type)
    {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(message: 'Connection Timeout');
      case DioExceptionType.sendTimeout:
       return ServerFailure(message: 'Send Timeout');
      case DioExceptionType.receiveTimeout:
        return ServerFailure(message: 'Receive Timeout');
      case DioExceptionType.badCertificate:
        return ServerFailure(message: 'Bad Certificate');
      case DioExceptionType.badResponse:
        return ServerFailure.fromCode(e.response?.statusCode, e.response?.data);
      case DioExceptionType.cancel:
        return ServerFailure(message: 'Cancel');
      case DioExceptionType.connectionError:
        return ServerFailure(message: 'Connection Error');
      case DioExceptionType.unknown:
        return ServerFailure(message: 'Unknown Error');
      default:
        return ServerFailure(message: 'Unknown Error');
    }
    }

    factory ServerFailure.fromCode(int ? code,dynamic response)
    {
      switch(code)
      {
        case 400:
        case 401:
          case 403:
          return ServerFailure(message: '${response['code']}');
        case 404:
          return ServerFailure(message: 'Not Found');
        case 409:
          return ServerFailure(message: 'Conflict');
        case 408:
          return ServerFailure(message: 'Request Timeout');
        case 500:
          return ServerFailure(message: 'Internal Server Error');
        default:
          return ServerFailure(message: 'Something went wrong');
      }
    }
}