import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'app_manager_state.dart';

class AppManagerCubit extends Cubit<AppManagerState> {
  AppManagerCubit() : super(LoadingDependencies());

  void startApp() {
    emit(WaitingToStartGame());
  }

  void restart() {
    emit(WaitingToStartGame());
  }

  void startGame() {
    emit(GameSession());
  }
}
