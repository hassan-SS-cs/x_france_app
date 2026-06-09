import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gal/gal.dart';
import 'package:url_launcher/url_launcher.dart';

class Attraction {
  final String name;
  final String description;
  final String imageUrl;
  final double dx;
  final double dy;
  final double lat;
  final double lng;

  Attraction({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.dx,
    required this.dy,
    required this.lat,
    required this.lng,
  });
}

final List<Attraction> attractions = [
  Attraction(
    name: 'Eiffel Tower',
    description:
        'The Eiffel Tower is a wrought-iron lattice tower on the Champ de Mars in Paris.',
    imageUrl: 'https://picsum.photos/seed/eiffel/400/300',
    dx: 0.38,
    dy: 0.45,
    lat: 48.8584,
    lng: 2.2945,
  ),
  Attraction(
    name: 'Louvre Museum',
    description:
        'The Louvre is the world\'s most-visited art museum, located in Paris.',
    imageUrl: 'https://picsum.photos/seed/louvre/400/300',
    dx: 0.42,
    dy: 0.38,
    lat: 48.8606,
    lng: 2.3376,
  ),
  Attraction(
    name: 'Mont Saint-Michel',
    description: 'A tidal island and mainland commune in Normandy, France.',
    imageUrl: 'https://picsum.photos/seed/mont/400/300',
    dx: 0.22,
    dy: 0.28,
    lat: 48.6361,
    lng: -1.5115,
  ),
  Attraction(
    name: 'Palace of Versailles',
    description:
        'A royal château in Versailles, known for its Hall of Mirrors.',
    imageUrl: 'https://picsum.photos/seed/versailles/400/300',
    dx: 0.40,
    dy: 0.48,
    lat: 48.8049,
    lng: 2.1204,
  ),
];

class DrawnLine {
  final List<Offset> points;
  DrawnLine(this.points);
}

class MapPainter extends CustomPainter {
  final List<DrawnLine> lines;
  final List<Offset> currentLine;

  MapPainter({required this.lines, required this.currentLine});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    for (final line in lines) {
      for (int i = 0; i < line.points.length - 1; i++) {
        canvas.drawLine(line.points[i], line.points[i + 1], paint);
      }
    }
    for (int i = 0; i < currentLine.length - 1; i++) {
      canvas.drawLine(currentLine[i], currentLine[i + 1], paint);
    }
  }

  @override
  bool shouldRepaint(MapPainter oldDelegate) => true;
}

class TravelPage extends StatefulWidget {
  const TravelPage({super.key});

  @override
  State<TravelPage> createState() => _TravelPageState();
}

class _TravelPageState extends State<TravelPage> {
  final GlobalKey _repaintKey = GlobalKey();
  bool _isDrawing = false;
  final List<DrawnLine> _lines = [];
  List<Offset> _currentLine = [];

  void _onPanStart(DragStartDetails details) {
    if (!_isDrawing) return;
    setState(() => _currentLine = [details.localPosition]);
  }

  void _onPanUpdate(DragUpdateDetails details) {
    if (!_isDrawing) return;
    setState(() => _currentLine.add(details.localPosition));
  }

  void _onPanEnd(DragEndDetails details) {
    if (!_isDrawing) return;
    setState(() {
      _lines.add(DrawnLine(List.from(_currentLine)));
      _currentLine = [];
    });
  }

  Future<void> _saveImage() async {
    final boundary =
        _repaintKey.currentContext?.findRenderObject()
            as RenderRepaintBoundary?;
    if (boundary == null) return;
    final image = await boundary.toImage(pixelRatio: 3.0);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final bytes = byteData!.buffer.asUint8List();
    await Gal.putImageBytes(bytes);
    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Map saved to gallery!')));
    }
  }

  void _showAttractionDialog(Attraction attraction) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        insetPadding: EdgeInsets.all(20),
        child: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: LongPressDraggable<String>(
                        data: attraction.name,
                        feedback: Material(
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              attraction.name,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        child: Text(
                          attraction.name,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => Dialog(
                        insetPadding: EdgeInsets.zero,
                        child: Stack(
                          children: [
                            InteractiveViewer(
                              child: Image.network(
                                attraction.imageUrl,
                                fit: BoxFit.contain,
                              ),
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: IconButton(
                                icon: Icon(Icons.close, color: Colors.white),
                                onPressed: () => Navigator.of(ctx).pop(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: Image.network(
                    attraction.imageUrl,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    attraction.description,
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                Center(
                  child: TextButton(
                    onPressed: () async {
                      final url = Uri.parse(
                        'https://www.google.com/maps/search/?api=1&query=${attraction.lat},${attraction.lng}',
                      );
                      await launchUrl(
                        url,
                        mode: LaunchMode.externalApplication,
                      );
                    },
                    child: Text(
                      'Go Now!',
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.blue,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Popular Locations',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.draw,
              color: _isDrawing ? Colors.blue : Colors.black,
            ),
            onPressed: () => setState(() => _isDrawing = !_isDrawing),
          ),
          IconButton(icon: Icon(Icons.save), onPressed: _saveImage),
        ],
      ),
      body: RepaintBoundary(
        key: _repaintKey,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final mapWidth = constraints.maxWidth;
            final mapHeight = constraints.maxHeight;

            return InteractiveViewer(
              panEnabled: !_isDrawing,
              minScale: 1.0,
              maxScale: 5.0,
              child: SizedBox(
                width: mapWidth,
                height: mapHeight,
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/france_map.png',
                      width: mapWidth,
                      height: mapHeight,
                      fit: BoxFit.cover,
                    ),
                    GestureDetector(
                      onPanStart: _onPanStart,
                      onPanUpdate: _onPanUpdate,
                      onPanEnd: _onPanEnd,
                      child: CustomPaint(
                        painter: MapPainter(
                          lines: _lines,
                          currentLine: _currentLine,
                        ),
                        size: Size(mapWidth, mapHeight),
                      ),
                    ),
                    ...attractions.map((attraction) {
                      return Positioned(
                        left: attraction.dx * mapWidth - 16,
                        top: attraction.dy * mapHeight - 16,
                        child: GestureDetector(
                          onTap: () => _showAttractionDialog(attraction),
                          child: Icon(
                            Icons.location_on,
                            color: Colors.red,
                            size: 32,
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}