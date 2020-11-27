//
//  Terms.swift
//  CellTest
//
//  Created by 김종권 on 2020/11/28.
//

import Foundation

enum TermsType {
    case main
    case sub
}

struct Terms {
    let termsID: String?
    let title: String
    let contents: String?
    let isMandatory: Bool
    var isAccept: Bool = false
    let type: TermsType

    static func loadSampleData() -> [[Terms]] {
        let terms1: [Terms] = [
            .init(
                termsID: "1",
                title: "만 14세 이상입니다",
                contents: "blabla",
                isMandatory: true,
                type: .main
            ),
        ]

        let terms2: [Terms] = [
            .init(
                termsID: "2",
                title: "서비스 이용 약관 동의",
                contents: "blabla",
                isMandatory: true,
                type: .main
            ),
        ]

        let terms3: [Terms] = [
            .init(
                termsID: nil,
                title: "앱 결제 이용약관",
                contents: "blabla",
                isMandatory: false,
                type: .main
            ),
            .init(
                termsID: "3",
                title: "개인정보 제 3자 제공 동의",
                contents: "blabla",
                isMandatory: false,
                type: .sub
            ),
            .init(
                termsID: "4",
                title: "결제 이용내역 제공 동의",
                contents: "blabla",
                isMandatory: false,
                type: .sub
            ),
        ]
        return [terms1, terms2, terms3]
    }
}
