part of 'edit_profile_bloc.dart';

@immutable

class EditDataEvents {}

class EditProfileEvent extends EditDataEvents {
  final String fullName;
  final String phone;

  EditProfileEvent({required this.fullName, required this.phone});
}