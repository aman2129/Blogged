part of 'internet_bloc.dart';

@immutable
abstract class InternetState {}

class InternetInitialState extends InternetState {}

class InternetGainedState extends InternetState{}

class InternetLostState extends InternetState{}