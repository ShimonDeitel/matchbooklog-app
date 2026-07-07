import Foundation
import Combine

@MainActor
final class Store: ObservableObject {
    @Published var items: [MatchbookItem] = []
    @Published var isPro: Bool = false

    /// Free-tier cap. Always kept comfortably above seed data count so a
    /// fresh install never trips the paywall immediately.
    static let freeLimit = 15

    private let fileURL: URL

    init() {
        let support = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
        try? FileManager.default.createDirectory(at: support, withIntermediateDirectories: true)
        fileURL = support.appendingPathComponent("matchbooklog_items.json")
        load()
    }

    var canAddMore: Bool {
        isPro || items.count < Store.freeLimit
    }

    func add(_ item: MatchbookItem) {
        guard canAddMore else { return }
        items.insert(item, at: 0)
        save()
    }

    func update(_ item: MatchbookItem) {
        guard let idx = items.firstIndex(where: { $0.id == item.id }) else { return }
        items[idx] = item
        save()
    }

    func delete(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
        save()
    }

    func delete(_ item: MatchbookItem) {
        items.removeAll { $0.id == item.id }
        save()
    }

    private func load() {
        if let data = try? Data(contentsOf: fileURL),
           let decoded = try? JSONDecoder().decode([MatchbookItem].self, from: data) {
            items = decoded
        } else {
            items = seedData()
            save()
        }
    }

    private func save() {
        guard let data = try? JSONEncoder().encode(items) else { return }
        try? data.write(to: fileURL, options: .atomic)
    }

    private func seedData() -> [MatchbookItem] {
        [
        MatchbookItem(venueName: "The Blue Note Lounge", city: "Chicago", yearApprox: "1965", notes: "Neon cover art"),
        MatchbookItem(venueName: "Sam's Diner", city: "Route 66", yearApprox: "1958", notes: "Roadside diner"),
        MatchbookItem(venueName: "El Capitan Club", city: "Havana", yearApprox: "1950", notes: "Gift from grandfather")
        ]
    }
}
