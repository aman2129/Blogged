part of 'blog_bloc.dart';

@immutable
abstract class BlogEvent {}

class BlogInitialEvent extends BlogEvent {}

class BlogNavigateToUploadViewEvent extends BlogEvent {}

class BlogNavigateToDetailsViewEvent extends BlogEvent {
}

class BlogDeleteButtonClickedEvent extends BlogEvent {}

class BlogBookmarkButtonClickedEvent extends BlogEvent {
  BlogDataModel clickedEvent;
  BlogBookmarkButtonClickedEvent({required this.clickedEvent});
}
