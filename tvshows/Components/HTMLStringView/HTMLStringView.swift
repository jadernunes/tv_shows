//
//  HTMLStringView.swift
//  tvshows
//
//  Created by Jader Borba Nunes on 04/04/24.
//

import SwiftUI

struct HTMLStringView: View {
    let htmlContent: String

    var body: some View {
        GeometryReader { geometry in
            WebView(htmlContent: htmlContent)
                .frame(width: geometry.size.width, height: 1000) //fixed height initially, it will be adjusted based on content.
                .fixedSize(horizontal: true, vertical: false)
        }
    }
}
