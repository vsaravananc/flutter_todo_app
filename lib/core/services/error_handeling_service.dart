enum ErrorType { formateException, typeErrorException , dataEmptyException }

class ErrorHandelingService {
  final ErrorType errorType;
  final String message;

  ErrorHandelingService({required this.message, required this.errorType});
}



///
///
/// FILE_PURPOSE: ERROR HANDLING SERVICE
/// 
///