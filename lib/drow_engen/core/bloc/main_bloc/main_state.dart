part of 'main_bloc.dart';

@immutable
sealed class MainState {}

final class MainInitial extends MainState {


}
final class MainBlocState extends MainState {
  final String name;
  MainBlocState({ required this.name});
}

final class MainBlocState2 extends MainState {
  final Color color ;
  MainBlocState2({ required this.color});
}
// loading
final class MainLoading extends MainState {
  final Layout layout;
  MainLoading({ required this.layout});
}

final class MainLoaded extends MainState {

  MainLoaded( );
}

final class ShapeDraw extends MainState {
  final List<BaseShape> shapes;
    Layout? layout;
  ShapeDraw({ required this.shapes , this.layout  });
}
final class ShapeSelected extends MainState {
  final BaseShape shape;
  final int index;

  ShapeSelected({ required this.shape, required this.index});
}

final class ShapeSelectedFromPanel extends MainState {
  final BaseShape shape;
  final int index;

  ShapeSelectedFromPanel({ required this.shape, required this.index});
}
final class ShapeUnSelectedFromPanel extends MainState {


  ShapeUnSelectedFromPanel( );
}
final class ShapeDeleted extends MainState {
  ShapeDeleted( );
}

  final class ShapeProperty extends MainState {
  final BaseShape shape;
  ShapeProperty({ required this.shape});
  }

  final class DrawSaved  extends MainState {
  final  Register  register  ;
   ByteData?  byetData  ;
   Uint8List? image;
  DrawSaved({  required   this. image ,  required this.register ,   this. byetData });
  }
