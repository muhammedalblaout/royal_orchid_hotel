part of 'service_bloc.dart';

@immutable
sealed class ServiceState {}

final class ServiceInitial extends ServiceState {}
final class ServiceLoading extends ServiceState {}
final class ServiceFail extends ServiceState {
  final String massage;

  ServiceFail(this.massage);
}
final class ServiceSuccess extends ServiceState {
  final List<Service> list;

  ServiceSuccess(this.list);
}
