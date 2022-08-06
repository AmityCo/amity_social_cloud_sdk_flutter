import 'dart:convert';
import 'dart:typed_data';

class BloomFilter {
  static final SEED = 1576284489;

  final Uint8List buckets;
  final int m;
  final int k;

  BloomFilter({required this.buckets, required this.m, required this.k});

  bool mightContains(String element) {
    Uint8List locations = locationFor(base64.decode(element));

    for (int i = 0; i < k; i++) {
      int location = locations[i];
      int index = (location / 8).floor();
      if ((buckets[index] & 1 << (location % 8)) == 0) {
        return false;
      }
    }

    return true;
  }

  Uint8List locationFor(Uint8List buf) {
    int hash1 = new EkoFnv1a().hash(buf, 0);
    int hash2 = new EkoFnv1a().hash(buf, SEED);

    final locations = Uint8List(k);
    int location = hash1 % m;

    for (int i = 0; i < k; i++) {
      locations[i] = location < 0 ? (location + m) : location;
      location = (location + hash2) % m;
    }

    return locations;
  }
}

class EkoFnv1a implements HashFunction {
  static final FNV1_32_INIT = 0x811c9dc5;

  // @Override
  //  int hash(Uint8List buf, int seed) {
  //     int hash = (int) FNV1_32_INIT ^ seed;
  //     for (byte b : buf) {
  //         hash = multiply(hash ^ b);
  //     }
  //     return mix(hash);
  // }

  int multiply(int a) {
    return a + (a << 1) + (a << 4) + (a << 7) + (a << 8) + (a << 24);
  }

  int mix(int a) {
    a += a << 13;
    a ^= a >>> 7;
    a += a << 3;
    a ^= a >>> 17;
    a += a << 5;
    return a;
  }

  @override
  int hash(List<int> buf, int seed) {
    int hash = FNV1_32_INIT ^ seed;
    for (int b in buf) {
      hash = multiply(hash ^ b);
    }
    return mix(hash);
  }
}

abstract class HashFunction {
  int hash(Uint8List buf, int seed);
}
