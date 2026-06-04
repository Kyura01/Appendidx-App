import 'dart:io';
import 'package:image/image.dart' as img;

void main() {
  const inputPath = 'assets/Logo.jpeg';
  const outputPath = 'assets/Logo_rounded.png';

  final inputFile = File(inputPath);
  if (!inputFile.existsSync()) {
    stderr.writeln('Input not found: $inputPath');
    exit(1);
  }

  final bytes = inputFile.readAsBytesSync();
  final decoded = img.decodeImage(bytes);
  if (decoded == null) {
    stderr.writeln('Failed to decode image: $inputPath');
    exit(1);
  }

  final size = decoded.width < decoded.height ? decoded.width : decoded.height;
  final cropX = (decoded.width - size) ~/ 2;
  final cropY = (decoded.height - size) ~/ 2;
  final square = img.copyCrop(decoded, x: cropX, y: cropY, width: size, height: size);

  final radius = (size * 0.23).round();
  final radiusSquared = radius * radius;
  final rounded = img.Image(width: size, height: size, numChannels: 4);

  for (var y = 0; y < size; y++) {
    for (var x = 0; x < size; x++) {
      final inCorner = (x < radius && y < radius) ||
          (x >= size - radius && y < radius) ||
          (x < radius && y >= size - radius) ||
          (x >= size - radius && y >= size - radius);

      if (inCorner) {
        final cx = x < radius ? radius : size - radius - 1;
        final cy = y < radius ? radius : size - radius - 1;
        final dx = x - cx;
        final dy = y - cy;
        if (dx * dx + dy * dy > radiusSquared) {
          rounded.setPixelRgba(x, y, 0, 0, 0, 0);
          continue;
        }
      }

      final pixel = square.getPixel(x, y);
      rounded.setPixel(x, y, pixel);
    }
  }

  final png = img.encodePng(rounded);
  File(outputPath)
    ..createSync(recursive: true)
    ..writeAsBytesSync(png);

  stdout.writeln('Wrote $outputPath (${rounded.width}x${rounded.height})');
}
