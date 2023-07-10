import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../common/errors/errors_classes.dart';
import '../categoria_entity.dart';

abstract class ITriviaGetCategoriasCase {
  Future<List<Categoria>> call(String userId);
}
