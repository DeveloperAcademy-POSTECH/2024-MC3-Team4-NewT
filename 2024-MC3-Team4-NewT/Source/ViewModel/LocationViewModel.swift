import SwiftUI
import SwiftData


class LocationViewModel: ObservableObject {
    @Published var selectedRegion: Region? = nil
    @Published var selectedItem: String? = nil
    @Published var selectedItemBackgroundColor: Color = Color("backgroundSkyblue")
    @Published var selectedItemColor: Color = Color("surfBlue")
    @State var isSelectButton: Bool = true
    
}
