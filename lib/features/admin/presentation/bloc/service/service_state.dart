part of 'service_bloc.dart';

@immutable
sealed class AdminServiceState {}

final class AdminServiceInitial extends AdminServiceState {}
final class AdminServiceLoading extends AdminServiceState {}
final class AdminServiceFail extends AdminServiceState {
  final String massage;

  AdminServiceFail(this.massage);
}
final class AdminServiceSuccess extends AdminServiceState {
  final List<Service> list;

  AdminServiceSuccess(this.list);
}
final class AdminUpdateServiceSuccess extends AdminServiceState {}


