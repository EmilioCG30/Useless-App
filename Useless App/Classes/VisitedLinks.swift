import Foundation

class VisitedLinks: ObservableObject {
    @Published var links: [String] = []
    
    init() {
        if let savedLinks = UserDefaults.standard.array(forKey: "visitedLinks") as? [String] {
            links = savedLinks
        }
    }
    
    func addLink(_ link: String) {
        links.append(link)
        UserDefaults.standard.set(links, forKey: "visitedLinks")
    }
}
