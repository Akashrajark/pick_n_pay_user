class Shop {
  final String name;
  final String description;
  final String imageUrl;

  Shop({
    required this.name,
    required this.description,
    required this.imageUrl,
  });
}

final List<Shop> dummyShops = [
  Shop(
    name: 'Secura Mall',
    description: 'Best quality products available here.',
    imageUrl: 'https://i.ytimg.com/vi/-sp8VHv-zkw/maxresdefault.jpg',
  ),
  Shop(
    name: 'Fresh Mart',
    description: 'Fresh fruits and vegetables daily.',
    imageUrl:
        'https://img.freepik.com/free-photo/man-working-hard-supermarket_329181-17356.jpg?t=st=1740823601~exp=1740827201~hmac=dc786d3582a67a096481beee77476d58d0cb742af1b504ca69517be339229497&w=1380',
  ),
  Shop(
    name: 'Tech Haven',
    description: 'Latest gadgets and electronics.',
    imageUrl:
        'https://img.freepik.com/premium-photo/client-choosing-laptop-store_461973-809.jpg?w=1380',
  ),
  Shop(
    name: 'Fashion Hub',
    description: 'Trendy clothes and accessories.',
    imageUrl:
        'https://img.freepik.com/free-photo/fashion-clothes_1203-8091.jpg',
  ),
  Shop(
    name: 'Book Nook',
    description: 'A wide range of books for all ages.',
    imageUrl: 'https://img.freepik.com/free-photo/stack-books_23-214784616.jpg',
  ),
  Shop(
    name: 'Home Essentials',
    description: 'Everything you need for your home.',
    imageUrl:
        'https://img.freepik.com/free-photo/home-appliances_23-2148218580.jpg',
  ),
];
