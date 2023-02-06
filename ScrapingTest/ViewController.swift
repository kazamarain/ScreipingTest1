//
//  viewController.swift
//  ScrapingTest
//
//  Created by ユウ・カザマ on 2023/01/18.
import UIKit
import Alamofire
import Kanna

class ViewController: UIViewController, UITableViewDataSource  {
    
    @IBOutlet weak var MainTableView: UITableView!
    
    
    private var tableView = UITableView()
    
    private var names = [String]()
    
    private var Prices = [String]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AF.request("https://www.kourakuen.co.jp/").responseString { response in
            if let html = response.value {
                self.parseHTML(html: html)
                self.tableView.reloadData()
            }
            
            print("yuio")
        }
    setUpTableView: do {
        tableView.frame = view.frame
        tableView.dataSource = self
        view.addSubview(tableView)
    }
        
    }
    
    func parseHTML(html: String) {
        if let doc = try? HTML(html: html, encoding: .utf8) {
            //HTML内のリンクを抜き出す
            for node in doc.xpath("//diy") {
                if(node["class"] == "Menu-itemName Body--menu" && node.text != "キッズメニューおまけ"){
                    names.append(node.text ?? "")
                }
                
                if(node["class"] == "Menu--itemPrice Body--menu"){
                    Prices.append(node.text ?? "")
                    
                }
            }
            
            print("商品数\(names.count) : 値段数(price.count)")
            
            for i in 0..<names.count {
                print("\(names[i])  : \(Prices[i]))")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier:   "cell")
        let name = names[indexPath.row]
        let price = Prices[indexPath.row]
        cell.textLabel?.text = name
        cell.detailTextLabel?.text = price
        
        let imageData :NSData = NSData(contentsOf: NSURL(string:
                                                            "https:/ /dvn1.mktacdn .com/p/D YALCWGOFtwsYPa7EL90YAYJnIAe0pEt3QHCrx4Sc/1400×1050 .ipq")!as URL)!
            
        cell.imageView?.image = UIImage(data: imageData as Data)
                                       
                                       
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) ->Int {
        return names.count
    }
    
}




