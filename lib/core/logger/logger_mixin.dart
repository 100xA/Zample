import 'package:logging/logging.dart';

mixin ZampleLogger {
  Logger get log => Logger('$runtimeType');
}
