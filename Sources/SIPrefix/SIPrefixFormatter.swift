//
//  SIPrefixFormatter.swift
//  SIPrefix
//
//  Created by Koji Murata on 2020/11/17.
//

import Foundation

public struct SIPrefixFormatter {
    public struct Prefix {
        let log10: Int
        let symbol: String
    }
    
    public static let defaultPrefixes = [
        Prefix(log10: 3,  symbol: "k"),
        Prefix(log10: 6,  symbol: "M"),
        Prefix(log10: 9,  symbol: "G"),
        Prefix(log10: 12, symbol: "T"),
        Prefix(log10: 15, symbol: "P"),
        Prefix(log10: 18, symbol: "E"),
        Prefix(log10: 21, symbol: "Z"),
        Prefix(log10: 24, symbol: "Y"),
    ]
    
    public init(prefixes: [Prefix] = SIPrefixFormatter.defaultPrefixes, numberFormat: String = "%.0lf", shift: Int = 0, recursive: Bool = false) {
        self.numberFormat = numberFormat
        self.shift = shift
        self.recursive = recursive

        var sortedPrefix = prefixes.sorted(by: { $0.log10 < $1.log10 })
        if sortedPrefix[0].log10 != 0 {
            sortedPrefix.insert(Prefix(log10: 0, symbol: ""), at: 0)
        }
        
        var result = [Prefix]()
        for i in 0..<sortedPrefix.count {
            let prefix = sortedPrefix[i]
            if i == sortedPrefix.count - 1 {
                result.append(prefix)
                break
            }
            let length = sortedPrefix[i + 1].log10 - prefix.log10
            result.append(contentsOf: Array(repeating: prefix, count: length))
        }
        self.prefixes = result
    }
    
    private let prefixes: [Prefix]
    private let numberFormat: String
    private let shift: Int
    private let recursive: Bool
    
    public func format(_ value: Int) -> String {
        let tmp = log10(Double(abs(value)))
        let log10 = Int(floor(tmp))
        let prefixIndex = log10 + shift
        let prefix: Prefix
        switch prefixIndex {
        case ..<0:
            prefix = prefixes[0]
        case prefixes.count...:
            prefix = prefixes.last!
        default:
            prefix = prefixes[prefixIndex]
        }
        let number = Double(value) / pow(10, Double(prefix.log10))
        let formattedNumber: String
        if recursive && prefix.log10 != 0 {
            formattedNumber = format(Int(round(number)))
        } else {
            formattedNumber = String(format: numberFormat, number)
        }
        return String(
            format: "%@%@",
            formattedNumber,
            prefix.symbol
        )
    }
}
