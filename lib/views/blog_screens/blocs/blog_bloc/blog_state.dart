part of 'blog_bloc.dart';

@immutable
abstract class BlogState {}

abstract class BlogActionState extends BlogState{}

class BlogInitialState extends BlogState {}

class BlogLoadingState extends BlogState{}

class BlogLoadedSuccessState extends BlogState{
}

class BlogErrorState extends BlogState{}

class BlogNavigateToUploadViewActionState extends BlogActionState{}

class BlogNavigateToDetailsViewActionState extends BlogActionState{}

class BlogDeleteButtonClickedActionState extends BlogActionState{}

class BlogBookmarkAddedActionState extends BlogActionState{
}