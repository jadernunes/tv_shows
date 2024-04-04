//
//  WebView.swift
//  tvshows
//
//  Created by Jader Borba Nunes on 04/04/24.
//

import WebKit
import SwiftUI

struct WebView: UIViewRepresentable {
    let htmlContent: String

    func makeUIView(context: Context) -> WKWebView {
        WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString(htmlContent, baseURL: nil)
    }
}
