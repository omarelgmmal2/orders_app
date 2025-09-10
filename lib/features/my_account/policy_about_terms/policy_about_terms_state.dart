part of 'policy_about_terms_bloc.dart';

@immutable

class PolicyStates {}

class GetPolicySuccess extends PolicyStates {
  final PolicyModel model;

  GetPolicySuccess({required this.model});
}

class GetPolicyLoading extends PolicyStates {}

class GetPolicyFailed extends PolicyStates {}

class AboutSuccessState extends PolicyStates {
  final AboutModel model;

  AboutSuccessState({required this.model});
}

class AboutLoadingState extends PolicyStates {}

class AboutFailedState extends PolicyStates {}


class TermsSuccessState extends PolicyStates {
  final TermsModel model;

  TermsSuccessState({required this.model});
}

class TermsLoadingState extends PolicyStates {}

class TermsFailedState extends PolicyStates {}
