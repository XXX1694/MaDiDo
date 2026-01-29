import 'package:flutter_test/flutter_test.dart';
import 'package:to_do/core/utils/hash_utils.dart';

void main() {
  group('fast Hash', () {
    test('returns same hash for same string', () {
      const testString = 'test_string_123';
      final hash1 = fastHash(testString);
      final hash2 = fastHash(testString);

      expect(hash1, equals(hash2));
    });

    test('returns different hashes for different strings', () {
      const string1 = 'first_string';
      const string2 = 'second_string';

      final hash1 = fastHash(string1);
      final hash2 = fastHash(string2);

      expect(hash1, isNot(equals(hash2)));
    });

    test('handles empty string', () {
      const emptyString = '';
      final hash = fastHash(emptyString);

      expect(hash, isNotNull);
      expect(hash, isA<int>());
    });

    test('handles single character', () {
      const singleChar = 'a';
      final hash = fastHash(singleChar);

      expect(hash, isNotNull);
      expect(hash, isA<int>());
    });

    test('handles long strings', () {
      final longString = 'a' * 1000;
      final hash = fastHash(longString);

      expect(hash, isNotNull);
      expect(hash, isA<int>());
    });

    test('handles special characters', () {
      const specialString = r'!@#$%^&*()_+-=[]{}|;:,.<>?';
      final hash = fastHash(specialString);

      expect(hash, isNotNull);
      expect(hash, isA<int>());
    });

    test('handles unicode characters', () {
      const unicodeString = 'Привет мир 你好世界 مرحبا';
      final hash = fastHash(unicodeString);

      expect(hash, isNotNull);
      expect(hash, isA<int>());
    });

    test('is deterministic for UUID-like strings', () {
      const uuid = 'c5a5d8ae-3c23-4e89-92d4-6b94c96a6b5e';
      final hash1 = fastHash(uuid);
      final hash2 = fastHash(uuid);
      final hash3 = fastHash(uuid);

      expect(hash1, equals(hash2));
      expect(hash2, equals(hash3));
    });

    test('different casing produces different hashes', () {
      const lowercase = 'hello';
      const uppercase = 'HELLO';

      final hashLower = fastHash(lowercase);
      final hashUpper = fastHash(uppercase);

      expect(hashLower, isNot(equals(hashUpper)));
    });
  });
}
