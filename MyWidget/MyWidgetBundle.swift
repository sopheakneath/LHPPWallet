//
//  MyWidgetBundle.swift
//  MyWidget
//
//  Created by sopheakneath on 27/8/26.
//

import WidgetKit
import SwiftUI

@main
struct MyWidgetBundle: WidgetBundle {
    var body: some Widget {
        MyWidget()
        MyWidgetControl()
        MyWidgetLiveActivity()
    }
}
