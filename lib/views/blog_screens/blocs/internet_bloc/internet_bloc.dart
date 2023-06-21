import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'internet_event.dart';

part 'internet_state.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription? connectivitySubscription;
  InternetBloc() : super(InternetInitialState()) {
    on<InternetGainedEvent>((event, emit) => emit(InternetGainedState()));
    on<InternetLostEvent>((event, emit) => emit(InternetLostState()));

    connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((result) {
          if (result == ConnectivityResult.mobile ||
              result == ConnectivityResult.wifi) {
            add(InternetGainedEvent());
          } else {
            add(InternetLostEvent());
          }
        });
  }
  @override
  Future<void> close() {
    connectivitySubscription?.cancel();
    return super.close();
  }
}
