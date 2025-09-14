import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui'; // For BackdropFilter
import 'package:go_router/go_router.dart'; // Required for go_router navigation

// --- Constants & Styles ---

// Define colors based on Figma RGBA values
const Color primaryRed = Color(0xFFD83752); // Figma: r: 0.847, g: 0.215, b: 0.321, a: 1
const Color darkGray = Color(0xFF212121); // Figma: r: 0.129, g: 0.129, b: 0.129, a: 1
const Color mediumGray = Color(0xFF717171); // Figma: r: 0.443, g: 0.443, b: 0.443, a: 1
const Color lightGray = Color(0xFFF2F2F2); // Figma: r: 0.949, g: 0.949, b: 0.949, a: 1
const Color white = Colors.white;
const Color semiTransparentLightGray = Color(0x4DF2F2F2); // F2F2F2 with opacity 0.3 (0x4D = 30%)
const Color transparentWhiteBlur = Color(0xE6FFFFFF); // White with opacity 0.9 (0xE6 = 90%)

// Text Styles using GoogleFonts for Inter. SF Pro Text is assumed as a system font.
final TextStyle darkGrayMedium14 = GoogleFonts.inter(
  fontSize: 14,
  fontWeight: FontWeight.w500,
  color: darkGray,
  letterSpacing: -0.5,
  height: 1.21, // Calculated from Figma's lineHeightPx (16.94) / fontSize (14)
);

final TextStyle mediumGrayMedium14 = GoogleFonts.inter(
  fontSize: 14,
  fontWeight: FontWeight.w500,
  color: mediumGray,
  letterSpacing: -0.5,
  height: 1.21,
);

final TextStyle mediumGrayRegular14 = GoogleFonts.inter(
  fontSize: 14,
  fontWeight: FontWeight.w400,
  color: mediumGray,
  letterSpacing: -0.5,
  height: 1.21,
);

final TextStyle primaryRedSemiBold10 = GoogleFonts.inter(
  fontSize: 10,
  fontWeight: FontWeight.w600,
  color: primaryRed,
  letterSpacing: -0.5,
  height: 1.21,
);

final TextStyle mediumGrayRegular10 = GoogleFonts.inter(
  fontSize: 10,
  fontWeight: FontWeight.w400,
  color: mediumGray,
  letterSpacing: -0.5,
  height: 1.21,
);

final TextStyle darkGrayMedium12 = GoogleFonts.inter(
  fontSize: 12,
  fontWeight: FontWeight.w500,
  color: darkGray,
  letterSpacing: -0.5,
  height: 1.21,
);

final TextStyle mediumGrayMedium12 = GoogleFonts.inter(
  fontSize: 12,
  fontWeight: FontWeight.w500,
  color: mediumGray,
  letterSpacing: -0.5,
  height: 1.21,
);

final TextStyle whiteMedium14 = GoogleFonts.inter(
  fontSize: 14,
  fontWeight: FontWeight.w500,
  color: white,
  letterSpacing: -0.5,
  height: 1.21,
);

final TextStyle statusBarTimeStyle = const TextStyle(
  fontFamily: 'SF Pro Text', // Assuming SF Pro Text is available; will fall back to system default if not configured.
  fontSize: 16.56,
  fontWeight: FontWeight.w600,
  color: darkGray,
  letterSpacing: -0.55,
  height: 1.33, // Calculated from Figma's lineHeightPx (22.08) / fontSize (16.56)
);

// --- Reusable Widgets ---

class DisplayCard extends StatefulWidget {
  final String imageAssetPath;
  final String location;
  final String rating;
  final String distance;
  final String dates;
  final String pricePerNight;
  final bool isLikedInitially; // To manage heart icon state
  final String routeName; // For navigation

  const DisplayCard({
    Key? key,
    required this.imageAssetPath,
    required this.location,
    required this.rating,
    required this.distance,
    required this.dates,
    required this.pricePerNight,
    this.isLikedInitially = false,
    required this.routeName,
  }) : super(key: key);

  @override
  State<DisplayCard> createState() => _DisplayCardState();
}

