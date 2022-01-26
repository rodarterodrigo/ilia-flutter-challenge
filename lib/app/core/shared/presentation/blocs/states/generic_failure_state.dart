import 'package:imdb_trending/app/core/shared/domain/failures/generic_failure.dart';
import 'package:imdb_trending/app/core/shared/presentation/blocs/states/general_states.dart';

class GenericFailureState extends GeneralStates{
  final GenericFailure failure;

  GenericFailureState(this.failure);
}