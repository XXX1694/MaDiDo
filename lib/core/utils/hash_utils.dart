/// Utility functions for hashing operations
library;

/// Fast hash function using FNV-1a algorithm
/// Used for converting string IDs to integer IDs for Isar database
int fastHash(String string) {
  var hash = BigInt.parse('0xcbf29ce484222325').toInt();

  var i = 0;
  while (i < string.length) {
    final codeUnit = string.codeUnitAt(i++);
    hash ^= codeUnit >> 8;
    hash *= BigInt.parse('0x100000001b3').toInt();
    hash ^= codeUnit & 0xFF;
    hash *= BigInt.parse('0x100000001b3').toInt();
  }

  return hash;
}
