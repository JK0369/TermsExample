//
//  TermsVM.swift
//  CellTest
//
//  Created by 김종권 on 2020/11/28.
//

import Foundation
import RxSwift
import RxCocoa

class TermsVM {

    let updateTermsContents = PublishRelay<Void>()
    let satisfyTermsPermission = PublishRelay<Bool>()
    let acceptAllTerms = PublishRelay<Bool>()

    var dataSource = [[Terms]]()
    let bag = DisposeBag()

    func viewWillAppear() {
        dataSource = Terms.loadSampleData()
    }

    func acceptAllTerms(_ isCheckedBtnAllAccept: Bool?) {

        guard let isCheckedBtnAllAccept = isCheckedBtnAllAccept else {
            return
        }

        for section in 0 ..< dataSource.count {
            for row in 0 ..< dataSource[section].count {
                dataSource[section][row].isAccept = isCheckedBtnAllAccept
            }
        }

        updateTermsContents.accept(())
        satisfyTermsPermission.accept(isCheckedBtnAllAccept)
    }

    func didSelectTermsCell(indexPath: IndexPath) {

        if indexPath.row == 0 { // main cell을 선택한 경우 - sub cell모두 main cell과 동일한 상태로 업데이트
            dataSource[indexPath.section][0].isAccept.toggle()
            for row in 1 ..< dataSource[indexPath.section].count {
                dataSource[indexPath.section][row].isAccept = dataSource[indexPath.section][0].isAccept
            }
        } else { // sub cell을 선택한 경우 - sub cell에 따라 main cell 업데이트
            dataSource[indexPath.section][indexPath.row].isAccept.toggle()

            for row in 1 ..< dataSource[indexPath.section].count {
                if !dataSource[indexPath.section][row].isAccept {
                    dataSource[indexPath.section][0].isAccept = false
                    break
                }
                dataSource[indexPath.section][0].isAccept = true
            }
        }

        updateTermsContents.accept(())
        checkSatisfyTerms()
        checkAcceptAllTerms()
    }

    private func checkSatisfyTerms() {
        for termsList in dataSource {
            for terms in termsList where terms.isMandatory && !terms.isAccept {
                satisfyTermsPermission.accept(false)
                return
            }
        }
        satisfyTermsPermission.accept(true)
    }

    private func checkAcceptAllTerms() {
        for termsList in dataSource {
            for terms in termsList where !terms.isAccept {
                acceptAllTerms.accept(false)
                return
            }
        }
        acceptAllTerms.accept(true)
    }

}

