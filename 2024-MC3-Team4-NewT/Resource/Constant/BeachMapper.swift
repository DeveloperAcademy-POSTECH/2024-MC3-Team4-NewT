//
//  BeachMapper.swift
//  2024-MC3-Team4-NewT
//
//  Created by ram on 8/10/24.
//

import Foundation


let beachToEnglishMap: [String: String] = [
    "양양 물치해변": "mulchi",
    "양양 정암해변": "jeongam",
    "양양 설악해변": "seorak",
    "양양 낙산해변": "naksan",
    "양양 동호해변": "dongho",
    "제주 중문해변": "jungmun",
    "제주 이호테우해변": "ihoteu",
    "제주 월정해변": "woljeong",
    "제주 사계해변": "sagye",
    "부산 송정해변": "songjeong",
    "부산 다대포해변": "dadaepo",
    "고성 송지호해변": "songjiho",
    "고성 천진해변": "cheonjinho",
    "속초 속초해변": "sokcho",
    "동해 대진해변": "daejin",
    "강릉 금진해변": "geumjin",
    "강릉 경포해변": "gyeongpo",
    "삼척 용화해변": "yonghwa",
    "포항 신항만해변": "sinhangman",
    "포항 월포해변": "wolpo",
    "울산 진하해변": "jinha",
    "태안 만리포해변": "manripo",
    "고흥 남열 해돋이해변": "namyeol"
]

//
//// 해변 이름을 받아서 해당 지역과 영문 이름을 연결해 출력하는 함수
//func printBeachEnglishName(beachName: String) {
//    for region in regions {
//        if let englishName = beachNameMapping[beachName], region.items.contains(beachName) {
//            let regionNameInEnglish = region.name.replacingOccurrences(of: "/", with: "").lowercased()
//            print("\(regionNameInEnglish)\(englishName)")
//            return
//        }
//    }
//    print("해당 해변을 찾을 수 없습니다.")
//}

// 예시 사용
//printBeachEnglishName(for: "고성 송지호해변")  // gosongsongjiho
