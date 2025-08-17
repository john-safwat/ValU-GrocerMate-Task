import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  // Called whenever a BLoC is instantiated.
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('✅ [CREATE] ${bloc.runtimeType}');
  }

  // Called whenever an event is added to any BLoC.
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print('⚫️ [EVENT] ${bloc.runtimeType}: $event');
  }

  // Called whenever a state change occurs in any BLoC or Cubit.
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('↔️ [CHANGE] ${bloc.runtimeType}: ${change.currentState} -> ${change.nextState}');
  }

  // Called whenever a transition occurs in any BLoC.
  // A transition is the link between an event and the resulting state change.
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print('🔄 [TRANSITION] ${bloc.runtimeType}: Event ${transition.event.runtimeType} leads to ${transition.nextState.runtimeType}');
  }

  // Called whenever an error is thrown in any BLoC or Cubit.
  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    print('❌ [ERROR] ${bloc.runtimeType}: $error');
  }

  // Called whenever a BLoC is closed.
  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print('🛑 [CLOSE] ${bloc.runtimeType}');
  }
}