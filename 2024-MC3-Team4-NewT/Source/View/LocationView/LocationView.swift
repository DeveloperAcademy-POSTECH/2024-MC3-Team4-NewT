import Foundation
import SwiftUI


struct Region: Identifiable {
    let id = UUID()
    let name: String
    let items: [String]
}

let regions = [
    Region(name: "양양", items: ["양양 물치해변", "양양 정암해변", "양양 설악해변", "양양 낙산해변", "양양 동호해변"]),
    Region(name: "제주", items: ["제주 중문해변", "제주 이호테우해변", "제주 월정해변", "제주 사계해변"]),
    Region(name: "부산", items: ["부산 송정해변", "부산 다대포해변"]),
    Region(name: "고성/속초", items: ["고성 송지호해변", "고성 천진해변", "속초 속초해변"]),
    Region(name: "강릉/동해/삼척", items: ["동해 대진해변", "강릉 금진해변", "강릉 경포해변", "삼척 용화해변"]),
    Region(name: "포항/울산", items: ["포항 신항만해변", "포항 월포해변", "울산 진하해변"]),
    Region(name: "서해/남해", items: ["태안 만리포해변", "고흥 남열 해돋이해변"])
]

struct LocationView: View {
    @State var selectedRegion: Region? = nil
    @State var selectedItem: String? = nil
    @State var selectedItemBackgroundColor: Color = Color("backgroundSkyblue")
    @State var selectedItemColor: Color = Color("surfBlue")
    @State var isSelectButton: Bool = true
    var body: some View {
        ZStack{
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            VStack(spacing: 0){
                Divider()
                    .background(Color(.clear))
                HStack(spacing: 0){
                    VStack(alignment: .leading, spacing: 0){
                        ForEach(regions) { region in
                            HStack(spacing: 0){
                                Button {
                                    selectedRegion = region
                                    selectedItem = nil
                                    isSelectButton = true
                                } label: {
                                    ZStack(alignment: .leading){
                                        Spacer()
                                            .frame(width: 150, height: 57)
                                            .background(selectedRegion?.id == region.id ? Color(selectedItemBackgroundColor) : Color(.systemGroupedBackground))
                                        Text(region.name)
                                            .font(.SubheadingSemiBold)
                                            .padding(.vertical, 15)
                                            .padding(.leading)
                                            .foregroundColor(selectedRegion?.id == region.id ? Color(selectedItemColor) : Color.black.opacity(0.5) )
                                    }
                                }
                            }
                            
                        }
                        Spacer()
                    }
                    .frame(width: 150)
                    
                    ZStack(alignment: .leading){
                        Color.white
                        if let region = selectedRegion {
                            VStack(alignment: .leading, spacing: 0){
                                ForEach(region.items, id: \.self) { item in
                                    HStack{
                                        Button {
                                            selectedItem = item
                                            isSelectButton = false
                                        } label: {
                                            ZStack(alignment: .leading){
                                                Spacer()
                                                    .frame(height: 57)
                                                Text(item)
                                                    .font(.Body1Medium)
                                                    .padding(.top)
                                                    .padding(.bottom, 17)
                                                    .padding(.leading)
                                                    .foregroundColor(selectedItem == item ? Color(selectedItemColor) : Color.black.opacity(0.5) )
                                            }
                                            Spacer()
                                        }
                                    }
                                }
                                Spacer()
                            }
                            
                        }
                    }
                }
                
                Divider()
                    .padding(.bottom, 8)
                
                Button{
                    
                } label: {
                    ZStack {
                        if isSelectButton {
                            Color("backgroundGray")
                                .frame(height: 55)
                                .cornerRadius(36)
                        }
                        else {
                            Color("surfBlue")
                                .frame(height: 55)
                                .cornerRadius(36)
                        }
                        HStack{
                            Text("선택 완료")
                                .font(.SubheadingBold)
                                .foregroundColor(Color.white)
                        }
                    }
                    .padding(.horizontal)
                    
                }.disabled(isSelectButton)
                
            }
            
        }.navigationTitle("지역선택")
    }
}

#Preview {
    LocationView()
}
