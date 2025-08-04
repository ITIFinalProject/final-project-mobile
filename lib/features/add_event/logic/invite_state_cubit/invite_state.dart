import 'package:equatable/equatable.dart';

abstract class InviteState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InviteInitial extends InviteState {}

class InviteLoading extends InviteState {}

class InviteSuccess extends InviteState {}

class InviteError extends InviteState {
  final String message;
  InviteError(this.message);

  @override
  List<Object?> get props => [message];
}
