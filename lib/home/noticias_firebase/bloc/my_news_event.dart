part of 'my_news_bloc.dart';

abstract class MyNewsEvent extends Equatable {
  const MyNewsEvent();

  @override
  List<Object> get props => [];
}

//activado al iniciar
class RequestAllNewsEvent extends MyNewsEvent {}

//activado con el boton de immagen
class PickImageEvent extends MyNewsEvent {}

//activado con el boton de guardar
class SaveElementEvent extends MyNewsEvent {
  final Articles noticia;
  SaveElementEvent({@required this.noticia});

  @override
  List<Object> get props => [noticia];
}
