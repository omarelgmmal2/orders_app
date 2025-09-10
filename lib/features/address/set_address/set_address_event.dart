part of 'set_address_bloc.dart';

@immutable
class SetUpdateAddressEvents {}

class SetAddressEvent extends SetUpdateAddressEvents {
  final String description;
  final String phone;

  final String type;
  final String isDefault;

  SetAddressEvent({
    required this.isDefault,
    required this.description,
    required this.phone,

    required this.type,
  });
}

class UpdateAddressEvent extends SetUpdateAddressEvents {
  final String description;
  final String phone;
  final String type;
  final String isDefault;
  final int id;
  UpdateAddressEvent({
    required this.isDefault,
    required this.id,
    required this.description,
    required this.phone,
    required this.type,
  });
}