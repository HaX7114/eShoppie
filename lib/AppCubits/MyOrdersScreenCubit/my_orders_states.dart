abstract class MyOrdersStates {}

class MyOrdersInitState extends MyOrdersStates {}

class LoadingOrdersState extends MyOrdersStates {}

class LoadedOrdersState extends MyOrdersStates {}

class LoadedOrdersButEmptyState extends MyOrdersStates {}

class ErrorWhileLoadingOrdersState extends MyOrdersStates {}
