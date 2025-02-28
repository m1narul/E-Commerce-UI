import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'lang/languages.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: Languages(),
      locale: Locale('en', 'US'),  // Default Language
      fallbackLocale: Locale('en', 'US'),
      title: 'E-Commerce UI',
      initialRoute: '/',
      getPages: [
        GetPage(
            name: '/ReviewerProfilePage',
            page: () => ReviewerProfilePage(
                  userDetail: '',
                  userName: '',
                )),
      ],
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    HomeContent(),
    Center(child: Text('Category Page')),
    Center(child: Text('Community Page')),
    Center(child: Text('My Page')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LOGO'),
        actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: '카테고리'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: '커뮤니티'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '마이페이지'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
        children: [
          SearchWidget(),
          Container(
            height: 20,
          ),
          CarouselWithIndicator(),
          Container(
            height: 20,
          ),
          Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Review Ranking Top 3',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(height: 200, child: ReviewList()),
          Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Best Reviewers Top 10',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(height: 120, child: TopReviewers()),
          Container(height: 20,),
          BottomWidget(),
        ],
    );
  }
}

class ReviewList extends StatelessWidget {
  const ReviewList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        ListTile(
          leading: Image.asset('assets/tv1.png', width: 50),
          title: Text('LG Smart TV 27ART10AKPL'),
          subtitle: Text('⭐ 4.5 | 120 reviews'),
        ),
        ListTile(
          leading: Image.asset('assets/tv2.png', width: 50),
          title: Text('LG Ultra HD 75UP8300KNA'),
          subtitle: Text('⭐ 4.7 | 95 reviews'),
        ),
        ListTile(
          leading: Image.asset('assets/tv3.png', width: 50),
          title: Text('Samsung Crystal UHD 55AU8000'),
          subtitle: Text('⭐ 4.6 | 110 reviews'),
        ),
      ],
    );
  }
}

class TopReviewers extends StatelessWidget {
  const TopReviewers({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      children: List.generate(10, (index) {
        return InkWell(
          onTap: () => Get.to(() => ReviewerProfilePage(
                userDetail: 'assets/user${index + 1}.png',
                userName: 'Name${index + 1}',
              )),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          AssetImage('assets/user${index + 1}.png'),
                    ),
                    if (index == 0)
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Icon(Icons.star, color: Colors.yellow, size: 20),
                      ),
                  ],
                ),
                SizedBox(height: 5),
                Text('Name${index + 1}',
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class ReviewerProfilePage extends StatelessWidget {
  final String userDetail;
  final String userName;

  const ReviewerProfilePage(
      {super.key, required this.userDetail, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('랭킹 1위'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(userDetail),
            ),
            SizedBox(height: 10),
            Text(userName,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text('🏆 골드', style: TextStyle(color: Colors.amber, fontSize: 16)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                '조립컴 업체를 운영하며 리뷰를 작성합니다.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.all(10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('작성한 리뷰 총 35개',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            ReviewItem(
              userDetail: userDetail,
              userName: userName,
            ),
          ],
        ),
      ),
    );
  }
}

class ReviewItem extends StatelessWidget {
  final String userDetail;
  final String userName;

  const ReviewItem(
      {super.key, required this.userDetail, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset('assets/ryzen.png', width: 60),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('AMD 라이젠 5 5600X 버미어 정품 멀티팩',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.yellow, size: 16),
                        Icon(Icons.star, color: Colors.yellow, size: 16),
                        Icon(Icons.star, color: Colors.yellow, size: 16),
                        Icon(Icons.star, color: Colors.yellow, size: 16),
                        Icon(Icons.star_half, color: Colors.yellow, size: 16),
                        SizedBox(width: 5),
                        Text('4.07',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              CircleAvatar(
                radius: 15,
                backgroundImage: AssetImage(userDetail),
              ),
              SizedBox(width: 10),
              Text(userName, style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(width: 5),
              Text('⭐ 2022.12.09', style: TextStyle(color: Colors.grey)),
            ],
          ),
          SizedBox(height: 10),
          Text('멀티 작업도 잘 되고 꽤 괜찮습니다. 저희 회사 고객님들에게도 추천 가능한 제품인 듯 합니다.'),
          SizedBox(height: 5),
          Text('3600에서 바꾸니 체감이 살짝 되네요. 버라이어티한 느낌까지는 아닙니다.'),
          SizedBox(height: 10),
          Row(
            children: [
              Image.asset('assets/review1.png', height: 80),
              SizedBox(width: 5),
              Image.asset('assets/review2.png', height: 80),
              SizedBox(width: 5),
              Image.asset('assets/review3.png', height: 80),
            ],
          ),
        ],
      ),
    );
  }
}

class CarouselWithIndicator extends StatefulWidget {
  const CarouselWithIndicator({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicator> {
  int _current = 0;
  final CarouselSliderController _controller = CarouselSliderController();
  final imgList = [
    'assets/banner1.png',
    'assets/banner2.png',
    'assets/banner3.png',
    'assets/banner4.png'
  ];

  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders = imgList
        .map((item) => Container(
              child: Container(
                margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Image.asset(
                      item,
                      fit: BoxFit.cover,
                    )),
              ),
            ))
        .toList();
    return ListView(shrinkWrap: true, children: [
      Stack(
        children: [
          CarouselSlider(
            items: imageSliders,
            carouselController: _controller,
            options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,
                enlargeStrategy: CenterPageEnlargeStrategy.scale,
                aspectRatio: 2.0,
                enlargeFactor: 1,
                viewportFraction: 1.0,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imgList.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _controller.animateToPage(entry.key),
                  child: Container(
                    width: _current == entry.key ? 25 : 12.0,
                    height: 10.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                        shape: _current == entry.key
                            ? BoxShape.rectangle
                            : BoxShape.circle,
                        borderRadius: _current == entry.key
                            ? BorderRadius.all(Radius.circular(20))
                            : null,
                        color: (Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black)
                            .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    ]);
  }
}

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth * 0.85,
      // Responsive width (85% of screen width)
      height: 48,
      // Fixed height for consistent UI
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [Colors.cyanAccent, Colors.blueAccent],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      padding: const EdgeInsets.all(1),
      // Thin border effect
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, // Background inside
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: '검색어를 입력하세요',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Icon(
              Icons.search,
              color: Colors.blueAccent,
            ),
          ],
        ),
      ),
    );
  }
}
class BottomWidget extends StatelessWidget {
  const BottomWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      color: Colors.black,
      child: Column(
        children: [
          Text('LOGO Inc.', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('회사 소개  |  인재 채용  |  기술 블로그  |  리뷰 저작권',
                  style: TextStyle(color: Colors.white70)),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.email, color: Colors.white70),
              SizedBox(width: 5),
              Text('review@logo.com', style: TextStyle(color: Colors.white70)),
            ],
          ),
          SizedBox(height: 10),
          Text('@2022-2022 LOGO Lab, Inc. (주)아무개 서울시 강남구',
              style: TextStyle(color: Colors.white54, fontSize: 12)),
        ],
      ),
    );
  }
}
