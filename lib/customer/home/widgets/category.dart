import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../product/listProduct.dart';


class GameCategories extends StatelessWidget {
  const GameCategories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SectionTitle(
            title: "Category Game",
            press: () {},
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              const SizedBox(width: 20), // padding kiri
              Column(
                children: [
                  Row(
                    children: [
                      GameCategoryCard(
                        image: "assets/images/category/img.png",
                        label: "Console Game",
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ListProductScreen(),
                            ),
                          );
                        },
                      ),
                      GameCategoryCard(
                        image: "assets/images/category/img_3.png",
                        label: "Mobile Game",
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ListProductScreen(),
                            ),
                          );
                        },
                      ),
                      GameCategoryCard(
                        image: "assets/images/category/img_4.png",
                        label: "PC Game",
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ListProductScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      GameCategoryCard(
                        image: "assets/images/category/img_1.png",
                        label: "Playstation Game",
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ListProductScreen(),
                            ),
                          );
                        },
                      ),
                      GameCategoryCard(
                        image: "assets/images/category/img_2.png",
                        label: "Xbox Game",
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ListProductScreen(),
                            ),
                          );
                        },
                      ),
                      GameCategoryCard(
                        image: "assets/images/category/img_5.png",
                        label: "Nintendo Game",
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ListProductScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(width: 20), // padding kanan
            ],
          ),
        ),
      ],
    );
  }
}

class GameCategoryCard extends StatelessWidget {
  const GameCategoryCard({
    Key? key,
    required this.image,
    required this.label,
    this.press,
  }) : super(key: key);

  final String image;
  final String label;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: GestureDetector(
        onTap: press ?? () {},
        child: SizedBox(
          width: 242,
          height: 100,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                Image.asset(
                  image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),

                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black54,
                        Colors.black38,
                        Colors.black26,
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  child: Text(
                    label,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key? key,
    required this.title,
    required this.press,
  }) : super(key: key);

  final String title;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ListProductScreen(),
              ),
            );
          },
          style: TextButton.styleFrom(foregroundColor: kPrimaryColor),
          child: const Text("See more"),
        ),
      ],
    );
  }
}
