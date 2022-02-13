abstract class LoginStates{}

class InitialLoginState extends LoginStates{}

class AwaitLoginResultState extends LoginStates{}

class LoggedSuccessfullyState extends LoginStates{}

class EmailOrPasswordIncorrectState extends LoginStates{}

class InternetConnectionErrorState extends LoginStates{}