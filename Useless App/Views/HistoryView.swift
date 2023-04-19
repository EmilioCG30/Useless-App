import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var visitedLinks: VisitedLinks
    
    var body: some View {
        List {
            ForEach(visitedLinks.links, id: \.self) { link in
                Text(link)
            }
            .onDelete(perform: delete)
        }
        .navigationBarTitle("History")
    }
    
    func delete(at offsets: IndexSet) {
        visitedLinks.links.remove(atOffsets: offsets)
        UserDefaults.standard.set(visitedLinks.links, forKey: "visitedLinks")
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
