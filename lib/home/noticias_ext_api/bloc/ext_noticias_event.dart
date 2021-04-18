part of 'ext_noticias_bloc.dart';

abstract class ExtNoticiasEvent extends Equatable {
  const ExtNoticiasEvent();

  @override
  List<Object> get props => [];
}

class RequestApiNewsEvent extends ExtNoticiasEvent {
  @override
  final String query;
  RequestApiNewsEvent({@required this.query});
  List<Object> get props => [query];
}

class SaveApiNewEvent extends ExtNoticiasEvent {
  final New noticia;

  SaveApiNewEvent({@required this.noticia});
  @override
  List<Object> get props => [noticia];
}
