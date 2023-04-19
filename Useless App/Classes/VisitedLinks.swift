import Foundation

class VisitedLinks: ObservableObject {
    @Published var links: [String] = []
    
    init() {
        load()
    }
    
    func addLink(_ link: String) {
        links.append(link)
        save()
    }
    
    private func save() {
        UserDefaults.standard.set(links, forKey: "visitedLinks")
    }
    
    private func load() {
        if let savedLinks = UserDefaults.standard.array(forKey: "visitedLinks") as? [String] {
            links = savedLinks
        }
    }
}
