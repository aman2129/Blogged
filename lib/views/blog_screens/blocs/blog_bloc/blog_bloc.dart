import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../../data_model/data_model.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  BlogBloc() : super(BlogInitialState()) {
    on<BlogInitialEvent>(blogInitialEvent);
    on<BlogNavigateToUploadViewEvent>(blogNavigateToUploadViewEvent);
    on<BlogNavigateToDetailsViewEvent>(blogNavigateToDetailsViewEvent);
    on<BlogDeleteButtonClickedEvent>(blogDeleteButtonClickedEvent);
    on<BlogBookmarkButtonClickedEvent>(blogBookmarkButtonClickedEvent);
  }

  FutureOr<void> blogInitialEvent(BlogInitialEvent event, Emitter<BlogState> emit) async {
    emit(BlogLoadingState());
    await Future.delayed(const Duration(seconds: 2));
    emit(BlogLoadedSuccessState());
  }

  FutureOr<void> blogNavigateToUploadViewEvent(BlogNavigateToUploadViewEvent event, Emitter<BlogState> emit) {
    emit(BlogNavigateToUploadViewActionState());
  }

  FutureOr<void> blogNavigateToDetailsViewEvent(BlogNavigateToDetailsViewEvent event, Emitter<BlogState> emit) {
    print("Clicked");
    emit(BlogNavigateToDetailsViewActionState());
  }

  FutureOr<void> blogDeleteButtonClickedEvent(BlogDeleteButtonClickedEvent event, Emitter<BlogState> emit) {
    emit(BlogDeleteButtonClickedActionState());
  }

  FutureOr<void> blogBookmarkButtonClickedEvent(BlogBookmarkButtonClickedEvent event, Emitter<BlogState> emit) {
    print('Clicked');
    emit(BlogBookmarkAddedActionState());
  }
}
