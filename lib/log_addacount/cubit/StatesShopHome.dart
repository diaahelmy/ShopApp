abstract class StatesShopHome{}

class ShopInitialHomeStates extends StatesShopHome{}

class ShopChangeBottomNavStates extends StatesShopHome{}

class ProductLoadingState extends StatesShopHome {}

class ProductSuccessState extends StatesShopHome {}

class ProductErrorState extends StatesShopHome {
  final String error;
  ProductErrorState(this.error);
}


