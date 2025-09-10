part of 'notifications_bloc.dart';

@immutable
class NotificationsStates {}

final class GetNotificationsLoading extends NotificationsStates {}

final class GetNotificationsSuccess extends NotificationsStates {}

final class GetNotificationsFailed extends NotificationsStates {}

final class GetNotificationsEmpty extends NotificationsStates {}
