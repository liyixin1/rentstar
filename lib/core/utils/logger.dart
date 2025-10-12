import 'package:logger/logger.dart';

class Log{
  static Log? _instance;

  Log._internal();

  static Log instance(){
    _instance ??= Log._internal();
    return _instance!;
  }
  Logger _logger = Logger(
    printer: PrefixPrinter(PrettyPrinter())
  );

  void t(dynamic message){
    _logger.t(message);
  }
  void d(dynamic message){
    _logger.d(message);
  }
  void i(dynamic message){
    _logger.i(message);
  }
  void w(dynamic message){
    _logger.w(message);
  }
  void e(dynamic message){
    _logger.e(message);
  }
  void f(dynamic message){
    _logger.f(message);
  }
}