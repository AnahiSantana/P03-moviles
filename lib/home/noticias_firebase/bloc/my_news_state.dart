part of 'my_news_bloc.dart';

abstract class MyNewsState extends Equatable {
  const MyNewsState();

  @override
  List<Object> get props => [];
}

class MyNewsInitial extends MyNewsState {}

class LoadingState extends MyNewsState {}

class SavedNewState extends MyNewsState {}

//Cuando se muestra un error
class ErrorMessageState extends MyNewsState {
  final String errorMsg;
  ErrorMessageState({@required this.errorMsg});
  @override
  List<Object> get props => [errorMsg];
}

//Cuando trae a la vista la imagen seleccionada
class PickedImageState extends MyNewsState {
  final File image;
  PickedImageState({@required this.image});
  @override
  List<Object> get props => [image];
}

//Cuando trae las noticias de firebase
class LoadedNewState extends MyNewsState {
  final List<Articles> noticiasList;
  LoadedNewState({@required this.noticiasList});
  @override
  List<Object> get props => [noticiasList];
}
