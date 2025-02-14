part of 'print_bloc.dart';

@immutable
sealed class PrintState {}

final class PrintMainInitial extends PrintState {


}
final class PrintBlocState extends PrintState {
  final String name;
  PrintBlocState({ required this.name});
}

final class MainBlocState2 extends PrintState {
  final Color color ;
  MainBlocState2({ required this.color});
}
// loading
final class PrintLoading extends PrintState {
  final Layout layout;
  PrintLoading({ required this.layout});
}

final class ShapeDraw extends PrintState {
  final List<BaseShape> shapes;
    Layout? layout;
  ShapeDraw({ required this.shapes , this.layout  });
}

  final class DrawSaved  extends PrintState {
  final  Register  register  ;
   ByteData?  byetData  ;
   Uint8List? image;
  DrawSaved({  required   this. image ,  required this.register ,   this. byetData });
  }
