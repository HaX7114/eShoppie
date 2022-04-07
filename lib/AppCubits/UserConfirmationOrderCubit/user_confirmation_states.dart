abstract class UserConfirmationStates {}

class InitConfirmationState extends UserConfirmationStates {}

class ChangePaymentState extends UserConfirmationStates {}

class SetGettingLocationState extends UserConfirmationStates {}

class SetGotAddressState extends UserConfirmationStates {}

class ErrorGettingAddressState extends UserConfirmationStates {}

//Saving address states

class ErrorSavingAddressState extends UserConfirmationStates {}

class SavedAddressState extends UserConfirmationStates {}

class SavingAddressState extends UserConfirmationStates {}

//Saving updated address states

class ErrorSavingUpdateAddressState extends UserConfirmationStates {}

class SavedUpdatedAddressState extends UserConfirmationStates {}

class SavingUpdatedAddressState extends UserConfirmationStates {}
