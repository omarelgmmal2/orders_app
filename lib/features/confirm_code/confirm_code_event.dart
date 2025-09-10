part of 'confirm_code_bloc.dart';

@immutable
class ConfirmCodeEvents {}
class ConfirmCodeEvent extends ConfirmCodeEvents{
  final String phone;
  final bool isActive;

  ConfirmCodeEvent({required this.phone,required this.isActive});
}

class ResendCodeEvent extends ConfirmCodeEvents{
  final String phone;

  ResendCodeEvent({required this.phone});
}
