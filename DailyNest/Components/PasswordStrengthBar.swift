import SwiftUI

enum PasswordStrength: Int, CaseIterable {
    case veryWeak = 0, weak = 1, medium = 2, strong = 3, veryStrong = 4

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
    let length = password.count
    
    let hasUpper = password.contains(where: { $0.isUppercase })
    let hasSpecial = password.contains(where: { !$0.isLetter && !$0.isNumber })
    
    
    if length >= 12 && hasUpper && hasSpecial {
        return .veryStrong
    } else if length >= 8 && hasUpper && hasSpecial {
        return .strong
    } else if length >= 8 && (hasUpper || hasSpecial) {
        return .medium
    } else if length >= 8 {
        return .weak
    } else {
        return .veryWeak
    }
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
