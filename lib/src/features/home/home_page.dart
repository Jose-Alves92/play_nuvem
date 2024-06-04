// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:play_nuvem/src/features/home/home_controller.dart';
import 'package:play_nuvem/src/features/home/home_state.dart';
import 'package:play_nuvem/src/features/home/services/home_service.dart';
import 'package:play_nuvem/src/repositories/tmdb/tmdb_repository.dart';
import 'package:play_nuvem/src/services/http_client/dio_service_imp.dart';
import 'package:play_nuvem/src/services/http_client/http_client_service.dart';
import 'package:play_nuvem/src/shared/utils/app_url_tmdb.dart';
import 'package:play_nuvem/src/shared/widgets/category_widget.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final controller = HomeController(
    HomeService(
      tmdbRepository: TmdbRepository(
        httpClientService: DioServiceImp(
          BaseOptionsHttp(
            baseUrl: AppUrlTmdb.BASE_URL,
            headers: AppUrlTmdb.HEADERS,
            queryParameters: AppUrlTmdb.QUERY_PARAMETERS,
          ),
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(),
      body: ListenableBuilder(
        listenable: controller,
        builder: (context, child) {
          if (controller.state.status == HomeStatus.loading) {
          
            return const Center(child: CircularProgressIndicator());
          } else if (controller.state.status == HomeStatus.error) {
           
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Text('Ocorreu o seguinte error'),
              ),
            );
          } else if (controller.state.status == HomeStatus.success) {
            var listMedias = controller.state.categories;
          
            return RefreshIndicator(
              onRefresh: () => controller.fetch(),
              child: ListView.separated(
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 20,
                  bottom: 10,
                  right: 0,
                ),
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                separatorBuilder: (_, index) => const SizedBox(height: 10),
                itemCount: listMedias.length,
                itemBuilder: (_, index) => CategoryWidget(
                  titleGenre: listMedias[index].name,
                  medias: listMedias[index].medias ?? [],
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
