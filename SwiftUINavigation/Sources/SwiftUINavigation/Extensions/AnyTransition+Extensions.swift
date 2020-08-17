//
//  AnyTransitionExt.swift
//  CustomNavigationView
//
//  Created by Иван Лазарев on 10.03.2020.
//  Copyright © 2020 Иван Лазарев. All rights reserved.
//

import SwiftUI

extension AnyTransition {
    public static var moveAndFadeIn: AnyTransition {
        let insertion = AnyTransition.move(edge: .trailing)
            .combined(with: .opacity)
        let removal = AnyTransition.scale
            .combined(with: .opacity)
        return .asymmetric(insertion: insertion, removal: removal)
    }
    
    
    public static var moveAndFafeOut: AnyTransition {
        let insertion = AnyTransition.move(edge: .leading)
            .combined(with: .opacity)
        let removal = AnyTransition.scale
            .combined(with: .opacity)
        return .asymmetric(insertion: insertion, removal: removal)
    }
    
}
