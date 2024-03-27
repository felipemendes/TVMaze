//
//  UIApplication+Extension.swift
//  TVMaze
//
//  Created by Felipe Mendes on 26/03/24.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
