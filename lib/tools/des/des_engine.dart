import 'dart:math';

import 'package:flutter_waya/flutter_waya.dart';

abstract class Engine {
  void init(bool forEncryption, List<int> key);

  List<int> process(List<int> dataWords);

  void reset();
}

abstract class BaseEngine implements Engine {
  bool forEncryption;
  List<int> key;

  @override
  void init(bool forEncryption, List<int> key) {
    this.key = key;
    this.forEncryption = forEncryption;
  }

  @override
  Future<void> reset() async {
    key = null;
    forEncryption = false;
  }

  int processBlock(List<int> M, int offset);

  @override
  List<int> process(List<int> dataWords) {
    const int blockSize = 2;
    if (forEncryption) _pkc7Pad(dataWords, blockSize);
    const bool doFlush = false;
    final int dataSigBytes = dataWords.length;
    const int blockSizeBytes = blockSize * 4;
    const int minBufferSize = 0;

    ///  Count blocks ready
    int nBlocksReady = dataSigBytes ~/ blockSizeBytes;
    if (doFlush) {
      ///  Round up to include partial blocks
      nBlocksReady = nBlocksReady.ceil();
    } else {
      ///  Round down to include only full blocks,
      ///  less the number of blocks that must remain in the buffer
      nBlocksReady = max((nBlocksReady | 0) - minBufferSize, 0);
    }

    ///  Count words ready
    final int nWordsReady = nBlocksReady * blockSize;

    ///  Count bytes ready
    final int nBytesReady = min(nWordsReady * 4, dataSigBytes);

    ///  Process blocks
    List<int> processedWords;
    if (nWordsReady != 0) {
      for (int offset = 0; offset < nWordsReady; offset += blockSize) {
        ///  Perform concrete-algorithm logic
        processBlock(dataWords, offset);
      }

      ///  Remove processed words
      processedWords = dataWords.getRange(0, nWordsReady).toList();
      dataWords.removeRange(0, nWordsReady);
    }

    final List<int> result = nBytesReady
        .generate((int i) => i < processedWords.length ? processedWords[i] : 0);

    if (!forEncryption) _pkc7UnPad(result, blockSize);
    return result;
  }
}

class DESEngine extends BaseEngine {
  List<List<int>> _subKeys;
  int _lBlock;
  int _rBlock;

  String get algorithmName => 'DES';

  int get blockSize => 64 ~/ 32;

  @override
  Future<void> init(bool forEncryption, List<int> key) async {
    super.init(forEncryption, key);

    ///  Select 56 bits according to pc1
    final List<int> keyBits = List<int>(56);
    for (int i = 0; i < 56; i++) {
      final int keyBitPos = pc1[i] - 1;
      keyBits[i] = (this
              .key[keyBitPos.rightShift32(5)]
              .rightShift32((31 - keyBitPos % 32).toInt())) &
          1;
    }

    ///  Assemble 16 subKeys
    final List<List<int>> subKeys = _subKeys = 16.generate((_) => <int>[]);
    for (int nSubKey = 0; nSubKey < 16; nSubKey++) {
      ///  Create subKey
      final List<int> subKey =
          subKeys[nSubKey] = List<int>.generate(24, (_) => 0);

      ///  Shortcut
      final int bitShift = bitShifts[nSubKey];

      ///  Select 48 bits according to pc2
      for (int i = 0; i < 24; i++) {
        ///  Select from the left 28 key bits
        subKey[(i ~/ 6) | 0] |= keyBits[((pc2[i] - 1) + bitShift) % 28]
            .leftShift32((31 - i % 6).toInt());

        ///  Select from the right 28 key bits
        subKey[4 + ((i ~/ 6) | 0)] |=
            keyBits[28 + (((pc2[i + 24] - 1) + bitShift) % 28)]
                .leftShift32((31 - i % 6).toInt());
      }

      ///  Since each subKey is applied to an expanded 32-bit input,
      ///  the subKey can be broken into 8 values scaled to 32-bits,
      ///  which allows the key to be used without expansion
      subKey[0] = (subKey[0] << 1).toSigned(32) | subKey[0].rightShift32(31);
      for (int i = 1; i < 7; i++) {
        subKey[i] = subKey[i].rightShift32(((i - 1) * 4 + 3).toInt());
      }
      subKey[7] = (subKey[7] << 5).toSigned(32) | (subKey[7].rightShift32(27));
    }
  }

  @override
  int processBlock(List<int> M, int offset) {
    final List<List<int>> invSubKeys = List<List<int>>(16);
    if (!forEncryption) {
      for (int i = 0; i < 16; i++) invSubKeys[i] = _subKeys[15 - i];
    }

    final List<List<int>> subKeys = forEncryption ? _subKeys : invSubKeys;

    _lBlock = M[offset].toSigned(32);
    _rBlock = M[offset + 1].toSigned(32);

    ///  Initial permutation
    exchangeLR(4, 0x0f0f0f0f);
    exchangeLR(16, 0x0000ffff);
    exchangeRL(2, 0x33333333);
    exchangeRL(8, 0x00ff00ff);
    exchangeLR(1, 0x55555555);

    ///  Rounds
    for (int round = 0; round < 16; round++) {
      ///  Shortcuts
      final List<int> subKey = subKeys[round];
      final int lBlock = _lBlock;
      final int rBlock = _rBlock;

      ///  Feistel function
      int f = 0.toSigned(32);
      for (int i = 0; i < 8; i++) {
        (f |= (sBoxP[i][((rBlock ^ subKey[i]).toSigned(32) & sBoxMask[i])
                    .toUnsigned(32)])
                .toSigned(32))
            .toSigned(32);
      }
      _lBlock = rBlock.toSigned(32);
      _rBlock = (lBlock ^ f).toSigned(32);
    }

    ///  Undo swap from last round
    final int t = _lBlock;
    _lBlock = _rBlock;
    _rBlock = t;

    ///  Final permutation
    exchangeLR(1, 0x55555555);
    exchangeRL(8, 0x00ff00ff);
    exchangeRL(2, 0x33333333);
    exchangeLR(16, 0x0000ffff);
    exchangeLR(4, 0x0f0f0f0f);

    ///  Set output
    M[offset] = _lBlock;
    M[offset + 1] = _rBlock;
    return blockSize;
  }

