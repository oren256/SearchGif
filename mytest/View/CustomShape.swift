//
//  CustomShape.swift
//  mytest
//
//  Created by  DNS on 13.05.2022.
//

import SwiftUI

struct CustomShape: Shape {
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft,.topRight,.bottomLeft], cornerRadii: CGSize(width: 40, height: 40))
        
        return Path(path.cgPath)
    }
}
