abstract class SignupStates{}

class InitialSignupState extends SignupStates{}

class AwaitSignupResultState extends SignupStates{}

class SignedUpSuccessfullyState extends SignupStates{}

class ErrorWhileSigningUpState extends SignupStates{}

class InternetConnectionErrorState extends SignupStates{}