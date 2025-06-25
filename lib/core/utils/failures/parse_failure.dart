import 'package:coinio_app/core/utils/failures/failure.dart';

class ParseFailure extends Failure {
  const ParseFailure({required final message})
    : super(message: 'Parse error: $message');
}
