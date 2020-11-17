# SIPrefix [![Build Status](https://github.com/malt03/SIPrefix/workflows/Test/badge.svg)](https://travis-ci.org/malt03/SIPrefix) [![SwiftPM compatible](https://img.shields.io/badge/SwiftPM-compatible-4BC51D.svg)](https://github.com/apple/swift-package-manager) ![Cocoapods](https://img.shields.io/cocoapods/v/SIPrefix) ![License](https://img.shields.io/github/license/malt03/SIPrefix.svg)

SIPrefix is a library for formatting numbers using [SI prefixes](https://en.wikipedia.org/wiki/Metric_prefix#List_of_SI_prefixes).

## Usage

### Simple

```swift
let formatter = SIPrefixFormatter()
formatter.format(1) // "1"
formatter.format(23) // "23"
formatter.format(345) // "345"
formatter.format(4_567) // "5k"
formatter.format(56_789) // "57k"
formatter.format(678_901) // "679k"
formatter.format(7_890_123) // "8M"
formatter.format(89_012_345) // "89M"
formatter.format(901_234_567) // "901M"
```

### Advanced
- Custom prefixes can be used.
- You can shift the prefix to be used, and then change the format of the number to display it as a decimal point.

See the [test cases](https://github.com/malt03/SIPrefix/blob/main/Tests/SIPrefixTests/SIPrefixTests.swift) for details..
