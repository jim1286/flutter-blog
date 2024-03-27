import 'package:flutter_blog/models/user_model.dart';
import 'package:flutter_blog/services/user_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider =
    FutureProvider.autoDispose<UserModel>((ref) => UserService().getUser());
