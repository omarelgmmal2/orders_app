part of 'get_delete_address_bloc.dart';

@immutable
class GetDeleteAddressesStates {}

class GetAddressesSuccessState extends GetDeleteAddressesStates {}

class GetAddressesLoadingState extends GetDeleteAddressesStates {}

class GetAddressesFailedState extends GetDeleteAddressesStates {}

class DeleteAddressesSuccessState extends GetDeleteAddressesStates {
  final int id;

  DeleteAddressesSuccessState({required this.id});

}

class DeleteAddressesLoadingState extends GetDeleteAddressesStates {
  final int id;

  DeleteAddressesLoadingState({required this.id});
}

class DeleteAddressesFailedState extends GetDeleteAddressesStates {}
