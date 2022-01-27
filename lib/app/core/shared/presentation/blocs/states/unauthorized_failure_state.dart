import 'package:imdb_trending/app/core/shared/domain/failures/unauthorized_failure.dart';
import 'package:imdb_trending/app/core/shared/presentation/blocs/states/general_states.dart';

class UnauthorizedFailureState implements GeneralStates {
  final UnauthorizedFailure failure;

  const UnauthorizedFailureState(this.failure);
}
