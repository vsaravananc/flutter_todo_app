part of 'date_bloc_bloc.dart';

sealed class DateBlocState extends Equatable {
  const DateBlocState();
  
  @override
  List<Object> get props => [];
}

final class DateBlocInitial extends DateBlocState {}
