import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'countdown_timer_state.dart';

class CountdownTimerCubit extends Cubit<CountdownTimerState> {
  CountdownTimerCubit() : super(const CountdownTimerInitial(Duration.zero));

  final Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;

  void startCounting() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        emit(CountdownTimerTicking(_stopwatch.elapsed));
      },
    );
    _stopwatch.start();
  }

  void stopCounting() {
    _stopwatch.stop();
    emit(CountdownTimerCompleted(_stopwatch.elapsed));

    _timer?.cancel();
  }
}
