//
//  WebView.swift
//  Pods
//
//  Created by 杨建祥 on 2024/12/14.
//

//import UIKit
//import SwiftUI
//import SwifterSwift
//import WebKit
//import HiBase
//import HiLog
//
//public struct WebView: UIViewRepresentable {
//    
//    let htmlString: String
//    // let configuration: WKWebViewConfiguration
//    
//    public init(htmlString: String) {
//        self.htmlString = htmlString
//    }
//    
//    public func makeUIView(context: Context) -> some UIView {
//        let source = """
//        var meta = document.createElement('meta');
//        meta.setAttribute('name', 'viewport');
//        meta.setAttribute('content', 'width=device-width,initial-scale=1.0, maximum-scale=1.0, user-scalable=no');
//        document.getElementsByTagName('head')[0].appendChild(meta);
//        """
//        let script = WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
//        let controller = WKUserContentController()
//        controller.addUserScript(script)
//        let configuration = WKWebViewConfiguration()
//        configuration.userContentController = controller
//        let webView = WKWebView(frame: .zero, configuration: configuration)
//        webView.navigationDelegate = context.coordinator
//        webView.scrollView.isScrollEnabled = false
//        webView.scrollView.contentInsetAdjustmentBehavior = .never
//        if htmlString.isNotEmpty {
//            webView.loadHTMLString(htmlString, baseURL: nil)
//        }
//        return webView
//    }
//    
//    public func updateUIView(_ uiView: UIViewType, context: Context) {
//        log("updateUIView")
//    }
//    
//    public func makeCoordinator() -> Coordinator {
//        Coordinator(parent: self)
//    }
//    
//    public class Coordinator: NSObject, WKNavigationDelegate {
//        var parent: WebView
//        
//        init(parent: WebView) {
//            self.parent = parent
//        }
//        
//        public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
//            log("didStartProvisionalNavigation")
//        }
//        
//        public func webView(
//            _ webView: WKWebView,
//            decidePolicyFor navigationAction: WKNavigationAction,
//            decisionHandler: @escaping @MainActor (WKNavigationActionPolicy) -> Void
//        ) {
//            log("decidePolicyFor")
//            guard let string = navigationAction.request.url?.absoluteString else {
//                decisionHandler(.allow)
//                return
//            }
//            log("decidePolicyFor: \(string)")
//            if string == "about:blank" {
//                decisionHandler(.allow)
//                return
//            }
//            guard var url = navigationAction.request.url?.absoluteString.urlDecoded else {
//                decisionHandler(.allow)
//                return
//            }
//            if url.hasPrefix("about:blank#") {
//                url = string.removingPrefix("about:blank#")
//                if url.count != 0 {
//                    log("描点位置：\(url)")
//                }
//            }
//            decisionHandler(.cancel)
//        }
//        
//        public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//            log("didFinish")
//        }
//        
//        public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: any Error) {
//            log("didFail")
//        }
//        
//        public func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
//            log("webViewWebContentProcessDidTerminate")
//        }
//        
//    }
//    
//}
