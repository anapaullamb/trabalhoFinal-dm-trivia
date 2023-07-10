import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../common/errors/errors_classes.dart';
import '../categoria_entity.dart';

abstract class ITriviaAddCategoriaCase {
  Future<void> call(String userId,Categoria categoria);
}
