part of 'my_news_bloc.dart';

abstract class MyNewsState extends Equatable {
  const MyNewsState();

  @override
  List<Object> get props => [];
}

class MyNewsInitial extends MyNewsState {}

class LoadingState extends MyNewsState {}

class LoadedNewsState extends MyNewsState {
  final List<New> noticiasList;

  LoadedNewsState({@required this.noticiasList});
  @override
  List<Object> get props => [noticiasList];
}

class PickedImageState extends MyNewsState {
  final File image;

  PickedImageState({@required this.image});
  @override
  List<Object> get props => [image];
}

class SavedNewState extends MyNewsState {
  List<Object> get props => [];
}

class ErrorMessageState extends MyNewsState {
  final String errorMsg;

  ErrorMessageState({@required this.errorMsg});
  @override
  List<Object> get props => [errorMsg];
}
