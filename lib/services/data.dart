class MovieOrSeries {
  String coverUrl;
  String title;
  String description;
  List<String> categories;
  int year;
  String length;
  String country;
  int seasons;
  List<String> cast;
  Map<String, String> director;

  MovieOrSeries({
    required this.coverUrl,
    required this.title,
    required this.description,
    required this.categories,
    required this.year,
    required this.length,
    required this.country,
    required this.seasons,
    required this.cast,
    required this.director});

}

final List<MovieOrSeries> mainList = [
  MovieOrSeries(
    coverUrl: 'assets/images/cobra_kai.jpg',
    title: 'frozen 2',
    categories: ['Animation', "Adventure", "Comedy"],
    year: 2019,
    country: 'USA',
    length: '1h 43min',
    description:
        'Anna, Elsa, Kristoff, Olaf and Sven leave Arendelle to travel to an ancient, autumn-bound forest of an enchanted land. They set out to find the origin of Elsa\'s powers in order to save their kingdom.',
    seasons: 0, cast: [], director: {},
  ),
  MovieOrSeries(
      coverUrl: 'assets/images/spiderman.jpg',
      title: 'money heist',
      categories: ["Action", "Crime", "Mystery"],
      year: 2017,
      country: 'USA',
      length: '1h 10min',
      description:
          'An unusual group of robbers attempt to carry out the most perfect robbery in Spanish history - stealing 2.4 billion euros from the Royal Mint of Spain.',
      seasons: 5,
      cast: [
        'assets/images/spiderman_0.jpg',
        'assets/images/spiderman_1.jpg',
        'assets/images/spiderman_2.jpg',
      ],
      director: {
        'name': 'Alex Pina',
        'details':
            'Álex Pina is a Spanish television producer, writer, series creator and director, known for the crime drama La Casa de Papel. Previous shows include Vis a Vis, El embarcadero and Los hombres de Paco.',
      }),
  MovieOrSeries(
      coverUrl: 'assets/images/daredevil.jpg',
      title: 'modern family',
      categories: ["Comedy", "Drama", "Romance"],
      year: 2009,
      country: 'USA',
      length: '22min',
      description:
          "Three different but related families face trials and tribulations in their own uniquely comedic ways.",
      seasons: 11, cast: [], director: {},)
];

final List<MovieOrSeries> continueWatching = [
  MovieOrSeries(
    coverUrl: 'assets/images/endgame.jpg',
    title: 'stranger things',
    categories: ["Drama", "Fantasy", "Horror"],
    year: 2016,
    country: 'USA',
    length: '51min',
    description:
        'When a young boy disappears, his mother, a police chief and his friends must confront terrifying supernatural forces in order to get him back.',
    seasons: 4,
    cast: [], director: {},
  ),
  MovieOrSeries(
    coverUrl: 'assets/images/erased.jpg',
    title: 'disenchantment',
    categories: ["Animation", "Action", "Adventure"],
    year: 2018,
    country: 'USA',
    length: '30min',
    description:
        'Princess Tiabeanie, \'Bean\', is annoyed at her imminent arranged marriage to Prince Merkimer. Then she meets Luci, a demon, and Elfo, an elf, and things get rather exciting, and dangerous.',
    seasons: 4,
    cast: [], director: {},
  ),
  MovieOrSeries(
    coverUrl: 'assets/images/nutcracker.jpg',
    title: '13 reasons why',
    categories: ["Drama", "Mystery"],
    year: 2017,
    country: 'USA',
    length: '1hr',
    description:
        'Follows teenager Clay Jensen, in his quest to uncover the story behind his classmate and crush, Hannah, and her decision to end her life.',
    seasons: 4,
    cast: [], director: {},
  ),
  MovieOrSeries(
    coverUrl: 'assets/images/oitnb.jpg',
    title: 'sherlock',
    categories: ["Crime", "Drama", "Mystery"],
    year: 2010,
    country: 'USA',
    length: '1h 28min',
    description:
        'A modern update finds the famous sleuth and his doctor partner solving crime in 21st century London.',
    seasons: 4,
cast: [], director: {},
  ),
  MovieOrSeries(
    coverUrl: 'assets/images/plastic_memories.png',
    title: 'breaking bad',
    categories: ["Crime", "Drama", "Thriller"],
    year: 2008,
    country: 'USA',
    length: '49min',
    description:
        'A high school chemistry teacher diagnosed with inoperable lung cancer turns to manufacturing and selling methamphetamine in order to secure his family\'s future.',
    seasons: 0,
    cast: [], director: {},
  ),
];

