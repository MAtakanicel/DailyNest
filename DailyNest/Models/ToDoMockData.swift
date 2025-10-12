
import Foundation

struct MockData{
    static let mockData: [ToDo] = [
        ToDo(id: UUID(), title: "Sabah Sporu", detail: "10 dakika esneme", date: nil, createdAt: .now, updateAt: nil, isRoutine: true, routineDays: [.monday, .wednesday, .friday], isCompleted: true, completedAt: nil, priority: .high,reminderDate: nil, isReminderOn: false),
        ToDo(id: UUID(), title: "Kitap Okuma", detail: "Her gün 15 sayfa", date: nil, createdAt: .now, updateAt: nil, isRoutine: true, routineDays: WeekDay.allCases, isCompleted: true, completedAt: nil, priority: .medium,reminderDate: nil, isReminderOn: false),
        ToDo(id: UUID(), title: "Meditasyon", detail: "10 dk sessiz oturma", date: nil, createdAt: .now, updateAt: nil, isRoutine: true, routineDays: [.tuesday, .thursday], isCompleted: false, completedAt: nil, priority: .medium),
        ToDo(id: UUID(), title: "Su Takibi", detail: "2 litre su iç", date: nil, createdAt: .now, updateAt: nil, isRoutine: true, routineDays: WeekDay.allCases, isCompleted: false, completedAt: nil, priority: .low,reminderDate: nil, isReminderOn: false),
        ToDo(id: UUID(), title: "Vitamin Al", detail: "Sabah vitamin unutma", date: nil, createdAt: .now, updateAt: nil, isRoutine: true, routineDays: [.monday, .saturday], isCompleted: true, completedAt: nil, priority: .low,reminderDate: nil, isReminderOn: false),
        ToDo(id: UUID(), title: "Uyku Takibi", detail: "Yatmadan önce ekran yok", date: nil, createdAt: .now, updateAt: nil, isRoutine: true, routineDays: WeekDay.allCases, isCompleted: false, completedAt: nil, priority: .medium,reminderDate: nil, isReminderOn: false),
        ToDo(id: UUID(), title: "Gün Planlama", detail: "Ajanda doldur", date: nil, createdAt: .now, updateAt: nil, isRoutine: true, routineDays: WeekDay.allCases, isCompleted: true, completedAt: nil, priority: .high,reminderDate: nil, isReminderOn: false),
        ToDo(id: UUID(), title: "Akşam Yürüyüşü", detail: "30 dk yürüyüş", date: nil, createdAt: .now, updateAt: nil, isRoutine: true, routineDays: [.wednesday, .sunday], isCompleted: true, completedAt: nil, priority: .medium,reminderDate: nil, isReminderOn: false),
        ToDo(id: UUID(), title: "Dil Pratiği", detail: "Duolingo 15 dk", date: nil, createdAt: .now, updateAt: nil, isRoutine: true, routineDays: [.tuesday, .friday], isCompleted: true, completedAt: nil, priority: .medium,reminderDate: nil, isReminderOn: false),
        ToDo(id: UUID(), title: "Diş Fırçalama", detail: "Sabah ve akşam", date: nil, createdAt: .now, updateAt: nil, isRoutine: true, routineDays: WeekDay.allCases, isCompleted: false, completedAt: nil, priority: .high,reminderDate: nil, isReminderOn: false),
        ToDo(id: UUID(), title: "Sunum Hazırla", detail: "Yarınki toplantı için", date: .now.addingTimeInterval(86400), createdAt: .now, updateAt: nil, isRoutine: false, routineDays: nil, isCompleted: false, completedAt: nil, priority: .high,reminderDate: nil, isReminderOn: false),
        ToDo(id: UUID(), title: "Markete Git", detail: "Sebze, süt, yumurta al", date: .now, createdAt: .now, updateAt: nil, isRoutine: false, routineDays: nil, isCompleted: true, completedAt: .now, priority: .medium,reminderDate: nil, isReminderOn: false),
        ToDo(id: UUID(), title: "Mail Yanıtla", detail: "İş e-postaları", date: .now, createdAt: .now, updateAt: nil, isRoutine: false, routineDays: nil, isCompleted: true, completedAt: nil, priority: .medium,reminderDate: nil, isReminderOn: false),
        ToDo(id: UUID(), title: "Film İzle", detail: "Yeni çıkan filmi izle", date: .now.addingTimeInterval(-86400), createdAt: .now, updateAt: nil, isRoutine: false, routineDays: nil, isCompleted: true, completedAt: .now, priority: .low,reminderDate: nil, isReminderOn: false),
        ToDo(id: UUID(), title: "Fotoğraf Düzenle", detail: "Instagram için hazırla", date: .now.addingTimeInterval(3600), createdAt: .now, updateAt: nil, isRoutine: false, routineDays: nil, isCompleted: false, completedAt: nil, priority: .low,reminderDate: nil, isReminderOn: false),
        ToDo(id: UUID(), title: "Antrenman Planı", detail: "Yeni haftalık plan", date: .now.addingTimeInterval(86400 * 2), createdAt: .now, updateAt: nil, isRoutine: false, routineDays: nil, isCompleted: true, completedAt: nil, priority: .high,reminderDate: nil, isReminderOn: false),
        ToDo(id: UUID(), title: "Yemek Yap", detail: "Fırında tavuk", date: .now.addingTimeInterval(7200), createdAt: .now, updateAt: nil, isRoutine: false, routineDays: nil, isCompleted: true, completedAt: nil, priority: .medium,reminderDate: nil, isReminderOn: false),
        ToDo(id: UUID(), title: "Finans Takibi", detail: "Günlük harcamaları yaz", date: .now, createdAt: .now, updateAt: nil, isRoutine: false, routineDays: nil, isCompleted: false, completedAt: nil, priority: .medium,reminderDate: nil, isReminderOn: false),
        ToDo(id: UUID(), title: "Kargo Takibi", detail: "Kitap siparişi nerede?", date: .now, createdAt: .now, updateAt: nil, isRoutine: false, routineDays: nil, isCompleted: true, completedAt: nil, priority: .low,reminderDate: nil, isReminderOn: false),
        ToDo(id: UUID(), title: "Ödev Teslimi", detail: "Proje PDF’ini yükle", date: .now.addingTimeInterval(86400 * 3), createdAt: .now, updateAt: nil, isRoutine: false, routineDays: nil, isCompleted: true, completedAt: nil, priority: .high,reminderDate: nil, isReminderOn: false)
        ]
    
}
