part of 'app_manager_cubit.dart';

@immutable
abstract class AppManagerState {}

class LoadingDependencies extends AppManagerState {}

class WaitingToStartGame extends AppManagerState {}

class GameSession extends AppManagerState {}
