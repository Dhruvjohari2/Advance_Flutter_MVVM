import 'package:advance_mvvm/data/mapper/mapper.dart';
import 'package:advance_mvvm/data/network/failure.dart';
import 'package:advance_mvvm/presentation/resources/strings_manager.dart';
import 'package:flutter/material.dart';

enum StateRendererType {
  POPUP_LOADING_STATE,
  POPUP_ERROR_STATE,

  FULL_SCREEN_LOADING_STATE,
  FULL_SCREEN_ERROR_STATE,
  CONTENT_SCREEN_STATE,
  EMPTY_SCREEN_STATE
}

class StateRenderer extends StatelessWidget {
  StateRenderer stateRendererType;
  Failure failure;
  String message;
  String title;
  Function retryActionFunction;

  StateRenderer({super.key, required this.stateRendererType, Failure? failure, String? message, String? title, required this.retryActionFunction})
      : message = message ?? AppStrings.loading,
        title = title ?? EMPTY,
        failure = failure ?? DefaultFailure();

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
