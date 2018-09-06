//
//  ViewController.swift
//  AJAXSwift
//
//  Created by Xue Xin Tsai on 2018/9/6.
//  Copyright © 2018年 Xue Xin Tsai. All rights reserved.
//

import UIKit
import JavaScriptCore
import WebKit

class ViewController: UIViewController, WKScriptMessageHandler {
    
    var webView: WKWebView!
    let contentController = WKUserContentController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func runtime(_ sender: Any) {
        let url = Bundle.main.url(forResource: "File", withExtension: "html")
        let userScript = WKUserScript(source: "sendReq()", injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        contentController.addUserScript(userScript)
        contentController.add(
            self as WKScriptMessageHandler,
            name: "callbackHandler"
        )
        let config = WKWebViewConfiguration()
        config.userContentController = contentController
        
        webView = WKWebView(frame: self.view.frame,configuration: config)
        
        let text = try! String(contentsOf: url!)
        webView.loadHTMLString(text, baseURL: nil)
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print(message.body)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

