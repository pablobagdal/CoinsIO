import 'package:coinio_app/core/utils/failures/failure.dart';

class RepositoryFailure extends Failure {
  RepositoryFailure({required final message})
    : super(message: 'Repository error: $message');
}
