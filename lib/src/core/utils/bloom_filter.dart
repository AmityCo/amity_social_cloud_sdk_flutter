import 'dart:convert';

import 'package:fixnum/fixnum.dart';

/// BloomFilter for hash flag
class BloomFilter {
  /// Seed for bloom filter
  static final SEED = 1576284489;

  /// byte array for hash
  late List<int> buckets;

  /// bite size
  final int m;

  /// hashes count
  final int k;

  /// init [BloomFilter]
  BloomFilter({required String hash, required this.m, required this.k}) {
    buckets = base64Decode(hash);
  }

  /// Might Contains
  bool mightContains(String element) {
    List<int> locations = locationFor(element.codeUnits);

    for (int i = 0; i < k; i++) {
      int location = locations[i];
      int index = (location / 8).floor();
      if ((buckets[index] & 1 << (location % 8)) == 0) {
        return false;
      }
    }

    return true;
  }

  /// get the location in bucket
  List<int> locationFor(List<int> buf) {
    int hash1 = EkoFnv1a().hash(buf, 0).toInt();
    int hash2 = EkoFnv1a().hash(buf, SEED).toInt();

    List<int> locations = List.filled(k, 0);
    int location = hash1 % m;

    for (int i = 0; i < k; i++) {
      locations[i] = location < 0 ? (location + m) : location;
      location = (location + hash2) % m;
    }

    return locations;
  }
}

/// EkoFnv1a
class EkoFnv1a {
  static final FNV1_64_INIT = 0x811c9dc5;

  /// Hash
  Int32 hash(List<int> buf, int seed) {
    Int32 hash = Int32(FNV1_64_INIT ^ seed);
    for (int b in buf) {
      hash = multiply(hash ^ b).toInt32();
    }
    return mix(hash).toInt32();
  }

  /// Multiply
  IntX multiply(IntX a) {
    return a + (a << 1) + (a << 4) + (a << 7) + (a << 8) + (a << 24);
  }

  ///Mix
  IntX mix(IntX a) {
    a += a << 13;
    a ^= a.shiftRightUnsigned(7);
    a += a << 3;
    a ^= a.shiftRightUnsigned(17);
    a += a << 5;
    return a;
  }
}
