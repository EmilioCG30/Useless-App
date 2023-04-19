import SwiftUI

struct Welcome: View {
    @StateObject var visitedLinks = VisitedLinks()
    
    var body: some View {
        NavigationView {
            VStack {
                Button(action: {
                    // Get a random link from the Links class
                    guard let randomLink = Links.allLinks.randomElement(),
                          let url = URL(string: randomLink) else { return }
                    
                    // Open the link and add it to the VisitedLinks class
                    visitedLinks.addLink(randomLink)
                    
                    #if os(macOS)
                    NSWorkspace.shared.open(url)
                    #else
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    #endif
                }) {
                    Text("Open Random Link")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                NavigationLink(destination: HistoryView().environmentObject(visitedLinks)) {
                    Text("View History")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            #if os(macOS)
            .navigationTitle("Random Link Generator")
            #else
            .navigationBarTitle(Text("Random Link Generator"), displayMode: .inline)
            #endif
            .background(Color(hex: "87CEFA"))
        }
    }
}


struct Welcome_Previews: PreviewProvider {
    static var previews: some View {
        Welcome()
    }
}
