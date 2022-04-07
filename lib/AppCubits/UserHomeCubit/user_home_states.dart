abstract class UserHomeStates {}

//Navigation bar states

class InitialUserHomeState extends UserHomeStates {}

class ChangeNavBarState extends UserHomeStates {}

class ChangeLikeButtonState extends UserHomeStates {}

//Cart button state

class ChangeCartButtonState extends UserHomeStates {}

//Added to cart

class AddedToCartState extends UserHomeStates {}

//Error while adding to cart

class NoCartsState extends UserHomeStates {}

class ErrorWhileAddingToCart extends UserHomeStates {}

//User getting profile states

class GotUserDataState extends UserHomeStates {}

class ErrorUserDataState extends UserHomeStates {}

//Heart animation state

class ChangeHeartAnimation extends UserHomeStates {}

//Added to favorites

class AddedToFavState extends UserHomeStates {}

//Error while adding to favorites

class NoFavoritesState extends UserHomeStates {}

class ErrorWhileAddingToFav extends UserHomeStates {}

//Getting products states

class GotProductsState extends UserHomeStates {}

class GotProductsLoadingState extends UserHomeStates {}

class GotProductsErrorState extends UserHomeStates {}

//Getting categories states

class GotCategoriesState extends UserHomeStates {}

class GotCategoriesLoadingState extends UserHomeStates {}

class GotCategoriesErrorState extends UserHomeStates {}

//Signing out

class SigningOutState extends UserHomeStates {}

class SignedOutState extends UserHomeStates {}

class ErrorSigningOutState extends UserHomeStates {}
