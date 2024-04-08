//
//  LoaderView.swift
//  tvshows
//
//  Created by Jader Borba Nunes on 03/04/24.
//

import SwiftUI

struct LoaderView: View {
    
    let size: ControlSize
    
    init(size: ControlSize = .large) {
        self.size = size
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .center) {
                ProgressView()
                    .controlSize(size)
            }
            .frame(maxHeight: .infinity, alignment: .center)
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
}
