part of 'sector_bloc.dart';

@immutable
sealed class SectorState {}

final class SectorInitial extends SectorState {}
final class SectorFaill extends SectorState{
  String massage;

  SectorFaill(this.massage);
}
final class SectorSuccess extends SectorState {
  List<String> sectors;

  SectorSuccess(this.sectors);
}
final class SectorLoading extends SectorState {}
