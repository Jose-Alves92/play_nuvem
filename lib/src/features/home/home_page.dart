// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:play_nuvem/src/features/home/home_controller.dart';
import 'package:play_nuvem/src/features/home/home_state.dart';
import 'package:play_nuvem/src/features/home/widgets/trendingSlider.dart';
import 'package:play_nuvem/src/shared/locator/locator_services.dart';
import 'package:play_nuvem/src/shared/ui/styles/app_colors.dart';
import 'package:play_nuvem/src/shared/ui/styles/app_text_style.dart';
import 'package:play_nuvem/src/shared/ui/widgets/error_widget.dart';
import 'package:play_nuvem/src/shared/utils/app_routes.dart';
import 'package:play_nuvem/src/shared/ui/widgets/category_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = getIt.get<HomeController>();

  @override
  void initState() {
    super.initState();
    controller.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_rounded))
        ],
      ),
      drawer: Drawer(
        backgroundColor: AppColors.backgroundColor,
        child: Column(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: AppColors.primaryColor),
              child: Center(child: Text('PlayNuvem',style: AppTextStyle.titleMedium)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: ListTile(             
                  leading: const Icon(Icons.movie, color: Colors.orange,),
                  title: const Text('Lista de reprodução', maxLines: 2, overflow: TextOverflow.ellipsis,),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () =>
                      Navigator.popAndPushNamed(context, AppRoutes.PLAYLIST_PAGE),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: ListTile(             
                  leading: const Icon(Icons.favorite, color: Colors.red,),
                  title: const Text('Favoritos', maxLines: 2, overflow: TextOverflow.ellipsis,),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: (){},
                 ), 
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: ListTile(             
                  leading: const Icon(Icons.settings, color: Colors.blue,),
                  title: const Text('Configurações', maxLines: 2, overflow: TextOverflow.ellipsis,),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: (){},
                 ), 
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: ListTile(             
                  leading: const Icon(Icons.update_rounded, color: Colors.amber,),
                  title: const Text('Forçar atualização de dados', maxLines: 2, overflow: TextOverflow.ellipsis,),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: (){},
                 ), 
              ),
            ),
                        Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: ListTile(             
                  leading: Icon(Icons.policy, color: Colors.green.shade900),
                  title: const Text('Política de privacidade', maxLines: 2, overflow: TextOverflow.ellipsis,),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: (){},
                 ), 
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: ListTile(             
                  leading: const Icon(Icons.logout_outlined),
                  title: const Text('Sair', maxLines: 2, overflow: TextOverflow.ellipsis,),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: (){},
                 ), 
              ),
            ),
          ],
        ),
      ),
      body: ListenableBuilder(
        listenable: controller,
        builder: (context, child) {
          if (controller.state.status == HomeStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (controller.state.status == HomeStatus.error) {
            return const ErrorPageWidget();
          } else if (controller.state.status == HomeStatus.success) {
            var content = controller.state.homeContent!;

            return RefreshIndicator(
              onRefresh: () => controller.fetch(),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    const Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Text('Trending week',
                          style: AppTextStyle.titleMedium),
                    ),
                    const SizedBox(height: 10),
                    TrendingSlider(
                      medias: content.trending,
                    ),
                    const SizedBox(height: 20),
                    CategoryWidget(
                      title: 'Popular : filmes',
                      medias: content.popularMovie,
                    ),
                    const SizedBox(height: 20),
                    CategoryWidget(
                      title: 'Popular : series',
                      medias: content.popularTv,
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
