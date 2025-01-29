abstract class SendMoneyStates {}

class SendMoneyInitial extends SendMoneyStates {}

class SendMoneyLoading extends SendMoneyStates {}

class SendMoneySuccess extends SendMoneyStates {}

class SendMoneyError extends SendMoneyStates {
  final String message;

  SendMoneyError(this.message);
}
