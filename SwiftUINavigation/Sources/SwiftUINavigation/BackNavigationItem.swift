//
//  BackNavigationItem.swift
//  CryptoApp
//
//  Created by Иван Лазарев on 15.03.2020.
//  Copyright © 2020 Иван Лазарев. All rights reserved.
//

import SwiftUI

public struct BackNavigationItem: View {
    
    public init(){}
    
    public var body: some View {
        HStack {
            NavPopButton(destination: .previous) { Image(systemName: "chevron.left") }
            Spacer()
        }
    }
}

struct BackNavigationItem_Previews: PreviewProvider {
    static var previews: some View {
        BackNavigationItem()
    }
}
