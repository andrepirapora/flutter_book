class Book {
  const Book({
    required this.title,
    required this.author,
    required this.image,
  });
  final String title;
  final String author;
  final String image;
}

const _bookAppAsset = 'assets/book_concept';
const bookAppBackground = '$_bookAppAsset/background.png';

const books = [
  Book(
    title: 'Wink Poppy Midnight',
    author: 'April Genevieve Tucholke',
    image: '$_bookAppAsset/book1.jpg',
  ),
  Book(
    title: 'Walking with Miss Millie',
    author: 'Tamara Bundy',
    image: '$_bookAppAsset/book2.jpg',
  ),
  Book(
    title: 'Trio',
    author: 'Sarah Tolmie',
    image: '$_bookAppAsset/book3.jpg',
  ),
  Book(
    title: 'The Junble Book',
    author: 'Rudyard Kipling',
    image: '$_bookAppAsset/book4.jpg',
  ),
  Book(
    title: 'The Maker of Swans',
    author: 'Paraig O\'Donnell',
    image: '$_bookAppAsset/book5.jpg',
  ),
];
