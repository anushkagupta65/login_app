part of 'activity_lifecycle_cubit.dart';

@freezed
class ActivityLifecycleState with _$ActivityLifecycleState {
  const factory ActivityLifecycleState.initial() = _Initial;

  const factory ActivityLifecycleState.resumed() = _Resumed;

  const factory ActivityLifecycleState.paused() = _Paused;

  const factory ActivityLifecycleState.detached() = _Detached;

  const factory ActivityLifecycleState.inactive() = _Inactive;

  const factory ActivityLifecycleState.hidden() = _Hidden;
}
