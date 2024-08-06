//
//  PetitionDetailsViewController.swift
//  Project7
//
//  Created by Mateusz Bereta on 31/07/2024.
//

import WebKit
import UIKit

protocol PetitionDetailsViewProtocol {
    func setPetition(_ petition: Petition)
}

class PetitionDetailsViewController: UIViewController, PetitionDetailsViewProtocol {
    private var webView: WKWebView!
    private var petition: Petition?
    private lazy var presenter = PetitionDetailsPresenter(view: self)

    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    
    func setPetition(_ petition: Petition) {
        self.petition = petition
    }
    
    override func viewDidLoad() {
        guard let detailItem = petition else { return }
        let html = """
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style> body { font-size: 150%; } </style>
        </head>
        <body>
        <h2>\(detailItem.title)</h2>
        <p>
        \(detailItem.body)
        </p>
        </body>
        </html>
        """

        webView.loadHTMLString(html, baseURL: nil)
    }
    
}
