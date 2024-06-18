part of 'service_bloc.dart';

@immutable
sealed class ServiceEvent {}
class GetAllServicesEvent extends ServiceEvent{}

