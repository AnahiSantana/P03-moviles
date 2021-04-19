part of 'ext_noticias_bloc.dart';

abstract class ExtNoticiasState extends Equatable {
  const ExtNoticiasState();

  @override
  List<Object> get props => [];
}

class ExtNoticiasInitial extends ExtNoticiasState {}

class LoadingState extends ExtNoticiasState {}

class LoadedNewsState extends ExtNoticiasState {
  final List<New> noticiasList;

  LoadedNewsState({@required this.noticiasList});
  @override
  List<Object> get props => [noticiasList];
}

class ErrorMessageState extends ExtNoticiasState {
  final String errorMsg;

  ErrorMessageState({@required this.errorMsg});
  @override
  List<Object> get props => [errorMsg];
}

class LoadSavedNewsState extends ExtNoticiasState {
  final List<New> noticiasList;

  LoadSavedNewsState({@required this.noticiasList});
  @override
  List<Object> get props => [noticiasList];
}