  @override
  Future<void> reset() async {
    forEncryption = false;
    key = null;
    _subKeys = null;
    _lBlock = null;
    _rBlock = null;
  }

  ///  Swap bits across the left and right words
  void exchangeLR(int offset, int mask) {
    final int t =
        (((_lBlock.rightShift32(offset)).toSigned(32) ^ _rBlock) & mask)
            .toSigned(32);
    (_rBlock ^= t).toSigned(32);
    _lBlock ^= (t << offset).toSigned(32);
  }

  void exchangeRL(int offset, int mask) {
    final int t = ((_rBlock.rightShift32(offset).toSigned(32) ^ _lBlock) & mask)
        .toSigned(32);
    (_lBlock ^= t).toSigned(32);
    _rBlock ^= (t << offset).toSigned(32);
  }
}

class DES3Engine extends BaseEngine {
  int get blockSize => 64 ~/ 32;

  @override
  int processBlock(List<int> M, int offset) {
    final DESEngine des1 = DESEngine();
    final DESEngine des2 = DESEngine();
    final DESEngine des3 = DESEngine();
    if (forEncryption) {
      des1.init(true, key.sublist(0, 2));
      des1.processBlock(M, offset);
      des2.init(false, key.sublist(2, 4));
      des2.processBlock(M, offset);
      des3.init(true, key.sublist(4, 6));
      des3.processBlock(M, offset);
    } else {
      des3.init(false, key.sublist(4, 6));
      des3.processBlock(M, offset);
      des2.init(true, key.sublist(2, 4));
      des2.processBlock(M, offset);
      des1.init(false, key.sublist(0, 2));
      des1.processBlock(M, offset);
    }
    return blockSize;
  }
}

void _pkc7Pad(List<int> data, int blockSize) {
  final int blockSizeBytes = blockSize * 4;

  ///  Count padding bytes
  final int nPaddingBytes = blockSizeBytes - data.length % blockSizeBytes;

  ///  Create padding word
  final int paddingWord = (nPaddingBytes << 24) |
      (nPaddingBytes << 16) |
      (nPaddingBytes << 8) |
      nPaddingBytes;

  ///  Create padding
  final List<int> paddingWords = <int>[];
  for (int i = 0; i < nPaddingBytes; i += 4) paddingWords.add(paddingWord);
  final List<int> padding = nPaddingBytes
      .generate((int i) => i < paddingWords.length ? paddingWords[i] : 0);

  ///  Add padding
  _concat(data, padding);
}

void _pkc7UnPad(List<int> data, int blockSize) {
  final int sigBytes = data.length;
  final int nPaddingBytes = data[(sigBytes - 1).rightShift32(2)] & 0xff;
  data.length -= nPaddingBytes;
}

void _concat(List<int> a, List<int> b) {
  ///  Shortcuts
  final List<int> thisWords = a;
  final List<int> thatWords = b;
  final int thisSigBytes = a.length;
  final int thatSigBytes = b.length;

  ///  Clamp excess bits
  _clamp(a);

  ///  Concat
  if (thisSigBytes % 4 != 0) {
    ///  Copy one byte at a time
    for (int i = 0; i < thatSigBytes; i++) {
      final int thatByte = (thatWords[i >> 2] >> (24 - (i % 4) * 8)) & 0xff;
      final int idx = (thisSigBytes + i) >> 2;
      _expandList(thisWords, idx + 1);
      thisWords[idx] |= thatByte << (24 - ((thisSigBytes + i) % 4) * 8);
    }
  } else {
    ///  Copy one word at a time
    for (int i = 0; i < thatSigBytes; i += 4) {
      final int idx = (thisSigBytes + i) >> 2;
      if (idx >= thisWords.length) thisWords.length = idx + 1;
      thisWords[idx] = thatWords[i >> 2];
    }
  }
  a.length = thisSigBytes + thatSigBytes;
}

void _expandList(List<int> data, int newLength) {
  if (newLength <= data.length) return;

  ///  update the length
  data.length = newLength;

  ///  replace any new allocations with 0
  for (int i = 0; i < data.length; i++) {
    if (data[i] == null) data[i] = 0;
  }
}

void _clamp(List<int> data) {
  ///  Shortcuts
  final List<int> words = data;
  final int sigBytes = data.length;

  ///  Clamp
  words[sigBytes.rightShift32(2)] &=
      (0xffffffff << (32 - (sigBytes % 4) * 8)).toSigned(32);
  words.length = (sigBytes / 4).ceil();
}
