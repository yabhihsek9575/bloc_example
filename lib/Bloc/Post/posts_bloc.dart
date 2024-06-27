import 'package:bloc_example/Model/popularProductModel.dart';
import 'package:bloc_example/Model/posts_model.dart';
import 'package:bloc_example/Reposatory/post_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final PostRepository _postRepository;

  // Define Initial Page
  int page = 1;

  // Declare Loading bool variable to
  // show Loading indicator when fetching new posts
  bool isLoadMore = false;
  int limit = 0;

  // Scroll Controller for ListView Builder
  ScrollController scrollController = ScrollController();

  PostsBloc(this._postRepository) : super(const PostsInitial(null)) {
    // ---------------------------------------------
    // Add a listener to Controller
    // and Load more posts when scrolled till last
    // ---------------------------------------------
    scrollController.addListener(() {
      add(PostsLoadMoreEvent());
    });

    // ---------------------------------------------
    // Posts Load Event
    // ---------------------------------------------
    on<PostsLoadedEvent>((event, emit) async {
      emit(const PostsInitial(null));
      try {
        final posts = await _postRepository.fetchPosts(page);
        emit(PostsLoadedState(posts: posts));
      } catch (error) {
        emit(PostsErrorState(error.toString()));
      }
    });

    // ---------------------------------------------
    // Posts LoadMore Event
    // ---------------------------------------------
    on<PostsLoadMoreEvent>((event, emit) async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        isLoadMore = true;
        page++;
       print("PostList Here " +  state.posts.length.toString());
        final newPosts = await _postRepository.fetchPosts(state.posts.length);

        // ---------------------------------------------
        // Appending/Combining Load List with new list
        // ---------------------------------------------
        emit(PostsLoadedState(
          posts: [...state.posts, ...newPosts],
        ));
      }
    });
  }
}