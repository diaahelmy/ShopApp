import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/log_addacount/cubit/Favorite/FavoriteState.dart';
import 'package:shopapp/network/local/Cache.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super( const  FavoriteState() );

  static FavoriteCubit get(context) => BlocProvider.of(context);

  Future<void> loadFavorites() async {
    final saved = Cache.getData(key: 'favorites');
    if (saved is List<String>) {
      emit(FavoriteState(
        favoriteIds: saved.map((e) => int.parse(e)).toSet(),
      ));
      print("Loaded favorites from cache: $saved");
    }
  }

  void toggleFavorite(int productId) async {
    final current = Set<int>.from(state.favoriteIds);

    if (current.contains(productId)) {
      current.remove(productId);
    } else {
      current.add(productId);
    }

    // أولا نعمل emit

    emit(state.copyWith(favoriteIds: current));

    // ثم نخزن البيانات في الكاش
    await Cache.saveData(
      key: 'favorites',
      value: current.map((e) => e.toString()).toList(),
    );
    print("Saved favorites: ${current.toList()}");
  }

  bool isFavorite(int productId) {
    return state.favoriteIds.contains(productId);
  }
}
