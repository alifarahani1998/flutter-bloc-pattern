import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc_proj/constants/enums.dart';
import 'package:meta/meta.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {

  final Connectivity connectivity;

  StreamSubscription streamSubscription;

  InternetCubit({@required this.connectivity}) : super(InternetLoading()) {
    monitorInternetConnection();
  }

  StreamSubscription<ConnectivityResult> monitorInternetConnection() {
    return streamSubscription = connectivity.onConnectivityChanged.listen((event) {
    if (event == ConnectivityResult.wifi)
      emitInternetConnected(ConnectionType.Wifi);
    else if (event == ConnectivityResult.mobile)
      emitInternetConnected(ConnectionType.Mobile);
    else if (event == ConnectivityResult.none)
      emitInternetDisconnected();
  });
  }


  void emitInternetConnected(ConnectionType _connectionType) => emit(InternetConnected(connectionType: _connectionType));

  void emitInternetDisconnected() => emit(InternetDisconnected());


  @override
  Future<Function> close() {
    streamSubscription.cancel();
    return super.close();
  }
}
