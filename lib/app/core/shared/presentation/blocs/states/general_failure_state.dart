import 'package:tmdb_trending/app/core/shared/domain/failures/general_failure.dart';
import 'package:tmdb_trending/app/core/shared/presentation/blocs/states/general_states.dart';

class GeneralFailureState implements GeneralStates {
  final GeneralFailure failure;

  const GeneralFailureState(this.failure);
}
