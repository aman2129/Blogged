part of 'bookmark_bloc.dart';

@immutable
abstract class BookmarkState {}

class BookmarkInitialState extends BookmarkState {}

class BookmarkLoadingState extends BookmarkState{}

class BookmarkLoadedSuccessState extends BookmarkState{
}

class BlogBookmarkButtonClickedActionState extends BookmarkState{

}
