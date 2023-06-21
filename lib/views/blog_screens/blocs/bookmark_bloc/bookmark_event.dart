part of 'bookmark_bloc.dart';

@immutable
abstract class BookmarkEvent {}

class BookmarkInitialEvent extends BookmarkEvent{}

class BlogBookmarkButtonClickedEvent extends BookmarkEvent {
  BlogDataModel clickedEvent;
  BlogBookmarkButtonClickedEvent({required this.clickedEvent});
}
