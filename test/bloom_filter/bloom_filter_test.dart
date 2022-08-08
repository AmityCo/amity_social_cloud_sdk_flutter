import 'dart:convert';

import 'package:amity_sdk/src/core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Bloom Filter Test', () {
    String? userId;

    BloomFilter? bloomFilter;

    EkoFnv1a? fnv1a;
    // 1.
    setUp(() async {
      userId = 'a';
      fnv1a = EkoFnv1a();
      bloomFilter = BloomFilter(hash: 'ivr1q6o=', m: 40, k: 14);
    });

    test('Test Bloom Filter Hashes', () async {
      expect(-649420593, fnv1a!.hash(utf8.encode("a"), 0));
      expect(1477868974, fnv1a!.hash(utf8.encode("a"), BloomFilter.SEED));
      expect(1612769824, fnv1a!.hash(utf8.encode("b"), 0));
      expect(1058207413, fnv1a!.hash(utf8.encode("b"), BloomFilter.SEED));
    });

    // 2.
    test('Test Bloom Filter with a', () async {
      expect(bloomFilter!.mightContains('a'), true);
      expect(bloomFilter!.mightContains('b'), false);
      expect(bloomFilter!.mightContains('c'), true);
      expect(bloomFilter!.mightContains('d'), false);
    });

    // 3.
    tearDown(() async {
      userId = '';
    });
  });
}
