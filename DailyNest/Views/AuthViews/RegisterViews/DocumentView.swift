
import SwiftUI
import Foundation

func loadTextFile(named fileName: String) -> String {
    if let url = Bundle.main.url(forResource: fileName, withExtension: "txt"),
       let content = try? String(contentsOf: url, encoding: .utf8) {
        return content
    }
    return "Dosya bulunamadı veya okunamadı."
}

struct DocumentView: View {

    let fileName : String
    var body: some View {
        
        ScrollView{
            Text(loadTextFile(named: fileName))
                .padding()
                .font(.body)
                .multilineTextAlignment(.leading)
                .background(Rectangle()
                    .fill(AppColors.background)
                    .frame(minWidth: 100,minHeight: 100)
                    .cornerRadius(25)
                )
        }.padding(15)
            .background(AppColors.secondaryBackground)
        
    }
}

#Preview {
    DocumentView(fileName: "privacy")
}
