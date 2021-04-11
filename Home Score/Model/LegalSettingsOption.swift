//
//  LegalSettingsOption.swift
//  Home Score
//
//  Created by Joshua Ford on 3/30/21.
//

import Foundation

enum LegalSettingsOption {
    case termsOfUse
    case legal
    case privacyPolicy
    
    var text: String {
        switch self {
        case .termsOfUse:
            return """
                termsOfUse termsOfUse termsOfUse termsOfUse termsOfUse termsOfUse termsOfUse termsOfUse termsOfUse termsOfUse termsOfUse termsOfUse termsOfUse termsOfUse termsOfUse termsOfUse termsOfUse termsOfUse termsOfUse termsOfUse termsOfUse termsOfUse termsOfUse termsOfUse
                """
        case .legal:
            return """
                legal legal legal legal legal legal legal legal legal legal legal legal legal legal legal legal legal legal legal legal legal legal legal legal legal legal legal legal legal legal legal legal legal legal legal legal legal legal legal legal legal legal legal legal legal legal legal legal legal legal
                """
        case .privacyPolicy:
            return """
                privacyPolicy privacyPolicy privacyPolicy privacyPolicy privacyPolicy privacyPolicy privacyPolicy privacyPolicy privacyPolicy privacyPolicy privacyPolicy privacyPolicy privacyPolicy privacyPolicy privacyPolicy privacyPolicy privacyPolicy privacyPolicy privacyPolicy privacyPolicy
                """
        }
    }
}
