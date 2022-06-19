import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter/material.dart';

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

const List bookList = [
  {
    "img": "assets/images/midnightsun.jpg",
    "title": "Under the Midnight Sun",
    "genre": "Mystery",
    "author": "Keigo Higashino",
    "description":
        "When a man is found murdered in an abandoned building in Osaka in 1973, unflappable detective Sasagaki is assigned to the case. He begins to piece together the connection of two young people who are inextricably linked to the crime; the dark, taciturn son of the victim and the unexpectedly captivating daughter of the main suspect. Over the next twenty years we follow their lives as Sasagaki pursues the case - which remains unsolved - to the point of obsession.",
    "epub": "assets/epub/pachinko.epub",
    "icon": FontAwesome.hourglass_o,
    "status": "Completed",
    "views": "100,000",
    "tier": 0,
    "tags": ["Cultural", "Thriller", "Japan", "Detective", "Crime"]
  },
  {
    "img": "assets/images/pachinko.jpg",
    "title": "Pachinko",
    "genre": "Historical Fiction",
    "author": "Lee Min-jin",
    "description":
        "In the early 1900s, teenaged Sunja, the adored daughter of a crippled fisherman, falls for a wealthy stranger at the seashore near her home in Korea. He promises her the world, but when she discovers she is pregnant — and that her lover is married — she refuses to be bought. Instead, she accepts an offer of marriage from a gentle, sickly minister passing through on his way to Japan. But her decision to abandon her home, and to reject her son's powerful father, sets off a dramatic saga that will echo down through the generations.",
    "epub": "assets/epub/pachinko.epub",
    "icon": AntDesign.star,
    "status": "Completed",
    "views": "100,000",
    "tier": 2,
    "tags": ["Japan", "Historical Fiction", "Adult", "Literature"]
  },
  {
    "img": "assets/images/braidingsweetgrass.jpg",
    "title":
        "Braiding Sweetgrass: Indigenous Wisdom, Scientific Knowledge, and the Teachings of Plantsbrain",
    "genre": "Non-fiction",
    "author": "Robin Wall Kimmerer",
    "description":
        "As a botanist, Robin Wall Kimmerer has been trained to ask questions of nature with the tools of science. As a member of the Citizen Potawatomi Nation, she embraces the notion that plants and animals are our oldest teachers. In Braiding Sweetgrass, Kimmerer brings these lenses of knowledge together to show that the awakening of a wider ecological consciousness requires the acknowledgment and celebration of our reciprocal relationship with the rest of the living world. For only when we can hear the languages of other beings are we capable of understanding the generosity of the earth, and learning to give our own gifts in return.",
    "epub": "assets/epub/pachinko.epub",
    "icon": AntDesign.star,
    "status": "Completed",
    "views": "100,000",
    "tier": 3,
    "tags": [
      "Science",
      "Environment",
      "Nature",
      "Memoir",
      "Essays",
      "Spirituality",
      "Biology",
      "Ecology"
    ],
  },
  {
    "img": "assets/images/endswithus.jpg",
    "title": "It Ends with Us",
    "genre": "Romance",
    "author": "Colleen Hoover",
    "description":
        "Lily hasn’t always had it easy, but that’s never stopped her from working hard for the life she wants. She’s come a long way from the small town in Maine where she grew up — she graduated from college, moved to Boston, and started her own business. So when she feels a spark with a gorgeous neurosurgeon named Ryle Kincaid, everything in Lily’s life suddenly seems almost too good to be true.",
    "epub": "assets/epub/pachinko.epub",
    "icon": FontAwesome.dollar,
    "status": "Completed",
    "views": "100,000",
    "tier": 4,
    "tags": [
      "Romance",
      "Contemporary",
      "Sociology",
      "Women's Lit",
      "Young Adult"
    ],
  },
  {
    "img": "assets/images/narnia.jpg",
    "title": "The Lion, the Witch, and the Wardrobe",
    "genre": "Fantasy",
    "author": "C.S. Lewis",
    "description":
        "Narnia… the land beyond the wardrobe door, a secret place frozen in eternal winter, a magical country waiting to be set free.\n\nLucy is the first to find the secret of the wardrobe in the professor's mysterious old house. At first her brothers and sister don't believe her when she tells of her visit to the land of Narnia. But soon Edmund, then Peter and Susan step through the wardrobe themselves. In Narnia they find a country buried under the evil enchantment of the White Witch. When they meet the Lion Aslan, they realize they've been called to a great adventure and bravely join the battle to free Narnia from the Witch's sinister spell.",
    "epub": "assets/epub/pachinko.epub",
    "icon": FontAwesome.hourglass_o,
    "status": "Completed",
    "views": "80,000",
    "tier": 0,
    "tags": ["Fantasy", "Classics", "Childrens", "Christian", "Magic"],
  },
  {
    "img": "assets/images/hitchhiker.jpg",
    "title": "The Hitchhiker's Guide to the Galaxy",
    "genre": "Sci-fi",
    "author": "Douglas Adams",
    "epub": "assets/epub/pachinko.epub",
    "status": "Completed",
    "views": "100,000",
    "tags": ["Humor", "Classics", "Fantasy", "Science Fiction"],
  },
  {
    "img": "assets/images/housel.jpg",
    "title": "Think Outside the Box",
    "genre": "Non-fiction",
    "author": "Author",
    "epub": "assets/epub/pachinko.epub",
    "status": "Completed",
    "views": "100,000",
    "tags": [""],
  },
  {
    "id": 5,
    "img": "assets/images/morethanwords.jpg",
    "title": "more than words",
    "genre": "Romance",
    "author": "Jill Santopolo",
    "description":
        "From the New York Times bestselling author of The Light We Lost comes a tender and moving new novel about a woman at a crossroads after the death of her father, and caught between the love of two men.\n\nNina Gregory has always been a good daughter, a good girlfriend. Raised by her father, owner of New York City's glamorous Gregory Hotels, after her mother's death, Nina was taught that family, reputation, and legacy are what matter most. And her boyfriend Tim, thoughtful, kind, and honest, not to mention her best friend since childhood, feels the same. But after Nina's father passes away, she learns he may not have practiced what he preached.\n\n\nAs her world falls apart, Nina begins to question everything she thought she knew and to see the men in her life--her father, her boyfriend, and unexpectedly, her handsome and attentive boss, Rafael--in a new light. Soon Nina finds herself caught between the world she knows and loves, and a passion that could upend everything.\n\n\nMore than Words is a heartbreaking and romantic novel about grief, loss, love, and self-discovery, and how we choose which life we are meant to live.",
    "epub": "assets/epub/pachinko.epub",
    "icon": FontAwesome.hourglass_o,
    "status": "Completed",
    "views": "80,000",
    "tier": 0,
    "tags": [
      "Women's Fiction",
      "New York",
      "Romance",
    ],
  },
  {
    "id": 6,
    "img": "assets/images/loveunscripted.jpg",
    "title": "Love, Unscripted",
    "genre": "Romance",
    "author": "Owen Nicholls",
    "description":
        "A film-obsessed romantic rewrites the script to understand why his picture-perfect love story crashed and burned in this wonderfully clever debut.\n\nEllie had the quizzical eyebrows of Broadcast News-era Holly Hunter and the neon-red hair of Kate Winslet in Eternal Sunshine of the Spotless Mind. At least, that's what caught Nick's attention when he met her on the night of 2008's historic election. A cinema devotee and lover of great love stories, Nick always fancied himself the Tom Hanks of his own romantic comedy, and when sparks flew with Ellie that night, he swiftly cast her as the Meg Ryan of his story. For four blissful years, Nick loved Ellie as much as he loved his job as a film projectionist: wholly, earnestly, cinematically.\n\n\nBut now Ellie has moved out, convinced the fire's gone, and Nick is forced to sift through his memories to figure out where it all went wrong. The fallout from Ellie's declaration that she doesn't love Nick the way she used to throws him back into recollections of their first night together. Their shared jokes, her wry smile, the hope that filled the night air--his memories are as rose-colored as the Hollywood love stories he idealizes.\n\nThat night was a perfect meet-cute, yes, but was their romance as destined for a happily ever after as he'd thought? Is he really the rom-com hero he believes he's been? Or did this Harry let his Sally down? Peppered with references to beloved movies, Love, Unscripted explores how even a hopeless romantic can learn that in real life, love isn't, and shouldn't be, like what we see in the movies.",
    "epub": "assets/epub/pachinko.epub",
    "icon": FontAwesome.hourglass_o,
    "status": "Completed",
    "views": "80,000",
    "tier": 0,
    "tags": [
      "Romance",
      "Contemporary",
      "Sociology",
      "Women's Lit",
      "Young Adult"
    ],
  },
  {
    "id": 7,
    "img": "assets/images/dune.jpg",
    "title": "Dune",
    "genre": "Sci-fi",
    "author": "Frank Herbert",
    "description":
        "Set on the desert planet Arrakis, Dune is the story of the boy Paul Atreides, heir to a noble family tasked with ruling an inhospitable world where the only thing of value is the “spice” melange, a drug capable of extending life and enhancing consciousness. Coveted across the known universe, melange is a prize worth killing for...\n\nWhen House Atreides is betrayed, the destruction of Paul’s family will set the boy on a journey toward a destiny greater than he could ever have imagined. And as he evolves into the mysterious man known as Muad’Dib, he will bring to fruition humankind’s most ancient and unattainable dream.",
    "epub": "assets/epub/pachinko.epub",
    "icon": FontAwesome.hourglass_o,
    "status": "Completed",
    "views": "80,000",
    "tier": 0,
    "tags": ["Science Fiction Fantasy", "Space Opera", "Classics", "Adult"],
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

const List<Map<String, dynamic>> genreList = [
  {
    "id": 0,
    "icon": MaterialCommunityIcons.sword,
    "genre": "PxP Picks",
  },
  {
    "id": 1,
    "icon": MaterialCommunityIcons.target,
    "genre": "Action",
  },
  {
    "id": 2,
    "icon": MaterialCommunityIcons.sword,
    "genre": "Adventure",
  },
  {
    "id": 3,
    "icon": MaterialCommunityIcons.drama_masks,
    "genre": "Comedy",
  },
  {
    "id": 4,
    "icon": MaterialCommunityIcons.drama_masks,
    "genre": "Contemporary Lit",
  },
  {
    "id": 5,
    "icon": FontAwesome.magic,
    "genre": "Fan-fiction",
  },
  {
    "id": 6,
    "icon": FontAwesome.magic,
    "genre": "Fantasy",
  },
  {
    "id": 7,
    "icon": MaterialCommunityIcons.target,
    "genre": "Historical Fiction",
  },
  {
    "id": 8,
    "icon": MaterialCommunityIcons.target,
    "genre": "Horror",
  },
  {
    "id": 9,
    "icon": FontAwesome.search,
    "genre": "Mystery",
  },
  {
    "id": 10,
    "icon": FontAwesome.search,
    "genre": "New Adult",
  },
  {
    "id": 11,
    "icon": Entypo.open_book,
    "genre": "Non-fiction",
  },
  {
    "id": 12,
    "icon": FontAwesome.search,
    "genre": "Paranormal",
  },
  {
    "id": 13,
    "icon": MaterialCommunityIcons.heart_multiple_outline,
    "genre": "Romance",
  },
  {
    "id": 14,
    "icon": MaterialCommunityIcons.space_invaders,
    "genre": "Sci-fi",
  },
  {
    "id": 15,
    "icon": Entypo.open_book,
    "genre": "Thriller",
  },
];
