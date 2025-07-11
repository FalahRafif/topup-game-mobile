import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:topup_mobile/constants.dart';
import '../../shared/customer/bottom_nav.dart';
import '../../shared/customer/apppbar.dart';
import 'detailProduct.dart';

class ListProductScreen extends StatefulWidget {
  const ListProductScreen({super.key});

  @override
  State<ListProductScreen> createState() => _ListProductScreenState();
}

class _ListProductScreenState extends State<ListProductScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool showNewestFirst = true;
  bool showCheapestFirst = false;

  RangeValues priceRange = const RangeValues(0, 1000000);
  Map<String, bool> categories = {
    'Console Game': false,
    'Moblie Game': false,
    'PC Game': false,
    'Playstation Game': false,
    'Xbox Game': false,
    'Nitendo Game': false,
  };

  void openFilterDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  void toggleSort(String type) {
    setState(() {
      if (type == 'newest') {
        showNewestFirst = !showNewestFirst;
      } else if (type == 'cheapest') {
        showCheapestFirst = !showCheapestFirst;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      drawer: Drawer(
        backgroundColor: kPrimaryLightColor,
        width: MediaQuery.of(context).size.width * 0.8,
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Text('Filter Produk', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              const Text('Kategori Game', style: TextStyle(fontWeight: FontWeight.w600)),
              ...categories.keys.map((key) {
                return CheckboxListTile(
                  title: Text(key),
                  value: categories[key],
                  onChanged: (value) {
                    setState(() {
                      categories[key] = value ?? false;
                    });
                  },
                );
              }).toList(),
              const Divider(),
              const Text('Harga', style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Min',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Max',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close drawer
                  // Apply filters here
                },
                child: const Text('Terapkan Filter'),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              const HomeHeader(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: openFilterDrawer,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: const [
                            Icon(Icons.filter_list),
                            SizedBox(width: 6),
                            Text('Filter'),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () => toggleSort('newest'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            const Text('Terbaru'),
                            Icon(showNewestFirst ? Icons.arrow_drop_up : Icons.arrow_drop_down),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () => toggleSort('cheapest'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            const Text('Termurah'),
                            Icon(showCheapestFirst ? Icons.arrow_drop_down : Icons.arrow_drop_up),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const AllProducts(), // Tetap gunakan komponen lama
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomerNavbar(selectedIndex: 1),
    );
  }
}

class AllProducts extends StatelessWidget {
  const AllProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: demoProducts.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 20,
          childAspectRatio: 0.7,
        ),
        itemBuilder: (context, index) {
          return ProductCard(
            product: demoProducts[index],
            onPress: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context) => ProductDetailsScreen(),
              ));
            },
          );
        },
      ),
    );
  }
}















