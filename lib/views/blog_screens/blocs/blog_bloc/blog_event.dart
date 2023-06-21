part of 'blog_bloc.dart';

@immutable
abstract class BlogEvent {}

class BlogInitialEvent extends BlogEvent {}

class BlogNavigateToUploadViewEvent extends BlogEvent {}

class BlogNavigateToDetailsViewEvent extends BlogEvent {
  final String imageUrl;
  final String title;
  final String desc;

  BlogNavigateToDetailsViewEvent(
      {required this.imageUrl, required this.title, required this.desc});
}

class BlogDeleteButtonClickedEvent extends BlogEvent {}

class BlogBookmarkButtonClickedEvent extends BlogEvent {
  BlogDataModel clickedEvent;
  BlogBookmarkButtonClickedEvent({required this.clickedEvent});
}
