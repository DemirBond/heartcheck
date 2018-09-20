//
//  VideoTutorialViewController.swift
//  CVDEvaluator
//
//  Created by Phillip Paik on 9/8/18.
//  Copyright © 2018 IgorKhomiak. All rights reserved.
//

import UIKit
import WebKit

class VideoTutorialViewController: UIViewController, WKUIDelegate {
    
    var webView: WKWebView!

    override func loadView() {
        super.loadView()
        let webConfiguration = WKWebViewConfiguration()
        //webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView = WKWebView(frame: CGRect(x: self.view.frame.maxX - (self.view.frame.width * 0.95), y: self.view.frame.midY - 100, width: self.view.frame.width * 0.9, height: 300), configuration: webConfiguration)
        
        webView.uiDelegate = self
        view.addSubview(webView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let myURL = URL(string: "https://youtu.be/TUdhCq1SOqQ")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
