  abstract class StatesShopHome{}

  class ShopInitialHomeStates extends StatesShopHome{}

  class ShopChangeBottomNavStates extends StatesShopHome{}

  class ProductLoadingState extends StatesShopHome {}

  class ProductSuccessState extends StatesShopHome {}

  class ProductErrorState extends StatesShopHome {
    final String error;
    ProductErrorState(this.error);
  }
  class CategoriesLoadingState extends StatesShopHome {}

  class CategoriesSuccessState extends StatesShopHome {}

  class CategoriesErrorState extends StatesShopHome {
    final String error;
    CategoriesErrorState(this.error);
  }


