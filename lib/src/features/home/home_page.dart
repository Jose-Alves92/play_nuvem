// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:play_nuvem/src/features/home/home_controller.dart';
import 'package:play_nuvem/src/features/home/home_state.dart';
import 'package:play_nuvem/src/features/home/widgets/trendingSlider.dart';
import 'package:play_nuvem/src/shared/locator/locator_services.dart';
import 'package:play_nuvem/src/shared/ui/styles/app_colors.dart';
import 'package:play_nuvem/src/shared/ui/styles/app_text_style.dart';
import 'package:play_nuvem/src/shared/utils/app_routes.dart';
import 'package:play_nuvem/src/shared/widgets/category_widget.dart';

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
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: AppColors.primaryColor),
              child: Text('Drawer'),
            ),
            ListTile(
              leading: const Icon(Icons.movie),
              title: const Text('Playlist'),
              onTap: () =>
                  Navigator.popAndPushNamed(context, AppRoutes.PLAYLIST_PAGE),
            )
          ],
        ),
      ),
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
