import SwiftUI

// Centralized color palette for Light/Dark themes
enum AppColors {
    // MARK: - Public dynamic colors
    static let background: Color = .dynamic(lightHex: "#F2F2F7", darkHex: "#1C1C1E")
    static let secondaryBackground: Color = .dynamic(lightHex: "#FFFFFF", darkHex: "#2C2C2E")
    static let primaryText: Color = .dynamic(lightHex: "#000000", darkHex: "#FFFFFF")
    static let secondaryText: Color = .dynamic(lightHex: "#636366", darkHex: "#AEAEB2")
    static let accent: Color = .dynamic(lightHex: "#007AFF", darkHex: "#0A84FF")
    static let success: Color = .dynamic(lightHex: "#34C759", darkHex: "#32D74B")
    static let danger: Color = .dynamic(lightHex: "#FF3B30", darkHex: "#FF453A")
    static let warning: Color = .dynamic(lightHex: "#FF9500", darkHex: "#FF9F0A")
    static let icon: Color = .dynamic(lightHex: "#8E8E93", darkHex: "#98989E")
    static let button: Color = .dynamic(lightHex: "#007AFF", darkHex: "#0A84FF")
    static let buttonTapped: Color = .dynamic(lightHex: "#0059C3", darkHex: "006EDF")

    static let cardBackGround: Color = .dynamic(lightHex: "#FFFFFF", darkHex: "#2C2C2E")
    static let cardText: Color = .dynamic(lightHex: "#1C1C1E", darkHex: "#F2F2F7")
    
    static let accentBlue = Color(red: 0.24,green: 0.52, blue: 1.0)
}

// MARK: - Helpers
extension Color {
    /// Create a dynamic Color that switches between light and dark variants
    static func dynamic(lightHex: String, darkHex: String) -> Color {
        let light = UIColor(hex: lightHex)
        let dark = UIColor(hex: darkHex)
        return Color(UIColor { traits in
            traits.userInterfaceStyle == .dark ? dark : light
        })
    }
}

extension UIColor {
    /// Initialize UIColor from hex string like "#RRGGBB" or "#RRGGBBAA"
    convenience init(hex: String) {
        var sanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        if sanitized.hasPrefix("#") { sanitized.removeFirst() }

        var rgba: UInt64 = 0
        Scanner(string: sanitized).scanHexInt64(&rgba)

        let r, g, b, a: CGFloat
        switch sanitized.count {
        case 6:
            r = CGFloat((rgba & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgba & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgba & 0x0000FF) / 255.0
            a = 1.0
        case 8:
            r = CGFloat((rgba & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgba & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgba & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgba & 0x000000FF) / 255.0
        default:
            r = 0; g = 0; b = 0; a = 1
        }
        self.init(red: r, green: g, blue: b, alpha: a)
    }
}


