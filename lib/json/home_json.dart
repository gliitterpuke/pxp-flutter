import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter/material.dart';

class tierColor {
  static const Color bronze = Color(0xFFCD7F32);
  static const Color silver = Color(0xFFC0C0C0);
  static const Color gold = Color(0xFFFFD700);
  static const Color paid = Color(0xFF818181);
}

const List authorList = [
  {
    "img": "assets/images/loid.jpg",
    "author": "Loid Forger",
    "series": "2",
    "followers": "11,231",
    "notification": "yes"
  },
  {
    "img": "assets/images/gintoki.webp",
    "author": "Gin-chan",
    "series": "1",
    "followers": "512",
    "notification": "no"
  },
  {
    "img": "assets/images/flyanya.jpg",
    "author": "Anya Forger",
    "series": "1",
    "followers": "52",
    "notification": "no"
  },
  {
    "img": "assets/images/san.jpg",
    "author": "San",
    "series": "321",
    "followers": "1,342",
    "notification": "yes"
  },
  {
    "img": "assets/images/drunkyor.jpg",
    "author": "Yor Forger",
    "series": "1",
    "followers": "2,468",
    "notification": "no"
  },
];

const List pxppicks = [
  {
    "img": "assets/images/midnightsun.jpg",
    "title": "Under the Midnight Sun",
    "genre": "Mystery",
    "description":
        "When a man is found murdered in an abandoned building in Osaka in 1973, unflappable detective Sasagaki is assigned to the case. He begins to piece together the connection of two young people who are inextricably linked to the crime; the dark, taciturn son of the victim and the unexpectedly captivating daughter of the main suspect. Over the next twenty years we follow their lives as Sasagaki pursues the case - which remains unsolved - to the point of obsession.",
    "icon": FontAwesome.heart,
    "tier": "",
  },
  {
    "img": "assets/images/pachinko.jpg",
    "title": "Pachinko",
    "genre": "Historical Fiction",
    "author": "Lee Min-jin",
    "description":
        "In the early 1900s, teenaged Sunja, the adored daughter of a crippled fisherman, falls for a wealthy stranger at the seashore near her home in Korea. He promises her the world, but when she discovers she is pregnant — and that her lover is married — she refuses to be bought. Instead, she accepts an offer of marriage from a gentle, sickly minister passing through on his way to Japan. But her decision to abandon her home, and to reject her son's powerful father, sets off a dramatic saga that will echo down through the generations.",
    "icon": AntDesign.star,
    "tier": 2,
  },
  {
    "img": "assets/images/endswithus.jpg",
    "title": "It Ends with Us",
    "genre": "Romance",
    "author": "Colleen Hoover",
    "description":
        "Lily hasn’t always had it easy, but that’s never stopped her from working hard for the life she wants. She’s come a long way from the small town in Maine where she grew up — she graduated from college, moved to Boston, and started her own business. So when she feels a spark with a gorgeous neurosurgeon named Ryle Kincaid, everything in Lily’s life suddenly seems almost too good to be true.",
    "icon": FontAwesome.dollar,
    "tier": 4,
  },
  {
    "img": "assets/images/braidingsweetgrass.jpg",
    "title":
        "Braiding Sweetgrass: Indigenous Wisdom, Scientific Knowledge, and the Teachings of Plantsbrain",
    "genre": "Non-fiction",
    "author": "Robin Wall Kimmerer",
    "description":
        "As a botanist, Robin Wall Kimmerer has been trained to ask questions of nature with the tools of science. As a member of the Citizen Potawatomi Nation, she embraces the notion that plants and animals are our oldest teachers. In Braiding Sweetgrass, Kimmerer brings these lenses of knowledge together to show that the awakening of a wider ecological consciousness requires the acknowledgment and celebration of our reciprocal relationship with the rest of the living world. For only when we can hear the languages of other beings are we capable of understanding the generosity of the earth, and learning to give our own gifts in return.",
    "icon": AntDesign.star,
    "tier": 3,
  },
];

const List mylist = [
  {
    "img": "assets/images/nonfiction.png",
    "title": "Think Outside the Box",
    "genre": "Non-fiction",
    "author": "Author"
  },
  {
    "img": "assets/images/narnia.jpg",
    "title": "The Lion, the Wtich, and the Wardrobe",
    "genre": "Fantasy",
    "author": "C.S. Lewis"
  },
  {
    "img": "assets/images/none.jpg",
    "title": "And Then There Were None",
    "genre": "Mystery",
    "author": "Agatha Christie"
  },
  {
    "img": "assets/images/primarythreat.jpg",
    "title": "Primary Threat",
    "genre": "Action",
    "author": "Jack Mars"
  },
];

const List trendingList = [
  {
    "img": "assets/images/morethanwords.jpg",
    "title": "more than words",
    "genre": "Romance",
    "author": "Jill Santopolo"
  },
  {
    "img": "assets/images/loveunscripted.jpg",
    "title": "Love, Unscripted",
    "genre": "Romance",
    "author": "Owen Nicholls"
  },
  {
    "img": "assets/images/dune.jpg",
    "title": "Dune",
    "genre": "Sci-fi",
    "author": "Frank Herbert"
  },
];

const List newList = [
  {
    "img": "assets/images/hitchhiker.jpg",
    "title": "The Hitchhiker's Guide to the Galaxy",
    "genre": "Sci-fi",
    "author": "Douglas Adams"
  },
  {
    "img": "assets/images/housel.jpg",
    "title": "Think Outisde the Box",
    "genre": "Non-fiction",
    "author": "Author"
  },
  {
    "img": "assets/images/motivate.jpg",
    "title": "Think Outisde the Box",
    "genre": "Non-fiction",
    "author": "Author"
  },
];

const List completedList = [
  {
    "img": "assets/images/scifi.png",
    "title": "Think Outisde the Box",
    "genre": "Non-fiction",
    "author": "Author"
  },
  {
    "img": "assets/images/sky.jpg",
    "title": "Think Outisde the Box",
    "genre": "Non-fiction",
    "author": "Author"
  },
  {
    "img": "assets/images/storytelling.jpg",
    "title": "Think Outisde the Box",
    "genre": "Non-fiction",
    "author": "Author"
  },
];

const List genreList = [
  {
    "icon": MaterialCommunityIcons.space_invaders,
    "genre": "Sci-fi",
  },
  {
    "icon": MaterialCommunityIcons.heart_multiple_outline,
    "genre": "Romance",
  },
  {
    "icon": FontAwesome.magic,
    "genre": "Fantasy",
  },
  {
    "icon": MaterialCommunityIcons.sword,
    "genre": "Adventure",
  },
  {
    "icon": FontAwesome.search,
    "genre": "Mystery",
  },
  {
    "icon": MaterialCommunityIcons.drama_masks,
    "genre": "Comedy",
  },
  {
    "icon": MaterialCommunityIcons.target,
    "genre": "Action",
  },
  {
    "icon": Entypo.open_book,
    "genre": "Non-fiction",
  },
];
