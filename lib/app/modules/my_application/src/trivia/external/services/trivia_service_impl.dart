import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_with_firebase/app/modules/my_application/src/trivia/domain/categoria_mapper.dart';
import 'package:login_with_firebase/app/modules/my_application/src/trivia/domain/user_ranking_entity.dart';
import '../../domain/services_interfaces/trivia_service_contract.dart';
import '../../domain/categoria_entity.dart';

class TriviaServiceImpl implements ITriviaService {
  late final User? user;
  late final DocumentReference userRef;
  TriviaServiceImpl() : super() {
    userRef = FirebaseFirestore.instance.collection('users').doc();
  }


  @override
  Future<List<Categoria>> getDominioCategorias() async {
    var response = await FirebaseFirestore.instance.collection('CategoriasDisponiveis').get();
    return response.docs.map((doc) => CategoriaMapper.mapToEntity(doc.data(), doc.id)).toList();
  }
  @override
  Future<List<Categoria>> getCategorias(String userId) async {
    var response = await FirebaseFirestore.instance.collection('Users').doc(userId).collection('Categorias').get();
    var list =  response.docs.map((doc) => CategoriaMapper.mapToEntity(doc.data(), doc.id)).toList();
    return list;
  }
  @override
  Future<void> addCategoria(String userId,Categoria categoria) async {
    var response = await FirebaseFirestore.instance
        .collection('Users').doc(userId).collection('Categorias').doc()
        .set({'value': categoria.value, 'nome': categoria.nome});

  }

  @override
  Future<void> delCategoria(String userId,String categoriaId) async{
    var docCategoria = await FirebaseFirestore.instance.collection('Users').doc(userId).collection('Categorias').doc(categoriaId);
    docCategoria.delete();
  }

  @override
  Future<void> putCategoria(String userId,String categoriaId, Categoria categoriaNova) async{
    var docCategoria = await FirebaseFirestore.instance.collection('Users').doc(userId).collection('Categorias').doc(categoriaId);
    docCategoria.update({'value':categoriaNova.value, 'nome': categoriaNova.nome});
  }
  @override
  Future<List<UserRanking>> getRanking() async{
    var response = await FirebaseFirestore.instance.collection('Users').get();
    var list = response.docs.map((doc) => UserRanking.mapToEntity(doc.data())).toList();
    list.sort((a, b) => b.pontuacao!.compareTo(a.pontuacao!));
    return list;
  }
}
