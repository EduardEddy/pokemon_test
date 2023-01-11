import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pokeapi/src/provider/home/home_provider.dart';
import 'package:pokeapi/src/screen/detail/detail_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final urlImage =
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/dream-world/';
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/image/pokeapi_icon.png',
          width: 100,
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        height: double.infinity,
        child: ChangeNotifierProvider(
          create: (_) => HomeProvider(),
          child: Consumer<HomeProvider>(
            builder: (__, data, child) => SizedBox(
              child: ListView.builder(
                itemCount: data.pokemons.length,
                itemBuilder: (context, index) {
                  if (data.pokemons.isNotEmpty) {
                    final List _url =
                        data.pokemons[index]['url'].split('/pokemon/');
                    List item = _url[1].split('/');
                    final _id = item[0];
                    if (index == (data.pokemons.length - 1)) {
                      data.addNewData();
                      return const Center(child: CircularProgressIndicator());
                    }
                    return GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return DetailScreen(
                              url: '$urlImage$_id.svg',
                              name: data.pokemons[index]['name'],
                            );
                          },
                        ),
                      ),
                      child: _card(
                        size,
                        "$urlImage$_id.svg",
                        data.pokemons[index]['name'],
                      ),
                    );
                  }

                  return const CircularProgressIndicator();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _card(Size size, String image, String name) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: size.width * .05,
        vertical: size.height * .02,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), border: Border.all(width: 1)),
      width: size.width * .9,
      height: size.height * .25,
      child: Stack(
        children: [
          Hero(
            tag: image,
            child: SvgPicture.network(
              image,
              placeholderBuilder: (BuildContext context) => Container(
                padding: const EdgeInsets.all(30.0),
                child: const CircularProgressIndicator(),
              ),
            ),
          ),
          Positioned(
            right: 10,
            top: size.height * .05,
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}
