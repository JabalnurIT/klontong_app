import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'provisioning_event.dart';
part 'provisioning_state.dart';

class ProvisioningBloc extends Bloc<ProvisioningEvent, ProvisioningState> {
  ProvisioningBloc() : super(ProvisioningInitial()) {
    on<ProvisioningEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
