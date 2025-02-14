part of 'actions_bloc.dart';

@immutable
sealed class ActionsEvent {}
// add save event
final class OnSave extends ActionsEvent {
  final Map<String , dynamic > data ;
  OnSave({required this.data });
}

final class OnLoad extends ActionsEvent {
  final Map<String , dynamic > data ;
  OnLoad({required this.data });
}
