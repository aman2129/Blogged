part of 'internet_bloc.dart';

@immutable
abstract class InternetEvent {}

class InternetInitialEvent extends InternetEvent{}

class InternetGainedEvent extends InternetEvent{}

class InternetLostEvent extends InternetEvent{}