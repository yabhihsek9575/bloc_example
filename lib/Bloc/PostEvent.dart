// part of 'posts_bloc.dart';

import 'package:equatable/equatable.dart';

abstract class PostsEvent extends Equatable {
  const PostsEvent();

  @override
  List<Object> get props => [];
}

class GetPostsEvent extends PostsEvent{}