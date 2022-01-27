import 'package:imdb_trending/app/core/shared/domain/failures/not_found_failure.dart';
import 'package:imdb_trending/app/core/shared/presentation/blocs/states/general_states.dart';

class NotFoundFailureState implements GeneralStates {
  final NotFoundFailure failure;

  const NotFoundFailureState(this.failure);
}
