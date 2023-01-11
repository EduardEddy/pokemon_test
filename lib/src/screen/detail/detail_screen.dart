import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokeapi/src/provider/detail/detail_provider.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatelessWidget {
  final String url;
  final String name;
  const DetailScreen({super.key, required this.url, required this.name});

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
        elevation: 0,
      ),
      body: ChangeNotifierProvider(
        create: (_) => DetailProvider(name: name),
        child: Consumer<DetailProvider>(
          builder: (__, data, child) => SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.blue,
                        Colors.white,
                      ],
                    ),
                  ),
                  height: size.height * .50,
                  child: Center(
                    child: Hero(
                      tag: url,
                      child: SvgPicture.network(
                        url,
                        placeholderBuilder: (BuildContext context) => Container(
                          padding: const EdgeInsets.all(30.0),
                          child: const CircularProgressIndicator(),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      _descriptions('Nombre', name, size),
                      const SizedBox(height: 10),
                      const Divider(height: 2.0),
                      _descriptions('Peso', data.weight.toString(), size),
                      const SizedBox(height: 10),
                      const Divider(height: 2.0),
                      _descriptions('Abilidades', data.abilities, size),
                      const SizedBox(height: 10),
                      const Divider(height: 2.0),
                      _descriptions('Movimientos', data.moves, size),
                      const SizedBox(height: 10),
                      const Divider(height: 2.0),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _descriptions(String key, String val, Size size) {
    return Row(
      children: [
        SizedBox(
          width: size.width * .9,
          child: RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(
              text: '$key: ',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.black,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: val,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
