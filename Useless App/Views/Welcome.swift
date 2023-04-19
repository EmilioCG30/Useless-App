import SwiftUI

struct Welcome: View {
    @StateObject var visitedLinks = VisitedLinks()
    @State private var textColor = Color.green
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Visit a Random Website Clicking on the Button Below")
                    .font(.title)
                    .padding()
                    .multilineTextAlignment(.center)
                    .foregroundColor(textColor)
                    .padding(3 * 15)
                    .onReceive(Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()) { _ in
                        textColor = Color(red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1))
                    }
                
                //Spacer()
                
                VStack(spacing: 10) {
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
                            .padding(.vertical, 15)
                            .frame(maxWidth: .infinity)
                            .background {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color(hex: "F50087"))
                            }
                            .padding(.horizontal)
                    }
                    //Spacer()
                    NavigationLink(destination: HistoryView().environmentObject(visitedLinks)) {
                        Text("View History")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.vertical, 15)
                            .frame(maxWidth: .infinity)
                            .background {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.purple)
                            }
                            .padding(.horizontal)
                    }
                }
            }
#if os(macOS)
            //.navigationTitle("Take me to a Random Website")
#else
            //.navigationBarTitle(Text("Take me to a Random Website"), displayMode: .inline)
#endif
        }
    }
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.currentIndex = hex.startIndex
        
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let r = Double((rgbValue & 0xff0000) >> 16) / 255.0
        let g = Double((rgbValue & 0xff00) >> 8) / 255.0
        let b = Double(rgbValue & 0xff) / 255.0
        
        self.init(red: r, green: g, blue: b)
    }
}


struct Welcome_Previews: PreviewProvider {
    static var previews: some View {
        Welcome()
    }
}
