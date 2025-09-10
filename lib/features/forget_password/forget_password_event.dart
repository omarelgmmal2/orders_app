part of 'forget_password_bloc.dart';

@immutable
class ForgetPasswordEvents {}
class ForgetPasswordEvent extends  ForgetPasswordEvents{
  final String phone;
  final bool resend;

  ForgetPasswordEvent({required this.phone, this.resend = false});
}
