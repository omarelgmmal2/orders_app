part of 'get_delete_address_bloc.dart';

@immutable
class GetDeleteAddressesEvents {}

class GetAddressesEvent extends GetDeleteAddressesEvents {
  final bool isLoading;

  GetAddressesEvent({required this.isLoading});
}

class DeleteAddressesEvent extends GetDeleteAddressesEvents {
  final int id;

  DeleteAddressesEvent({required this.id});
}