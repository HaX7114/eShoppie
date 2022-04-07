abstract class UserOrderDetailsStates {}

class UserOrderDetailsInitState extends UserOrderDetailsStates {}

class CartProductsLoadingState extends UserOrderDetailsStates {}

class CartErrorState extends UserOrderDetailsStates {}

class GotCartProductsState extends UserOrderDetailsStates {}

class ChangeTotalPriceState extends UserOrderDetailsStates {}

//This will be used when the update qty on the server is not set
class ErrorWhileChangingTheAmount extends UserOrderDetailsStates {}

//This will be used while updating the qty on the sever
class LoadingWhileChangingTheAmount extends UserOrderDetailsStates {}

class IncreaseProductAmountState extends UserOrderDetailsStates {}

class DecreaseProductAmountState extends UserOrderDetailsStates {}

class IncreaseTotalAmountState extends UserOrderDetailsStates {}

class DecreaseTotalAmountState extends UserOrderDetailsStates {}

//Setting an order status

class SettingTheOrderState extends UserOrderDetailsStates {}

class OrderSetSuccessState extends UserOrderDetailsStates {}

class OrderNotSetFailState extends UserOrderDetailsStates {}
