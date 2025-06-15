import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DOH PWD Registration',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),
      home: LandingPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  
  int _currentPage = 0;
  bool _isAutoSliding = true;
  bool _showScrollToTop = false;
  
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final List<CarouselItem> _carouselItems = [
    CarouselItem(
      title: "RA 10754",
      subtitle: "20% DISCOUNT AND VAT EXEMPTION",
      description: "All establishments shall place signages in conspicuous areas within their premises to inform persons with disabilities that they are entitled to the 20% discount and VAT-exemption.",
      color: Colors.blue[700]!,
      icon: Icons.discount,
      features: ["20% Discount", "VAT Exemption", "All Establishments", "Clear Signages"],
    ),
    CarouselItem(
      title: "PWD Benefits",
      subtitle: "COMPREHENSIVE SUPPORT PROGRAM",
      description: "Access healthcare services, educational assistance, employment opportunities, and social services designed specifically for PWDs.",
      color: Colors.purple[700]!,
      icon: Icons.health_and_safety,
      features: ["Healthcare", "Education", "Employment", "Social Services"],
    ),
    CarouselItem(
      title: "Easy Registration",
      subtitle: "STREAMLINED PROCESS",
      description: "Complete your PWD registration online or visit your local health center. Get your PWD ID and start enjoying your benefits immediately.",
      color: Colors.teal[700]!,
      icon: Icons.how_to_reg,
      features: ["Online Process", "Local Centers", "Instant ID", "Immediate Benefits"],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _setupScrollListener();
    _startAutoSlide();
  }

  void _initializeAnimations() {
    _fadeController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeIn),
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOut));
    
    _fadeController.forward();
    _slideController.forward();
  }

  void _setupScrollListener() {
    _scrollController.addListener(() {
      setState(() {
        _showScrollToTop = _scrollController.offset > 300;
      });
    });
  }

  void _startAutoSlide() {
    Future.delayed(Duration(seconds: 4), _autoSlide);
  }

  void _autoSlide() {
    if (mounted && _isAutoSliding) {
      setState(() {
        _currentPage = (_currentPage + 1) % _carouselItems.length;
      });
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
      Future.delayed(Duration(seconds: 4), _autoSlide);
    }
  }

  void _pauseAutoSlide() {
    setState(() {
      _isAutoSliding = false;
    });
  }

  void _resumeAutoSlide() {
    setState(() {
      _isAutoSliding = true;
    });
    _startAutoSlide();
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _scrollController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: _buildMobileDrawer(),
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              // App Bar
              _buildSliverAppBar(),
              
              // Main Content
              SliverToBoxAdapter(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: Column(
                      children: [
                        _buildHeroSection(),
                        _buildFeaturesSection(),
                        _buildStatisticsSection(),
                        _buildTestimonialsSection(),
                        _buildFAQSection(),
                        _buildFooter(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          
          // Floating Action Buttons
          _buildFloatingActions(),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 70,
      floating: false,
      pinned: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1565C0), Color(0xFF0D47A1)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
      ),
      title: LayoutBuilder(
        builder: (context, constraints) {
          bool isMobile = MediaQuery.of(context).size.width < 768;
          
          return Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.health_and_safety,
                  color: Color(0xFF1565C0),
                  size: 24,
                ),
              ),
              if (!isMobile) ...[
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'DEPARTMENT OF HEALTH',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'PWD Registration Portal',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          );
        },
      ),
      actions: [
        LayoutBuilder(
          builder: (context, constraints) {
            bool isMobile = MediaQuery.of(context).size.width < 768;
            
            if (isMobile) {
              return IconButton(
                icon: Icon(Icons.menu, color: Colors.white),
                onPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
                tooltip: 'Open Menu',
              );
            } else {
              return Row(
                children: [
                  _buildNavButton('Home', Icons.home, true),
                  _buildNavButton('Services', Icons.medical_services, false),
                  _buildNavButton('Track', Icons.track_changes, false),
                  _buildNavButton('Help', Icons.help_outline, false),
                  SizedBox(width: 16),
                ],
              );
            }
          },
        ),
      ],
    );
  }

  Widget _buildNavButton(String text, IconData icon, bool isActive) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: InkWell(
        onTap: () {
          HapticFeedback.lightImpact();
          // Add navigation logic
        },
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isActive ? Colors.white.withOpacity(0.2) : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isActive ? Colors.white : Colors.white.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: Colors.white, size: 18),
              SizedBox(width: 6),
              Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMobileDrawer() {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1565C0), Color(0xFF0D47A1)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 20),
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.health_and_safety,
                  color: Color(0xFF1565C0),
                  size: 40,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'DOH PWD Portal',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 40),
              ..._buildDrawerItems(),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildDrawerItems() {
    final items = [
      {'title': 'Home', 'icon': Icons.home},
      {'title': 'Register Now', 'icon': Icons.person_add},
      {'title': 'Track Application', 'icon': Icons.track_changes},
      {'title': 'Sign In', 'icon': Icons.login},
      {'title': 'Services', 'icon': Icons.medical_services},
      {'title': 'Help & Support', 'icon': Icons.help},
      {'title': 'About Us', 'icon': Icons.info},
    ];

    return items.map((item) => 
      ListTile(
        leading: Icon(item['icon'] as IconData, color: Colors.white),
        title: Text(
          item['title'] as String,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        onTap: () {
          HapticFeedback.lightImpact();
          Navigator.pop(context);
          // Add navigation logic
        },
      ),
    ).toList();
  }

  Widget _buildHeroSection() {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isDesktop = constraints.maxWidth > 1024;
        bool isMobile = constraints.maxWidth < 768;
        
        return Container(
          constraints: BoxConstraints(minHeight: 500),
          child: Padding(
            padding: EdgeInsets.all(isMobile ? 16 : 32),
            child: isDesktop
                ? _buildDesktopHeroLayout()
                : _buildMobileHeroLayout(),
          ),
        );
      },
    );
  }

  Widget _buildDesktopHeroLayout() {
    return Row(
      children: [
        // Left Action Button
        Expanded(
          flex: 2,
          child: _buildEnhancedActionButton(
            'Register Now',
            Icons.person_add_alt_1,
            Colors.blue[600]!,
            () => _handleRegistration(),
          ),
        ),
        
        SizedBox(width: 32),
        
        // Carousel
        Expanded(
          flex: 4,
          child: _buildEnhancedCarousel(),
        ),
        
        SizedBox(width: 32),
        
        // Right Action Button
        Expanded(
          flex: 2,
          child: _buildEnhancedActionButton(
            'Sign In',
            Icons.login,
            Colors.purple[600]!,
            () => _handleSignIn(),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileHeroLayout() {
    return Column(
      children: [
        _buildEnhancedCarousel(),
        SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: _buildEnhancedActionButton(
                'Register',
                Icons.person_add_alt_1,
                Colors.blue[600]!,
                () => _handleRegistration(),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: _buildEnhancedActionButton(
                'Sign In',
                Icons.login,
                Colors.purple[600]!,
                () => _handleSignIn(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildEnhancedActionButton(
    String title, 
    IconData icon, 
    Color color, 
    VoidCallback onTap
  ) {
    return InkWell(
      onTap: () {
        HapticFeedback.mediumImpact();
        onTap();
      },
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        height: MediaQuery.of(context).size.width > 768 ? 200 : 140,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color, color.withOpacity(0.8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 12,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: Colors.white, size: 32),
              ),
              SizedBox(height: 16),
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              
              if (MediaQuery.of(context).size.width > 768) ...[
                SizedBox(height: 8),
                
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEnhancedCarousel() {
    return GestureDetector(
      onTap: _pauseAutoSlide,
      onTapUp: (_) => _resumeAutoSlide(),
      child: Container(
        height: 450,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 20,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            children: [
              PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _carouselItems.length,
                itemBuilder: (context, index) {
                  return _buildEnhancedCarouselSlide(_carouselItems[index]);
                },
              ),
              
              // Navigation Arrows
              Positioned(
                left: 16,
                top: 0,
                bottom: 0,
                child: Center(
                  child: IconButton(
                    onPressed: () {
                      HapticFeedback.lightImpact();
                      _pauseAutoSlide();
                      _pageController.previousPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                      Future.delayed(Duration(seconds: 2), _resumeAutoSlide);
                    },
                    icon: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.chevron_left, color: Colors.white),
                    ),
                  ),
                ),
              ),
              
              Positioned(
                right: 16,
                top: 0,
                bottom: 0,
                child: Center(
                  child: IconButton(
                    onPressed: () {
                      HapticFeedback.lightImpact();
                      _pauseAutoSlide();
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                      Future.delayed(Duration(seconds: 2), _resumeAutoSlide);
                    },
                    icon: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.chevron_right, color: Colors.white),
                    ),
                  ),
                ),
              ),
              
              // Enhanced Page Indicators
              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _carouselItems.asMap().entries.map((entry) {
                    return AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      width: _currentPage == entry.key ? 32 : 12,
                      height: 8,
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: _currentPage == entry.key
                            ? Colors.white
                            : Colors.white54,
                      ),
                    );
                  }).toList(),
                ),
              ),
              
              // Auto-slide indicator
              Positioned(
                top: 16,
                right: 16,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _isAutoSliding ? Icons.play_arrow : Icons.pause,
                        color: Colors.white,
                        size: 16,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Auto',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEnhancedCarouselSlide(CarouselItem item) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [item.color, item.color.withOpacity(0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with icons
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(item.icon, color: Colors.white, size: 32),
                ),
                Spacer(),
                Icon(Icons.accessibility_new, color: Colors.white, size: 24),
                SizedBox(width: 8),
                Icon(Icons.favorite, color: Colors.red[300], size: 20),
              ],
            ),
            
            SizedBox(height: 24),
            
            // Title
            Text(
              item.title,
              style: TextStyle(
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.width > 768 ? 48 : 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            
            SizedBox(height: 12),
            
            // Subtitle
            Text(
              item.subtitle,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.2,
              ),
            ),
            
            SizedBox(height: 16),
            
            // Description
            Text(
              item.description,
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 14,
                height: 1.5,
              ),
            ),
            
            Spacer(),
            
            // Features chips
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: item.features.map((feature) => 
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white.withOpacity(0.3)),
                  ),
                  child: Text(
                    feature,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturesSection() {
    return Container(
      padding: EdgeInsets.all(32),
      color: Colors.grey[50],
      child: Column(
        children: [
          Text(
            'Why Choose Our PWD Registration Portal?',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1565C0),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          Text(
            'We make PWD registration simple, fast, and accessible for everyone',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 40),
          LayoutBuilder(
            builder: (context, constraints) {
              bool isMobile = constraints.maxWidth < 768;
              
              if (isMobile) {
                return Column(
                  children: _buildFeatureCards(),
                );
              } else {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _buildFeatureCards().map((card) => 
                    Expanded(child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: card,
                    ))
                  ).toList(),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  List<Widget> _buildFeatureCards() {
    final features = [
      {
        'icon': Icons.speed,
        'title': 'Fast Processing',
        'description': 'Get your PWD ID in just 3-5 working days',
        'color': Colors.green,
      },
      {
        'icon': Icons.security,
        'title': 'Secure & Private',
        'description': 'Your personal information is protected',
        'color': Colors.orange,
      },
      {
        'icon': Icons.accessibility,
        'title': 'Fully Accessible',
        'description': 'Designed with accessibility in mind',
        'color': Colors.purple,
      },
    ];

    return features.map((feature) => 
      Container(
        margin: EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: (feature['color'] as Color).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                feature['icon'] as IconData,
                color: feature['color'] as Color,
                size: 32,
              ),
            ),
            SizedBox(height: 16),
            Text(
              feature['title'] as String,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 8),
            Text(
              feature['description'] as String,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ).toList();
  }

  Widget _buildStatisticsSection() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 60, horizontal: 32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue[600]!, Colors.blue[800]!],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          bool isMobile = constraints.maxWidth < 768;
          
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatCard('30,742', 'Registered PWDs', Icons.people),
                  if (!isMobile) ...[
                    _buildStatCard('98%', 'Satisfaction Rate', Icons.star),
                    _buildStatCard('24/7', 'Support Available', Icons.support_agent),
                  ],
                ],
              ),
              if (isMobile) ...[
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatCard('98%', 'Satisfaction', Icons.star),
                    _buildStatCard('24/7', 'Support', Icons.support_agent),
                  ],
                ),
              ],
              SizedBox(height: 32),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Join thousands of PWDs who have already registered and are enjoying their benefits',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildStatCard(String number, String label, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 32),
        SizedBox(height: 8),
        Text(
          number,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.white.withOpacity(0.9),
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildTestimonialsSection() {
    return Container(
      padding: EdgeInsets.all(32),
      color: Colors.grey[50],
      child: Column(
        children: [
          Text(
            'What Our Users Say',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1565C0),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 40),
          LayoutBuilder(
            builder: (context, constraints) {
              bool isMobile = constraints.maxWidth < 768;
              
              if (isMobile) {
                return Column(
                  children: _buildTestimonialCards(),
                );
              } else {
                return Row(
                  children: _buildTestimonialCards().map((card) => 
                    Expanded(child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: card,
                    ))
                  ).toList(),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  List<Widget> _buildTestimonialCards() {
    final testimonials = [
      {
        'name': 'Maria Santos',
        'role': 'PWD Beneficiary',
        'message': 'The registration process was so easy! I got my PWD ID in just 3 days.',
        'rating': 5,
      },
      {
        'name': 'Juan Dela Cruz',
        'role': 'Senior Citizen PWD',
        'message': 'Finally, a system that works for people like us. Very user-friendly.',
        'rating': 5,
      },
      {
        'name': 'Ana Reyes',
        'role': 'Guardian',
        'message': 'Registered my child online without any hassle. Excellent service!',
        'rating': 5,
      },
    ];

    return testimonials.map((testimonial) => 
      Container(
        margin: EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: List.generate(testimonial['rating'] as int, (index) => 
                Icon(Icons.star, color: Colors.amber, size: 20),
              ),
            ),
            SizedBox(height: 16),
            Text(
              '"${testimonial['message']}"',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Text(
              testimonial['name'] as String,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            Text(
              testimonial['role'] as String,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    ).toList();
  }

  Widget _buildFAQSection() {
    return Container(
      padding: EdgeInsets.all(32),
      child: Column(
        children: [
          Text(
            'Frequently Asked Questions',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1565C0),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 40),
          ..._buildFAQItems(),
        ],
      ),
    );
  }

  List<Widget> _buildFAQItems() {
    final faqs = [
      {
        'question': 'How long does the registration process take?',
        'answer': 'The online registration takes about 10-15 minutes to complete. Your PWD ID will be ready within 3-5 working days.',
      },
      {
        'question': 'What documents do I need to prepare?',
        'answer': 'You need a valid ID, medical certificate from a licensed physician, and recent passport-sized photos.',
      },
      {
        'question': 'Can I track my application status?',
        'answer': 'Yes, you can track your application status using the reference number provided after registration.',
      },
      {
        'question': 'Is the registration free?',
        'answer': 'Yes, PWD registration is completely free of charge as mandated by law.',
      },
    ];

    return faqs.map((faq) => 
      Container(
        margin: EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: ExpansionTile(
          title: Text(
            faq['question'] as String,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
            ),
          ),
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                faq['answer'] as String,
                style: TextStyle(
                  color: Colors.grey[600],
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    ).toList();
  }

  Widget _buildFooter() {
    return Container(
      padding: EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.grey[800]!, Colors.grey[900]!],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          bool isMobile = constraints.maxWidth < 768;
          
          return Column(
            children: [
              if (isMobile) ...[
                _buildFooterColumn(),
                SizedBox(height: 24),
                _buildContactInfo(),
              ] else ...[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 2, child: _buildFooterColumn()),
                    Expanded(flex: 2, child: _buildContactInfo()),
                    Expanded(flex: 1, child: _buildSocialLinks()),
                  ],
                ),
              ],
              SizedBox(height: 32),
              Divider(color: Colors.white24),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '© 2024 Department of Health - Philippines',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                  if (!isMobile)
                    Text(
                      'Privacy Policy • Terms of Service',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildFooterColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Department of Health',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        Text(
          'PWD Registration Portal',
          style: TextStyle(color: Colors.white70, fontSize: 14),
        ),
        SizedBox(height: 8),
        Text(
          'Making healthcare accessible for all Filipinos with disabilities.',
          style: TextStyle(color: Colors.white70, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildContactInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact Information',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        _buildContactItem(Icons.location_on, 'DOH Building, Quezon City, NCR Metro Manila'),
        _buildContactItem(Icons.phone, '+63 2 8651-7800'),
        _buildContactItem(Icons.email, 'pwd.registration@doh.gov.ph'),
        _buildContactItem(Icons.access_time, 'Mon-Fri: 8:00 AM - 5:00 PM'),
      ],
    );
  }

  Widget _buildContactItem(IconData icon, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.white70, size: 16),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialLinks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Follow Us',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            _buildSocialButton(Icons.facebook, 'Facebook'),
            SizedBox(width: 8),
            _buildSocialButton(Icons.camera_alt, 'Instagram'),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialButton(IconData icon, String tooltip) {
    return InkWell(
      onTap: () {
        HapticFeedback.lightImpact();
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: Colors.white70, size: 20),
      ),
    );
  }

  Widget _buildFloatingActions() {
    return Stack(
      children: [
        // Scroll to top button
        if (_showScrollToTop)
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              mini: true,
              onPressed: _scrollToTop,
              backgroundColor: Color(0xFF1565C0),
              child: Icon(Icons.keyboard_arrow_up, color: Colors.white),
              tooltip: 'Scroll to top',
            ),
          ),
        
        // Help button
        Positioned(
          bottom: _showScrollToTop ? 80 : 16,
          right: 16,
          child: FloatingActionButton(
            mini: true,
            onPressed: () {
              HapticFeedback.mediumImpact();
              _showHelpDialog();
            },
            backgroundColor: Colors.green[600],
            child: Icon(Icons.help_outline, color: Colors.white),
            tooltip: 'Need help?',
          ),
        ),
      ],
    );
  }

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Row(
            children: [
              Icon(Icons.help_outline, color: Color(0xFF1565C0)),
              SizedBox(width: 8),
              Text('Need Help?'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('How can we assist you today?'),
              SizedBox(height: 16),
              ListTile(
                leading: Icon(Icons.phone, color: Colors.green),
                title: Text('Call Us'),
                subtitle: Text('+63 2 8651-7800'),
                onTap: () {
                  Navigator.pop(context);
                  // Add phone call functionality
                },
              ),
              ListTile(
                leading: Icon(Icons.email, color: Colors.blue),
                title: Text('Email Support'),
                subtitle: Text('pwd.registration@doh.gov.ph'),
                onTap: () {
                  Navigator.pop(context);
                  // Add email functionality
                },
              ),
              ListTile(
                leading: Icon(Icons.chat, color: Colors.orange),
                title: Text('Live Chat'),
                subtitle: Text('Chat with our support team'),
                onTap: () {
                  Navigator.pop(context);
                  // Add live chat functionality
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _handleRegistration() {
    // Add registration logic or navigation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Redirecting to registration form...'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _handleSignIn() {
    // Add sign in logic or navigation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Redirecting to sign in page...'),
        backgroundColor: Colors.blue,
        duration: Duration(seconds: 2),
      ),
    );
  }
}

class CarouselItem {
  final String title;
  final String subtitle;
  final String description;
  final Color color;
  final IconData icon;
  final List<String> features;

  CarouselItem({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.color,
    required this.icon,
    required this.features,
  });
}