class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    this.width = 140,
    this.aspectRetio = 1.02,
    required this.product,
    required this.onPress,
  }) : super(key: key);

  final double width, aspectRetio;
  final Product product;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: GestureDetector(
        onTap: onPress,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1.02,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  product.images[0],
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              product.title,
              style: Theme.of(context).textTheme.bodyMedium,
              maxLines: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Text(
                //   "\$${product.price}",
                //   style: const TextStyle(
                //     fontSize: 14,
                //     fontWeight: FontWeight.w600,
                //     color: Color(0xFFFF7643),
                //   ),
                // ),
                InkWell(
                  borderRadius: BorderRadius.circular(50),
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    height: 24,
                    width: 24,
                    decoration: BoxDecoration(
                      color: product.isFavourite
                          ? const Color(0xFFFF7643).withOpacity(0.15)
                          : const Color(0xFF979797).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.string(
                      heartIcon,
                      colorFilter: ColorFilter.mode(
                          product.isFavourite
                              ? const Color(0xFFFF4848)
                              : const Color(0xFFDBDEE4),
                          BlendMode.srcIn),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class Product {
  final int id;
  final String title, description;
  final List<String> images;
  final List<Color> colors;
  final double rating, price;
  final bool isFavourite, isPopular;

  Product({
    required this.id,
    required this.images,
    required this.colors,
    this.rating = 0.0,
    this.isFavourite = false,
    this.isPopular = false,
    required this.title,
    required this.price,
    required this.description,
  });
}

// Our demo Products
List<Product> demoProducts = [
  Product(
    id: 1,
    images: ['assets/images/product/genshin.jpg'],
    colors: [Color(0xFFF6625E), Color(0xFF836DB8), Color(0xFFDECB9C), Colors.white],
    title: "Genshin Impact",
    price: 29.99,
    description: description,
    rating: 4.8,
    isPopular: true,
    isFavourite: true,
  ),
  Product(
    id: 2,
    images: ['assets/images/product/1571814027-icon-1559011491-icon-1557743544-icon-point_blank.jpg'],
    colors: [Color(0xFFF6625E), Color(0xFF836DB8), Color(0xFFDECB9C), Colors.white],
    title: "Point Blank",
    price: 24.99,
    description: description,
    rating: 4.1,
    isFavourite: true,
  ),
  Product(
    id: 3,
    images: ['assets/images/product/1633599388-icon-Icon_1024.jpg'],
    colors: [Color(0xFFF6625E), Color(0xFF836DB8), Color(0xFFDECB9C), Colors.white],
    title: "Call of Duty",
    price: 29.99,
    description: description,
    rating: 4.2,
    isPopular: true,
  ),
  Product(
    id: 6,
    images: ['assets/images/product/1658817763-icon-200x200_icon ff.jpg'],
    colors: [Color(0xFFF6625E), Color(0xFF836DB8), Color(0xFFDECB9C), Colors.white],
    title: "Free Fire",
    price: 23.99,
    description: description,
    rating: 4.3,
    isPopular: true,
  ),
  Product(
    id: 7,
    images: ['assets/images/product/1735814979-icon-Image_20250102184102_ML.jpg'],
    colors: [Color(0xFFF6625E), Color(0xFF836DB8), Color(0xFFDECB9C), Colors.white],
    title: "Mobile Legends",
    price: 25.99,
    description: description,
    rating: 4.4,
    isFavourite: true,
  ),
  Product(
    id: 8,
    images: ['assets/images/product/AOV-tile-codacash-new.jpg'],
    colors: [Color(0xFFF6625E), Color(0xFF836DB8), Color(0xFFDECB9C), Colors.white],
    title: "AOV Codacash",
    price: 27.99,
    description: description,
    rating: 4.0,
  ),

  Product(
    id: 11,
    images: ['assets/images/product/hago-tile-codacash-new.jpg'],
    colors: [Color(0xFFF6625E), Color(0xFF836DB8), Color(0xFFDECB9C), Colors.white],
    title: "Hago Codacash",
    price: 18.99,
    description: description,
    rating: 4.0,
  ),
  Product(
    id: 12,
    images: ['assets/images/product/MCGG.jpg'],
    colors: [Color(0xFFF6625E), Color(0xFF836DB8), Color(0xFFDECB9C), Colors.white],
    title: "MCGG",
    price: 19.99,
    description: description,
    rating: 4.2,
    isFavourite: true,
  ),
  Product(
    id: 13,
    images: ['assets/images/product/metal slug.jpg'],
    colors: [Color(0xFFF6625E), Color(0xFF836DB8), Color(0xFFDECB9C), Colors.white],
    title: "Metal Slug",
    price: 17.99,
    description: description,
    rating: 4.0,
  ),
  Product(
    id: 14,
    images: ['assets/images/product/omp_new.jpg'],
    colors: [Color(0xFFF6625E), Color(0xFF836DB8), Color(0xFFDECB9C), Colors.white],
    title: "OMP",
    price: 21.99,
    description: description,
    rating: 4.0,
  ),
  Product(
    id: 15,
    images: ['assets/images/product/pubgmobile_640x241.jpg'],
    colors: [Color(0xFFF6625E), Color(0xFF836DB8), Color(0xFFDECB9C), Colors.white],
    title: "PUBG Mobile",
    price: 28.99,
    description: description,
    rating: 4.3,
    isPopular: true,
  ),
  Product(
    id: 16,
    images: ['assets/images/product/supersus-tile-codacash-new.jpg'],
    colors: [Color(0xFFF6625E), Color(0xFF836DB8), Color(0xFFDECB9C), Colors.white],
    title: "Super Sus",
    price: 20.99,
    description: description,
    rating: 4.1,
  ),
  Product(
    id: 17,
    images: ['assets/images/product/valorant.jpg'],
    colors: [Color(0xFFF6625E), Color(0xFF836DB8), Color(0xFFDECB9C), Colors.white],
    title: "Valorant",
    price: 27.49,
    description: description,
    rating: 4.7,
    isFavourite: true,
    isPopular: true,
  ),
];



const heartIcon =
'''<svg width="18" height="16" viewBox="0 0 18 16" fill="none" xmlns="http://www.w3.org/2000/svg">
<path fill-rule="evenodd" clip-rule="evenodd" d="M16.5266 8.61383L9.27142 15.8877C9.12207 16.0374 8.87889 16.0374 8.72858 15.8877L1.47343 8.61383C0.523696 7.66069 0 6.39366 0 5.04505C0 3.69644 0.523696 2.42942 1.47343 1.47627C2.45572 0.492411 3.74438 0 5.03399 0C6.3236 0 7.61225 0.492411 8.59454 1.47627C8.81857 1.70088 9.18143 1.70088 9.40641 1.47627C11.3691 -0.491451 14.5629 -0.491451 16.5266 1.47627C17.4763 2.42846 18 3.69548 18 5.04505C18 6.39366 17.4763 7.66165 16.5266 8.61383Z" fill="#DBDEE4"/>
</svg>
''';

const String description =
    "Wireless Controller for PS4™ gives you what you want in your gaming from over precision control your games to sharing …";

const cartIcon =
'''<svg width="22" height="18" viewBox="0 0 22 18" fill="none" xmlns="http://www.w3.org/2000/svg">
<path fill-rule="evenodd" clip-rule="evenodd" d="M18.4524 16.6669C18.4524 17.403 17.8608 18 17.1302 18C16.3985 18 15.807 17.403 15.807 16.6669C15.807 15.9308 16.3985 15.3337 17.1302 15.3337C17.8608 15.3337 18.4524 15.9308 18.4524 16.6669ZM11.9556 16.6669C11.9556 17.403 11.3631 18 10.6324 18C9.90181 18 9.30921 17.403 9.30921 16.6669C9.30921 15.9308 9.90181 15.3337 10.6324 15.3337C11.3631 15.3337 11.9556 15.9308 11.9556 16.6669ZM20.7325 5.7508L18.9547 11.0865C18.6413 12.0275 17.7685 12.6591 16.7846 12.6591H10.512C9.53753 12.6591 8.66784 12.0369 8.34923 11.1095L6.30162 5.17154H20.3194C20.4616 5.17154 20.5903 5.23741 20.6733 5.35347C20.7563 5.47058 20.7771 5.61487 20.7325 5.7508ZM21.6831 4.62051C21.3697 4.18031 20.858 3.91682 20.3194 3.91682H5.86885L5.0002 1.40529C4.70961 0.564624 3.92087 0 3.03769 0H0.621652C0.278135 0 0 0.281266 0 0.62736C0 0.974499 0.278135 1.25472 0.621652 1.25472H3.03769C3.39158 1.25472 3.70812 1.48161 3.82435 1.8183L4.83311 4.73657C4.83622 4.74598 4.83934 4.75434 4.84245 4.76375L7.17339 11.5215C7.66531 12.9518 9.00721 13.9138 10.512 13.9138H16.7846C18.304 13.9138 19.6511 12.9383 20.1347 11.4859L21.9135 6.14917C22.0847 5.63369 21.9986 5.06175 21.6831 4.62051Z" fill="#7C7C7C"/>
</svg>
''';

const bellIcon =
'''<svg width="15" height="20" viewBox="0 0 15 20" fill="none" xmlns="http://www.w3.org/2000/svg">
<path fill-rule="evenodd" clip-rule="evenodd" d="M13.9645 15.8912C13.9645 16.1628 13.7495 16.3832 13.4844 16.3832H9.22765H9.21987H1.51477C1.2505 16.3832 1.03633 16.1628 1.03633 15.8912V10.7327C1.03633 7.08053 3.93546 4.10885 7.50043 4.10885C11.0645 4.10885 13.9645 7.08053 13.9645 10.7327V15.8912ZM7.50043 18.9381C6.77414 18.9381 6.18343 18.3327 6.18343 17.5885C6.18343 17.5398 6.18602 17.492 6.19034 17.4442H8.81052C8.81484 17.492 8.81743 17.5398 8.81743 17.5885C8.81743 18.3327 8.22586 18.9381 7.50043 18.9381ZM9.12488 3.2292C9.35805 2.89469 9.49537 2.48673 9.49537 2.04425C9.49537 0.915044 8.6024 0 7.50043 0C6.39847 0 5.5055 0.915044 5.5055 2.04425C5.5055 2.48673 5.64281 2.89469 5.87512 3.2292C2.51828 3.99204 0 7.06549 0 10.7327V15.8912C0 16.7478 0.679659 17.4442 1.51477 17.4442H5.15142C5.14883 17.492 5.1471 17.5398 5.1471 17.5885C5.1471 18.9186 6.20243 20 7.50043 20C8.79843 20 9.8529 18.9186 9.8529 17.5885C9.8529 17.5398 9.85117 17.492 9.84858 17.4442H13.4844C14.3203 17.4442 15 16.7478 15 15.8912V10.7327C15 7.06549 12.4826 3.99204 9.12488 3.2292Z" fill="#626262"/>
</svg>
''';
