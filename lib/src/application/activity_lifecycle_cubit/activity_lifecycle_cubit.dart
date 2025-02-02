// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'activity_lifecycle_cubit.freezed.dart';
part 'activity_lifecycle_state.dart';

class ActivityLifecycleCubit extends Cubit<ActivityLifecycleState> {
  ActivityLifecycleCubit() : super(const ActivityLifecycleState.initial());

  void applicationLifecycleChanged(
      {required AppLifecycleState lifecycleState}) {
    switch (lifecycleState) {
      case AppLifecycleState.resumed:
        emit(const ActivityLifecycleState.resumed());
        break;
      case AppLifecycleState.paused:
        emit(const ActivityLifecycleState.paused());
        break;
      case AppLifecycleState.inactive:
        emit(const ActivityLifecycleState.inactive());
        break;
      case AppLifecycleState.detached:
        emit(const ActivityLifecycleState.detached());
      case AppLifecycleState.hidden:
        emit(const ActivityLifecycleState.hidden());
        break;
    }
  }
}
