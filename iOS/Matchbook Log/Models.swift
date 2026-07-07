import Foundation

struct MatchbookItem: Identifiable, Codable, Equatable {
    var id: UUID
    var dateAdded: Date
    var venueName: String
    var city: String
    var yearApprox: String
    var notes: String

    init(id: UUID = UUID(), dateAdded: Date = Date(), venueName: String, city: String, yearApprox: String, notes: String) {
        self.id = id
        self.dateAdded = dateAdded
        self.venueName = venueName
        self.city = city
        self.yearApprox = yearApprox
        self.notes = notes
    }

    static func blank() -> MatchbookItem {
        MatchbookItem(venueName: "", city: "", yearApprox: "", notes: "")
    }
}