class _DisplayCardState extends State<DisplayCard> {
  late bool _isLiked;

  @override
  void initState() {
    super.initState();
    _isLiked = widget.isLikedInitially;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: lightGray, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.asset(
                  widget.imageAssetPath,
                  fit: BoxFit.cover,
                  height: 295, // Figma specified height
                  width: double.infinity,
                ),
              ),
              Positioned(
                top: 16,
                right: 16,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _isLiked = !_isLiked;
                    });
                  },
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (_isLiked ? primaryRed : darkGray).withOpacity(0.1), // Adjusted for contrast
                    ),
                    child: Icon(
                      _isLiked ? Icons.favorite : Icons.favorite_border,
                      color: _isLiked ? white : darkGray, // Icon color changes based on state
                      size: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.location,
                      style: darkGrayMedium14,
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, size: 16, color: mediumGray),
                        const SizedBox(width: 4),
                        Text(
                          widget.rating,
                          style: mediumGrayMedium14,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  widget.distance,
                  style: mediumGrayRegular14,
                ),
                const SizedBox(height: 8),
                Text(
                  widget.dates,
                  style: mediumGrayRegular14,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: semiTransparentLightGray,
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.pricePerNight,
                  style: darkGrayMedium14,
                ),
                OutlinedButton(
                  onPressed: () {
                    context.push(widget.routeName); // Using go_router
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    side: const BorderSide(color: lightGray, width: 1.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: Text(
                    'See details',
                    style: darkGrayMedium14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final IconData icon; // Using Material IconData as per rules
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryItem({
    Key? key,
    required this.icon,
    required this.label,
    this.isSelected = false,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(
            icon,
            size: 24,
            color: isSelected ? darkGray : mediumGray,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: darkGrayMedium12.copyWith(
              color: isSelected ? darkGray : mediumGray,
            ),
          ),
          if (isSelected)
            Container(
              margin: const EdgeInsets.only(top: 13),
              width: 27,
              height: 2,
              color: darkGray,
            ),
        ],
      ),
    );
  }
}

class NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final String routeName;

  const NavItem({
    Key? key,
    required this.icon,
    required this.label,
    this.isSelected = false,
    required this.onTap,
    required this.routeName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 24,
            color: isSelected ? primaryRed : mediumGray,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: primaryRedSemiBold10.copyWith(
              color: isSelected ? primaryRed : mediumGray,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

// --- Main Screen Widget ---

class MyRedesignScreen extends StatefulWidget {
  const MyRedesignScreen({Key? key}) : super(key: key);

  @override
  State<MyRedesignScreen> createState() => _MyRedesignScreenState();
}

class _MyRedesignScreenState extends State<MyRedesignScreen> {
  int _selectedCategoryIndex = 0;
  int _selectedNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    const double fixedHeroSectionHeight = 204.0;

    const double bottomNavBarHeight = 88.0;
    const double mapButtonHeight = 33.0;
    const double mapButtonWidth = 74.0;
    const double mapButtonBottomMargin = 16.0; // Space between map button and bottom nav

    return Scaffold(
      backgroundColor: white,
      body: Stack(
        children: [
          // Scrollable Content Area
          Positioned.fill(
            top: fixedHeroSectionHeight, // Start content below the fixed header
            bottom: bottomNavBarHeight, // End content above the fixed footer
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DisplayCard(
                    imageAssetPath: 'assets/images/I175_34.png',
                    location: 'Apapa, Asia',
                    rating: '4.87',
                    distance: '1,669 kilometers',
                    dates: 'Jul 2 - 7',
                    pricePerNight: '\$360 / Night',
                    isLikedInitially: true, // As per image asset showing a filled heart
                    routeName: '/details', // Infer route '/details'
                  ),
                  const SizedBox(height: 16),
                  DisplayCard(
                    imageAssetPath: 'assets/images/I175_54.png',
                    location: 'Abiansemal, Indonesia',
                    rating: '4.87',
                    distance: '1,669 kilometers',
                    dates: 'Jul 2 - 7',
                    pricePerNight: '\$360 / Night',
                    isLikedInitially: false, // As per image asset showing an outlined heart
                    routeName: '/details', // Infer route '/details'
                  ),
                  const SizedBox(height: 16),
                  DisplayCard(
                    imageAssetPath: 'assets/images/I175_74.png',
                    location: 'Apapa, Asia',
                    rating: '4.87',
                    distance: '1,669 kilometers',
                    dates: 'Jul 2 - 7',
                    pricePerNight: '\$360 / Night',
                    isLikedInitially: true,
                    routeName: '/details', // Infer route '/details'
                  ),
                  const SizedBox(height: 16),
                  DisplayCard(
                    imageAssetPath: 'assets/images/I175_94.png',
                    location: 'Apapa, Asia',
                    rating: '4.87',
                    distance: '1,669 kilometers',
                    dates: 'Jul 2 - 7',
                    pricePerNight: '\$360 / Night',
                    isLikedInitially: true,
                    routeName: '/details', // Infer route '/details'
                  ),
                  // Additional spacing to ensure last card is not covered by fixed map button
                  const SizedBox(height: mapButtonHeight + mapButtonBottomMargin + 16),
                ],
              ),
            ),
          ),

          // Fixed Header (Hero Section)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: fixedHeroSectionHeight, // Fixed height as per Figma frame
              color: white,
              child: SafeArea(
                bottom: false, // Only apply top padding for status bar
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      // Status Bar Time - Figma shows 9:41 at Y=14.35, but within a 48px height status bar.
                      // Adjust padding to visually match 55px Y-offset for search bar.
                      SizedBox(
                        height: 48 - statusBarHeight, // Adjust height based on actual status bar to match Figma 48px
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text('9:41', style: statusBarTimeStyle),
                        ),
                      ),
                      const SizedBox(height: 7), // Space between status bar content and search bar (55-48=7)
                      // Search Bar
                      GestureDetector(
                        onTap: () {
                          context.push('/search'); // Using go_router
                        },
                        child: Container(
                          height: 55,
                          padding: const EdgeInsets.fromLTRB(15, 9, 9, 9),
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(color: lightGray, width: 1),
                            boxShadow: [
                              BoxShadow(
                                color: lightGray.withOpacity(0.88), // F2F2F2 with opacity 0.88
                                offset: const Offset(0, 8),
                                blurRadius: 32,
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.search, size: 24, color: darkGray),
                              const SizedBox(width: 7),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Where to?',
                                      style: darkGrayMedium14.copyWith(height: 1.57), // 22/14px line height from Figma
                                    ),
                                    Text(
                                      'Anywhere, Anytime, Add guest',
                                      style: mediumGrayMedium12,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: lightGray, width: 1.5),
                                ),
                                child: const Icon(Icons.tune, size: 20, color: darkGray),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24), // Space between search bar and categories
                      // Categories
                      SizedBox(
                        height: 58,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            CategoryItem(
                              icon: Icons.videogame_asset, // Closest Material Icon for "space-invaders"
                              label: 'OMG!',
                              isSelected: _selectedCategoryIndex == 0,
                              onTap: () {
                                setState(() {
                                  _selectedCategoryIndex = 0;
                                });
                                context.go('/omg_category'); // Using go_router
                              },
                            ),
                            const SizedBox(width: 16),
                            CategoryItem(
                              icon: Icons.beach_access,
                              label: 'Beach',
                              isSelected: _selectedCategoryIndex == 1,
                              onTap: () {
                                setState(() {
                                  _selectedCategoryIndex = 1;
                                });
                                context.go('/beach_category'); // Using go_router
                              },
                            ),
                            const SizedBox(width: 16),
                            CategoryItem(
                              icon: Icons.pool,
                              label: 'Pools',
                              isSelected: _selectedCategoryIndex == 2,
                              onTap: () {
                                setState(() {
                                  _selectedCategoryIndex = 2;
                                });
                                context.go('/pools_category'); // Using go_router
                              },
                            ),
                            const SizedBox(width: 16),
                            CategoryItem(
                              icon: Icons.landscape, // Closest Material Icon for "island"
                              label: 'Islands',
                              isSelected: _selectedCategoryIndex == 3,
                              onTap: () {
                                setState(() {
                                  _selectedCategoryIndex = 3;
                                });
                                context.go('/islands_category'); // Using go_router
                              },
                            ),
                            const SizedBox(width: 16),
                            CategoryItem(
                              icon: Icons.landscape, // Repeated label/icon, adjust if different in reality
                              label: 'Islands',
                              isSelected: _selectedCategoryIndex == 4,
                              onTap: () {
                                setState(() {
                                  _selectedCategoryIndex = 4;
                                });
                                context.go('/islands_category_2'); // Using go_router
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Fixed Map Button
          Positioned(
            bottom: bottomNavBarHeight + mapButtonBottomMargin, // Above bottom nav with 16px spacing
            left: (screenWidth - mapButtonWidth) / 2, // Centered horizontally
            child: GestureDetector(
              onTap: () {
                context.push('/map'); // Using go_router
              },
              child: Container(
                width: mapButtonWidth,
                height: mapButtonHeight,
                decoration: BoxDecoration(
                  color: darkGray,
                  borderRadius: BorderRadius.circular(31),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.map, size: 16, color: white),
                    const SizedBox(width: 5),
                    Text('Map', style: whiteMedium14),
                  ],
                ),
              ),
            ),
          ),

          // Fixed Bottom Navigation Bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(0), // No explicit corner radius for the overall nav frame
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                child: Container(
                  height: bottomNavBarHeight,
                  decoration: BoxDecoration(
                    color: transparentWhiteBlur, // White with 0.9 opacity for the blur effect
                    border: Border(top: BorderSide(color: lightGray.withOpacity(0.32), width: 1.5)), // Border on top
                  ),
                  child: SafeArea(
                    top: false, // Only apply bottom padding for home indicator
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            NavItem(
                              icon: Icons.search,
                              label: 'Explore',
                              isSelected: _selectedNavIndex == 0,
                              routeName: '/explore', // Infer route '/explore'
                              onTap: () {
                                setState(() {
                                  _selectedNavIndex = 0;
                                });
                                context.go('/explore'); // Using go_router
                              },
                            ),
                            NavItem(
                              icon: Icons.favorite_border,
                              label: 'Wishlists',
                              isSelected: _selectedNavIndex == 1,
                              routeName: '/wishlists', // Infer route '/wishlists'
                              onTap: () {
                                setState(() {
                                  _selectedNavIndex = 1;
                                });
                                context.go('/wishlists'); // Using go_router
                              },
                            ),
                            NavItem(
                              icon: Icons.send,
                              label: 'Trips',
                              isSelected: _selectedNavIndex == 2,
                              routeName: '/trips', // Infer route '/trips'
                              onTap: () {
                                setState(() {
                                  _selectedNavIndex = 2;
                                });
                                context.go('/trips'); // Using go_router
                              },
                            ),
                            NavItem(
                              icon: Icons.mail_outline,
                              label: 'Inbox',
                              isSelected: _selectedNavIndex == 3,
                              routeName: '/inbox', // Infer route '/inbox'
                              onTap: () {
                                setState(() {
                                  _selectedNavIndex = 3;
                                });
                                context.go('/inbox'); // Using go_router
                              },
                            ),
                            NavItem(
                              icon: Icons.person_outline,
                              label: 'Profile',
                              isSelected: _selectedNavIndex == 4,
                              routeName: '/profile', // Infer route '/profile'
                              onTap: () {
                                setState(() {
                                  _selectedNavIndex = 4;
                                });
                                context.go('/profile'); // Using go_router
                              },
                            ),
                          ],
                        ),
                        // Home Indicator
                        if (MediaQuery.of(context).padding.bottom > 0)
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: MediaQuery.of(context).padding.bottom * 0.2), // Adjust to appear within bottom safe area padding
                            child: Container(
                              width: 134,
                              height: 5,
                              decoration: BoxDecoration(
                                color: darkGray,
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}