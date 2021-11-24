//@dart=2.9
class TourismModel {
  String countryName;
  String shortDescription;
  List<String> stateName;
  String countryImage;
  List<String> stateImage;
  List<String> description;
  List<String> package;
  List<String> priceStart;
  List<String> priceEnd;
  List<String> hotelPrice;
  List<String> date;
  List<String> hotelStar;
  List<String> hotelImage;
  List<String> hotelName;
  List<String> hotelRoom;

  TourismModel(
    this.countryName,
    this.shortDescription,
    this.stateName,
    this.countryImage,
    this.stateImage,
    this.package,
    this.description,
    this.priceStart,
    this.priceEnd,
    this.hotelPrice,
    this.date,
    this.hotelStar,
    this.hotelImage,
    this.hotelName,
    this.hotelRoom,
  );
}

List<TourismModel> tourism = tourismData
    .map((item) => TourismModel(
        item['countryName'],
        item['shortDescription'],
        item['stateName'],
        item['countryImage'],
        item['stateImage'],
        item['package'],
        item['description'],
        item['priceStart'],
        item['priceEnd'],
        item['hotelPrice'],
        item['date'],
        item['hotelStar'],
        item['hotelImage'],
        item['hotelName'],
        item['hotelRoom']))
    .toList();

var tourismData = [
  {
    "countryName": "Japan",
    "shortDescription": "Explore the land of the rising sun",
    "stateName": ["Kyoto", "Tokyo", "Sapporo", " Nagoya"],
    "countryImage": "Assets/images/japan.jpg",
    "stateImage": [
      "Assets/images/kyoto.jpg",
      "Assets/images/tokyo.jpg",
      "Assets/images/sapporo.jpg",
      "Assets/images/nagoya.jpg"
    ],
    "package": [
      "7 days 6 night",
      "3 days 2 night",
      "5 days 4 night",
      "5 days 4 night"
    ],
    "description": [
      "Kyoto was the official capital of Japan for over 1,000 years and remains one of the foremost destinations to experience traditional Japanese culture. The city has around 2,000 temples and shrines, including the “Golden Pavilion,” <@Kinkakuji|a:lj0009453@>, Ryoanji known for its zen rock garden, and Fushimi Inari Taisha, the shrine with a tunnel of 5,000 vermillion torii gates.",
      "Tokyo inarguably is Japan’s most well-known city. The Tokyo Metropolis is made up of 23 Special Wards, home to upwards of 35 million people. It is also known for having the world’s busiest pedestrian crossing, known as Shibuya Scramble Crossing, and what many would say is the busiest train station in the world in Shinjuku.",
      "Of the major cities in Japan, Sapporo, in Hokkaido Prefecture, is Japan’s northernmost major city and the nation's fifth-largest overall. The chilly climate makes it the ideal destination for people who enjoy the winter season. The city is the site of the famous Sapporo Snow Festival, an event held each February showcasing an array of marvelous ice and snow sculptures that is visited by about 2 million people each year!",
      "Nagoya has long been the center of Japan’s automotive and aviation manufacturing, as well as a technological hub with a growing robotics industry. Visitors can explore Nagoya’s tech-centric side by visiting the Nagoya City Science Museum, the SCMaglev and Railway Park, or either of the two Toyota museums."
    ],
    "priceStart": ["700", "400", "500", "550"],
    "priceEnd": ["1050", "750", "850", "900"],
    "hotelPrice": [
      "150",
      "250",
      "350",
    ],
    "date": [
      "18.1.2022 - 26.1.2022",
      "17.1.2022 - 20.1.2022",
      "15.1.2022 - 20.1.2022",
      "18.2.2022 - 23.2.2022"
    ],
    "hotelStar": [
      "3",
      "4",
      "5",
    ],
    "hotelImage": [
      "Assets/images/eisei.jpg",
      "Assets/images/shiba.jpg",
      "Assets/images/aman.jpg",
    ],
    "hotelName": [
      "Eisei Stay",
      "Shiba Park Hotel",
      "Aman Hotel",
    ],
    "hotelRoom": [
      "Single Queen Bed",
      "Double Queen Bed ",
      "Double Queen Bed",
    ],
  },
  // canada
  {
    "countryName": "Canada",
    "shortDescription": "Explore the vast forests of Canada",
    "stateName": ["Whitehorse", "Quebec City", "Ottawa", "Toronto"],
    "countryImage": "Assets/images/canada.jpg",
    "stateImage": [
      "Assets/images/yukon.jpg",
      "Assets/images/quebec.jpg",
      "Assets/images/ontario.jpg",
      "Assets/images/toronto.jpg"
    ],
    "package": [
      "8 days 6 night",
      "5 days 4 night",
      "5 days 4 night",
      "4 days 3 night"
    ],
    "description": [
      "A guided tour of Parliament Building on Parliament Hill will give you a peek into the world of Canadian government — and the building itself is quite the masterpiece. The city is also home to some of the best museums and galleries in the country. With a population of just over 25,000 people, Whitehorse is certainly one of the smaller cities on this list, but it's a charming place to visit, combining the old and the new, and it serves as a great launching point for a trip exploring Canada's vast and beautiful north. Downtown Whitehorse is small but walkable and well worth a visit — but many of the best attractions are just outside of town.",
      "With horse-drawn carriages clip-clopping along the cobblestone streets of old Quebec City, it's easy to feel as though you've jumped back in time in this historic city. Overlooking the Saint Lawrence River, Quebec City is a French-speaking city (though most people speak English in the popular tourist areas) that is rich in culture and history. Most visitors are drawn to Vieux-Québec, the fortified city core that features the aforementioned cobblestone streets, lined with boutiques, cafés, and restaurants.",
      "A guided tour of Parliament Building on Parliament Hill will give you a peek into the world of Canadian government — and the building itself is quite the masterpiece. The city is also home to some of the best museums and galleries in the country. The Canadian War Museum explores the history of Canada's military and the major events and conflicts that shaped the country as we know it today. And that's just the tip of the cultural iceberg: there's also the National Gallery of Canada, the Canadian Museum of History, the Canadian Museum of Nature, and the Canadian Aviation and Space Museum, to name a few.",
      "The capital of Ontario, the largest city in Canada, and the city that attracts the most visitors in the entire country — there's a lot to be said for Toronto, a bustling city of almost three million people, which is why it earned the top spot on this list. \n First, there are the infamous Toronto landmarks. You can't mention Toronto without thinking of the iconic CN Tower, and many tourists take the time to visit popular destinations like Toronto Island, Casa Loma, and the Toronto Zoo as well"
    ],
    "priceStart": ["1200", "800", "500", "700"],
    "priceEnd": ["1800", "1400", "1100", "1300"],
    "hotelPrice": [
      "200",
      "400",
      "600",
    ],
    "date": [
      "18.1.2022 - 26.1.2022",
      "17.1.2022 - 20.1.2022",
      "15.1.2022 - 21.1.2022",
      "18.2.2022 - 23.2.2022"
    ],
    "hotelStar": [
      "3",
      "4",
      "5",
    ],
    "hotelImage": [
      "Assets/images/inn.jpg",
      "Assets/images/fourSeason.jpg",
      "Assets/images/carlton.jpg",
    ],
    "hotelName": [
      "Residence Inn",
      "Four Season Hotel",
      "The Ritz-Carlton",
    ],
    "hotelRoom": [
      "Single Queen Bed",
      "Double King Bed ",
      "Double Queen Bed",
    ],
  },
  // Australia
  {
    "countryName": "Australia",
    "shortDescription": "Explore Australia's famous beaches",
    "stateName": ["Queensland", "N.Territory", "Tasmania", "Victoria"],
    "countryImage": "Assets/images/australia.jpg",
    "stateImage": [
      "Assets/images/queensland.jpg",
      "Assets/images/territory.jpg",
      "Assets/images/tasmania.jpg",
      "Assets/images/victoria.jpg"
    ],
    "package": [
      "8 days 6 night",
      "5 days 4 night",
      "5 days 4 night",
      "4 days 3 night"
    ],
    "description": [
      "Queensland is the closest Australia gets to Asia, with its northernmost tropical islands located just off the coast of Papua New Guinea. To the desert-covered west lies the Northern Territory and South Australia, to the south, New South Wales, and all along its eastern coast is stunning, varied shoreline. This ranges from the coastal capital of Brisbane to the famous beach (and party) destination of Gold Coast, but nowhere in Queensland is as well-known as the Great Barrier Reef. This is the world’s most extensive reef system and stretches for most of the Queensland coastline.",
      "Northern Territory is outback country. The capital of the state and its most populous city, Darwin, can be found in the north, while in the south is one of Australia’s quintessential sights: Uluru. Also known as Ayers Rock, this sandstone monolith is part of Uluru-Kata Tjuta National Park (one of the Northern Territory’s 52 national parks), home to dozens of other sandstone domes and outcrops. It’s not there to be climbed; this ancient rock is sacred for Aboriginal people. There’s much Aboriginal artwork to be admired in the area, in fact.",
      "Of the major cities in Japan, Sapporo, in Hokkaido Prefecture, is Japan’s northernmost major city and the nation's fifth-largest overall. The chilly climate makes it the ideal destination for people who enjoy the winter season. The city is the site of the famous Sapporo Snow Festival, an event held each February showcasing an array of marvelous ice and snow sculptures that is visited by about 2 million people each year!",
      "Nagoya has long been the center of Japan’s automotive and aviation manufacturing, as well as a technological hub with a growing robotics industry. Visitors can explore Nagoya’s tech-centric side by visiting the Nagoya City Science Museum, the SCMaglev and Railway Park, or either of the two Toyota museums."
    ],
    "priceStart": ["1800", "1000", "800", "650"],
    "priceEnd": ["2400", "1600", "1400", "1250"],
    "hotelPrice": [
      "250",
      "400",
      "600",
    ],
    "date": [
      "18.1.2022 - 26.1.2022",
      "17.1.2022 - 20.1.2022",
      "15.1.2022 - 20.1.2022",
      "18.2.2022 - 23.2.2022"
    ],
    "hotelStar": [
      "3",
      "4",
      "5",
    ],
    "hotelImage": [
      "Assets/images/drawin.jpg",
      "Assets/images/casino.jpg",
      "Assets/images/water.jpg",
    ],
    "hotelName": [
      "Drawin Hotel",
      "Casino Hotel",
      "Underwater Hotel",
    ],
    "hotelRoom": [
      "Single Queen Bed",
      "Double Queen Bed ",
      "Double Queen Bed",
    ],
  },
];