final List<MovieOrSeries> myList = [
  MovieOrSeries(
    coverUrl: 'assets/images/seven_deadly_sins.jpg',
    title: 'house of cards',
    categories: ['Drama'],
    year: 2013,
    country: 'USA',
    length: '51min',
    description:
        'A Congressman works with his equally conniving wife to exact revenge on the people who betrayed him.',
    seasons: 6,
    cast: [], director: {},
  ),
  MovieOrSeries(
    coverUrl: 'assets/images/shigatsu_wa_kimi_no_uso.jpg',
    title: 'sara\'s notebook',
    categories: ["Adventure", "Drama", "Mystery"],
    year: 2018,
    country: 'SPAIN',
    length: '1h 55min',
    description:
        'A Spanish woman travels to darkest heart of Africa looking for her long-time missed younger sister.',
    seasons: 0,
    cast: [], director: {},
  ),
  MovieOrSeries(
    coverUrl: 'assets/images/stranger_things.jpg',
    title: 'stranger things',
    categories: ["Drama", "Fantasy", "Horror"],
    year: 2016,
    country: 'USA',
    length: '51min',
    description:
        'When a young boy disappears, his mother, a police chief and his friends must confront terrifying supernatural forces in order to get him back.',
    seasons: 4,
    cast: [], director: {},
  ),
  MovieOrSeries(
    coverUrl: 'assets/images/toystory.jpg',
    title: 'sherlock',
    categories: ["Crime", "Drama", "Mystery"],
    year: 2010,
    country: 'USA',
    length: '1h 28min',
    description:
        'A modern update finds the famous sleuth and his doctor partner solving crime in 21st century London.',
    seasons: 4,
    cast: [], director: {},
  ),
  MovieOrSeries(
    coverUrl: 'assets/images/nutcracker_0.jpg',
    title: 'fight club',
    categories: ["Drama"],
    year: 1999,
    country: 'USA',
    length: '2h 19min',
    description:
        'An insomniac office worker and a devil-may-care soapmaker form an underground fight club that evolves into something much, much more.',
    seasons: 0,
    cast: [], director: {},
  ),
  MovieOrSeries(
    coverUrl: 'assets/images/bg0.jpg',
    title: 'john wick 1',
    categories: ["Action", "Crime", "Thriller"],
    year: 2014,
    country: 'USA',
    length: '1h 41min',
    description:
        'An ex-hit-man comes out of retirement to track down the gangsters that killed his dog and took everything from him.',
    seasons: 0,
    cast: [], director: {},
  ),
  MovieOrSeries(
    coverUrl: 'assets/images/endgame.jpg',
    title: 'john wick 1',
    categories: ["Action", "Crime", "Thriller"],
    year: 2014,
    country: 'USA',
    length: '1h 41min',
    description:
        'An ex-hit-man comes out of retirement to track down the gangsters that killed his dog and took everything from him.',
    seasons: 0,
    cast: [], director: {},
  ),
];

final List<MovieOrSeries> categoryList = [
  MovieOrSeries(
    coverUrl: 'assets/images/endgame.jpg',
    title: 'Histoire',
    categories: [],
    year: 0,
    country: '',
    length: '',
    description:'',
    seasons: 0,
    cast: [], director: {},
  ),
  MovieOrSeries(
    coverUrl: 'assets/images/oitnb.jpg',
    title: 'Poésie',
    categories: [],
    year: 0,
    country: '',
    length: '',
    description:'',
    seasons: 0,
    cast: [], director: {},
  ),
  MovieOrSeries(
    coverUrl: 'assets/images/nutcracker.jpg',
    title: 'Politique',
    categories: [],
    year: 0,
    country: '',
    length: '',
    description:'',
    seasons: 0,
    cast: [], director: {},
  ),
  MovieOrSeries(
    coverUrl: 'assets/images/erased.jpg',
    title: 'Société',
    categories: [],
    year: 0,
    country: '',
    length: '',
    description:'',
    seasons: 0,
    cast: [], director: {},
  ),

];
