import SwiftUI

/// Unique visual identity for Matchbook Log: struck-match orange on charcoal ash.
enum Theme {
    static let accent = Color(hex: "#C1451E")
    static let accentSecondary = Color(hex: "#2E2A26")
    static let background = Color(hex: "#F2E9DC")
    static let ink = Color(hex: "#241F1B")

    static var titleFont: Font {
        Font.system(.largeTitle, design: .default).weight(.bold)
    }

    static var bodyFont: Font {
        Font.system(.body, design: .default)
    }

    static var cardCornerRadius: CGFloat { 18 }
}

extension Color {
    init(hex: String) {
        let s = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var v: UInt64 = 0
        Scanner(string: s).scanHexInt64(&v)
        let r = Double((v >> 16) & 0xFF) / 255.0
        let g = Double((v >> 8) & 0xFF) / 255.0
        let b = Double(v & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b)
    }
}
