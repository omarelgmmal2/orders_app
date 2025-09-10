part of 'wallet_bloc.dart';

@immutable

class WalletStates {}

class GetWalletLoading extends WalletStates {}

class GetWalletFailed extends WalletStates {}

class GetWalletSuccess extends WalletStates {}

////////////////////////////////

class GetWalletPaginatedLoading extends WalletStates {}

class GetWalletPaginatedFailed extends WalletStates {}

class GetWalletPaginatedSuccess extends WalletStates {}

///////////////////////////////

class WalletChargeLoading extends WalletStates {}

class WalletChargeFailed extends WalletStates {}

class WalletChargeSuccess extends WalletStates {}

///////////////////////////////


class GetWalletFromPaginationLoadingState extends WalletStates{}
class GetWalletFromPaginationFailedState extends WalletStates{}