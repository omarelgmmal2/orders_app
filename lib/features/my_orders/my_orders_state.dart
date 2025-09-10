part of 'my_orders_bloc.dart';

@immutable

class MyOrdersStates {}

final class GetCurrentOrdersSuccessState extends MyOrdersStates {}

final class GetCurrentOrdersLoadingState extends MyOrdersStates {}

final class GetCurrentOrdersFailedState extends MyOrdersStates {}

final class GetCurrentOrdersEmptyState extends MyOrdersStates {
  final bool isEmpty;

  GetCurrentOrdersEmptyState({required this.isEmpty});
}

final class GetFinishedOrdersSuccessState extends MyOrdersStates {}

final class GetFinishedOrdersLoadingState extends MyOrdersStates {}

final class GetFinishedOrdersFailedState extends MyOrdersStates {}

final class GetFinishedOrdersEmptyState extends MyOrdersStates {
  final bool isEmpty;

  GetFinishedOrdersEmptyState({required this.isEmpty});
}

final class GetOrderSuccessState extends MyOrdersStates {}

final class GetOrderLoadingState extends MyOrdersStates {}

final class GetOrderFailedState extends MyOrdersStates {}

final class CancelOrderSuccessState extends MyOrdersStates {}

final class CancelOrderLoadingState extends MyOrdersStates {}

final class CancelOrderFailedState extends MyOrdersStates {}

final class AddOrderSuccessState extends MyOrdersStates {}

final class AddOrderLoadingState extends MyOrdersStates {}

final class AddOrderFailedState extends MyOrdersStates {}
