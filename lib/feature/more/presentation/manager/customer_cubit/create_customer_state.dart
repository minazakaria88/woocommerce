abstract class CreateCustomerState{}

class InitCustomerState extends CreateCustomerState{}

class CreateCustomerLoadingState extends CreateCustomerState{}

class CreateCustomerSuccessState extends CreateCustomerState{}

class CreateCustomerErrorState extends CreateCustomerState{
  final String error;

  CreateCustomerErrorState(this.error);
}

class LoginCustomerLoadingState extends CreateCustomerState{}

class LoginCustomerSuccessState extends CreateCustomerState{}

class LoginCustomerSuccessEmptyState extends CreateCustomerState{}

class LoginCustomerErrorState extends CreateCustomerState{
  final String error;

  LoginCustomerErrorState(this.error);
}

