import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var visitedLinks: VisitedLinks
    
    var body: some View {
        NavigationView {
            List {
                ForEach(visitedLinks.links, id: \.self) { link in
                    Text(link)
                }
            }
            .navigationTitle("View History")
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
