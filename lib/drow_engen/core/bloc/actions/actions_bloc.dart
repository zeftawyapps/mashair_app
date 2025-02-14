import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'actions_event.dart';
part 'actions_state.dart';

class ActionsBloc extends Bloc<ActionsEvent, ActionsState> {
  ActionsBloc() : super(ActionsInitial()) {
    on<ActionsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
