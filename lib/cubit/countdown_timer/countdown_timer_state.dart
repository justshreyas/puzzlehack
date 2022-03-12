part of 'countdown_timer_cubit.dart';

@immutable
abstract class CountdownTimerState {
  final Duration elapsed;

  const CountdownTimerState(this.elapsed);
}

class CountdownTimerInitial extends CountdownTimerState {
  const CountdownTimerInitial(Duration elapsed) : super(elapsed);
}

class CountdownTimerTicking extends CountdownTimerState {
  const CountdownTimerTicking(Duration elapsed) : super(elapsed);
}

class CountdownTimerCompleted extends CountdownTimerState {
  const CountdownTimerCompleted(Duration elapsed) : super(elapsed);
}
