//
//  StringResource+.swift
//  IOSTemplateWithTCA
//
//  Created by 杨建祥 on 2024/12/20.
//

import SwiftUI
import RswiftResources

extension RswiftResources.StringResource {
    
    var localizedKeyString: String {
        self.key.description
    }
    
    var localizedString: String {
        self.key.description.localizedString
    }
    
    var localizedStringKey: LocalizedStringKey {
        self.key.description.localizedStringKey
    }
    
}
