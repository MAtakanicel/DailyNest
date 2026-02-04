# DailyNest

![Language](https://img.shields.io/badge/Dil-Swift-F05138)
![Platform](https://img.shields.io/badge/Platform-iOS_17.0+-000000)
![Framework](https://img.shields.io/badge/Framework-SwiftUI-007AFF)
![Architecture](https://img.shields.io/badge/Mimari-MVVM-green)
![Storage](https://img.shields.io/badge/Veri_Tabanı-SwiftData-purple)

**DailyNest**, günlük görevleri ve tekrar eden rutinleri birbirinden ayırarak yönetmenizi sağlayan, modern iOS teknolojileriyle geliştirilmiş minimalist bir üretkenlik uygulamasıdır. Kullanıcı dostu arayüzü ve güçlü yerel veri yönetimi ile alışkanlık kazanımını kolaylaştırmayı hedefler.

## 📱 Ekran Görüntüleri (En kısa sürede)

## ✨ Özellikler

* **Ayrıştırılmış Görev Yönetimi:** Tek seferlik **Günlük Görevler** ve tekrar eden **Rutinler** için özelleştirilmiş ayrı veri modelleri.
* **Akıllı İlerleme Takibi:** Günlük tamamlanma oranını dinamik olarak hesaplayan ve görselleştiren dairesel ilerleme kartı (Progress Card).
* **Dinamik Filtreleme:** Görevleri "Tümü" veya "Yapılacaklar" şeklinde filtreleme ve arama özelliği.
* **Modern Arayüz Bileşenleri:**
    * Glassmorphism (Buzlu Cam) efektli özel "Floating Tab Bar".
    * Akıcı animasyonlar ve geçişler.
    * Tıklanabilir ve kaydırılabilir liste elemanları.
* **SwiftData Entegrasyonu:** CoreData yerine Apple'ın en yeni veri çerçevesi kullanılarak performanslı, güvenli ve modern veri saklama.

## 🛠 Teknoloji Yığını & Mimari

Proje, **Clean Architecture** prensipleri gözetilerek **MVVM (Model-View-ViewModel)** tasarım deseniyle geliştirilmiştir.

* **SwiftUI:** Arayüz geliştirme için deklaratif framework.
* **SwiftData:** Veri tabanı yönetimi için `@Model`, `@Query` ve `ModelContext` yapıları kullanıldı.
* **Decoupled Components:** Arayüz bileşenleri (örn: `ProgressCard`), veriden bağımsız ("dumb component") tasarlanarak yeniden kullanılabilirlik artırıldı.
* **SOLID Prensipleri:** View (Arayüz) ve ViewModel (Mantık) katmanları arasında kesin sorumluluk ayrımı yapıldı.
