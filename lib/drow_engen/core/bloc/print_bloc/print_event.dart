part of 'print_bloc.dart';

/*
// we have evnets
// 1- MainInitialevent
// 2- tool box itme click
// 3- leyer item click
// 4- layer itme property change
// */
@immutable
sealed class PrintEvent {}



final class PrintInitialEvent extends PrintEvent {
  final Layout layout;
  final List<BaseShape> shapes;
  PrintInitialEvent({required this.layout , required this.shapes});
}
final class PrintUnit8ListInitialEvent extends PrintEvent {
   final Uint8List image;
  final Layout layout;
   PrintUnit8ListInitialEvent({required this.image , required this.layout});
}
final class OnLoad extends PrintEvent {
  final Map<String , dynamic > data ;
  OnLoad({required this.data });
  factory OnLoad.fromString (String data ) {
    return OnLoad(
      data:  jsonDecode(data),
    );
  }
}

final class SaveFile extends PrintEvent {
  double? width;
  double? height;
  bool isDouble = false;
  SaveFile({this.width , this.height , this.isDouble=false });
}

