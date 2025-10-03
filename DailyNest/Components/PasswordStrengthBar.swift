import SwiftUI

enum PasswordStrength: Int, CaseIterable {
    case veryWeak = 1, weak = 2, medium = 3, strong = 4, veryStrong = 5

    var title: String {
        switch self {
  
        case .veryWeak: return "Yeterince Güçlü değil"
        case .weak: return "Zayıf"
        case .medium: return "Orta"
        case .strong: return "Güçlü"
        case .veryStrong: return "Çok Güçlü"
        }
    }

    var color: Color {
        switch self {
        case .veryWeak: return .red
        case .weak: return .orange
        case .medium: return .yellow
        case .strong: return .green
        case .veryStrong: return .green
        }
    }

    var progress: Double {
        Double(rawValue + 1) / Double(PasswordStrength.allCases.count + 1)
    }
}

func evaluateStrength(_ password: String) -> PasswordStrength {
    var score = 0

    // Uzunluk
    if password.count >= 8 { score += 1 }
    if password.count >= 12 { score += 1 }

    // Karakter çeşitliliği
    let hasLower = password.range(of: "[a-z]", options: .regularExpression) != nil
    let hasUpper = password.range(of: "[A-Z]", options: .regularExpression) != nil
    let hasDigit = password.range(of: "[0-9]", options: .regularExpression) != nil
    let hasSpecial = password.range(of: "[^A-Za-z0-9]", options: .regularExpression) != nil

    let diversity = [hasLower, hasUpper, hasDigit, hasSpecial].filter { $0 }.count
    if diversity >= 2 { score += 1 }
    if diversity >= 3 { score += 1 }

    return PasswordStrength(rawValue: min(score, 4)) ?? .veryWeak
}

// MARK: - UI Component
struct PasswordStrengthBar: View {
    let strength: PasswordStrength

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Segmentli bar
            HStack(spacing: 6) {
                ForEach(0..<4, id: \.self) { index in
                    RoundedRectangle(cornerRadius: 4)
                        .fill(index <= strength.rawValue - 1 ? strength.color : Color.gray.opacity(0.2))
                        .frame(height: 8)
                }
            }
            .accessibilityLabel(Text("Şifre gücü seviyesi"))

            Text("Şifre gücü: \(strength.title)")
                .font(.footnote)
                .foregroundColor(strength.color)
                .accessibilityHint(Text("Daha güçlü bir şifre için büyük/küçük harf, rakam ve özel karakter ekleyin."))
        }
    }
}

#Preview {
    PasswordStrengthBar(strength: .medium)
}
