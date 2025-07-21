import 'package:equatable/equatable.dart';

class FavoriteState extends Equatable {
  final Set<int> favoriteIds;

  const FavoriteState({this.favoriteIds = const {}});

  FavoriteState copyWith({Set<int>? favoriteIds}) {
    return FavoriteState(favoriteIds: favoriteIds ?? this.favoriteIds);
  }

  @override
  List<Object?> get props => [favoriteIds];
}