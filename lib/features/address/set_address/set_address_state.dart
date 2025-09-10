part of 'set_address_bloc.dart';

@immutable

class SetUpdateAddressStates {}

class SetAddressSuccessState extends SetUpdateAddressStates {}

class SetAddressLoadingState extends SetUpdateAddressStates {}

class SetAddressFailedState extends SetUpdateAddressStates {}
///////////////////////////////////////////////////


class UpdateAddressSuccessState extends SetUpdateAddressStates {}

class UpdateAddressLoadingState extends SetUpdateAddressStates {}

class UpdateAddressFailedState extends SetUpdateAddressStates {}
