part of 'my_news_bloc.dart';

abstract class MyNewsEvent extends Equatable {
  const MyNewsEvent();

  @override
  List<Object> get props => [];
}

class RequestAllNewsEvent extends MyNewsEvent {
  @override
  List<Object> get props => [];
}

class SaveNewElementEvent extends MyNewsEvent {
  final New noticia;

  SaveNewElementEvent({@required this.noticia});
  @override
  List<Object> get props => [noticia];
}

class PickImageEvent extends MyNewsEvent {
  @override
  List<Object> get props => [];
}
