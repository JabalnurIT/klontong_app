part of 'provisioning_bloc.dart';

sealed class ProvisioningState extends Equatable {
  const ProvisioningState();
  
  @override
  List<Object> get props => [];
}

final class ProvisioningInitial extends ProvisioningState {}
