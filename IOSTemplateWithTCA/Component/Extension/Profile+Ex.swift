//
//  Profile+Ex.swift
//  IOSTemplateWithTCA
//
//  Created by 杨建祥 on 2025/2/6.
//

import Foundation
import SwiftUI
import SwifterSwift
import HiBase
import Domain

extension Profile {
    
    var hasLoginedUser: Bool { self.user?.isValid ?? false }

}
