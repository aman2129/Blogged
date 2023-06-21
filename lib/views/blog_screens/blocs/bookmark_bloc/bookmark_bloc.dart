import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../data_model/data_model.dart';

part 'bookmark_event.dart';
part 'bookmark_state.dart';

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  BookmarkBloc() : super(BookmarkInitialState()) {
    on<BookmarkInitialEvent>(bookmarkInitialEvent);
  }

  FutureOr<void> bookmarkInitialEvent(BookmarkInitialEvent event, Emitter<BookmarkState> emit) {
    emit(BookmarkLoadingState());
    emit(BookmarkLoadedSuccessState());

  }
}
