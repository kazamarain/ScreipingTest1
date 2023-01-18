//
//  ViewController.swift
//  ScrapingTest
//
//  Created by ユウ・カザマ on 2023/01/18.
//

import UIKit
import Alamofire


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        AF.request("https://www.yahoo.co.jp/").responseString { respnse in
            it let html = resoponse.value {
                print(html)
            }
        }
    }


}

