import 'package:app_filmes_dart_week_4_edicao/application/ui/messages/messages_mixin.dart';
import 'package:app_filmes_dart_week_4_edicao/models/genre_model.dart';
import 'package:app_filmes_dart_week_4_edicao/services/genres/genres_service.dart';
import 'package:get/get.dart';

class MoviesController extends GetxController with MessagesMixin {
  final GenresService _genresService;
  final _message = Rxn<MessageModel>();
  final genres = <GenreModel>[].obs;

  MoviesController({required GenresService genresService})
      : _genresService = genresService;

  @override
  void onInit() {
    super.onInit();
    messageListener(_message);
  }

  @override
  void onReady() async {
    super.onReady();
    try {
      final genres = await _genresService.getGenres();
      this.genres.assignAll(genres);
    } catch (e) {
      _message(MessageModel.error(
          title: 'Erro', message: 'Erro ao buscar Categorias'));
    }
  }
}