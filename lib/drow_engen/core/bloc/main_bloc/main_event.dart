part of 'main_bloc.dart';

/*
// we have evnets
// 1- MainInitialevent
// 2- tool box itme click
// 3- leyer item click
// 4- layer itme property change
// */
@immutable
sealed class MainEvent {}

final class MainInitialEvent extends MainEvent {
  final Layout layout;
  MainInitialEvent({required this.layout});
}


final class MainInitialEventWithDefaultShapes  extends MainEvent {
  Layout layout;
  List<BaseShape> shapes = [];
  MainInitialEventWithDefaultShapes({required this.layout , required this.shapes});
}

final class PrintInitialEvent extends MainEvent {
  final Layout layout;
  PrintInitialEvent({required this.layout});
}



final class OnNewShapeAdded extends MainEvent {
  final BaseShape shape;
  OnNewShapeAdded({required this.shape});
}

final class OnLayerItemClick extends MainEvent {
  final BaseShape shape;
  OnLayerItemClick({required this.shape});
}

final class OnLayerItemPropertyChange extends MainEvent {
  final BaseShape shape;
  OnLayerItemPropertyChange({required this.shape});
}

// add drag event
// on click
final class OnPanStart extends MainEvent {
  final TapDownDetails details;
  OnPanStart({required this.details});
}

final class OnPanUpdate extends MainEvent {
  final DragUpdateDetails details;
  OnPanUpdate({required this.details});
}
final class OnLoad extends MainEvent {
  final Map<String , dynamic > data ;
  OnLoad({required this.data });
  factory OnLoad.fromString (String data ) {
    return OnLoad(
      data:  jsonDecode(data),
    );
  }
}
final class OnLayerDelete extends MainEvent {
  final BaseShape shape;
  OnLayerDelete({required this.shape});
}
final class OnLayerMoveUp extends MainEvent {
  final BaseShape shape;
  OnLayerMoveUp({required this.shape});
}
final class OnLayerMoveDown extends MainEvent {
  final BaseShape shape;
  OnLayerMoveDown({required this.shape});
}

final class SaveFile extends MainEvent {


  SaveFile( );
}

