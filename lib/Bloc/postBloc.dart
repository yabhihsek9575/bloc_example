
import 'package:bloc_example/Bloc/PostEvent.dart';
import 'package:bloc_example/Bloc/postStates.dart';
import 'package:bloc_example/api/PostApi.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(const PostsState()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetPostsEvent) {
        if (state.hasReachedMax) return;
        try {
          if (state.status == PostStatus.loading) {
            final posts = await PostsApi.getPosts();
            return posts.isEmpty
                ? emit(state.copyWith(
                status: PostStatus.success, hasReachedMax: true))
                : emit(state.copyWith(
                status: PostStatus.success,
                posts: posts,
                hasReachedMax: false));
          } else {
            final posts = await PostsApi.getPosts(state.posts.length);
            posts.isEmpty
                ? emit(state.copyWith(hasReachedMax: true))
                : emit(state.copyWith(
                status: PostStatus.success,
                posts: List.of(state.posts)..addAll(posts),
                hasReachedMax: false));
          }
        } catch (e) {
          emit(state.copyWith(
              status: PostStatus.error, errorMessage: "failed to fetch posts"));
        }
      }
    });
  }
}
