//
//  ViewController.swift
//  JSONTableview
//
//  Created by Apple on 22/08/19.
//  Copyright © 2019 Revolut. All rights reserved.
//

import UIKit


// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class MyCustomCell: UITableViewCell {
    
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var subnameLabel: UILabel!
    @IBOutlet weak var newsLabel: UILabel!
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var thirdLabel: UILabel!
    @IBOutlet weak var fourthLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    let cellReuseIdentifier = "cell"
   
    // Tableview Data Load
    var newsData = [Com]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        self.loadJSON()
    }
    
    // MARK: JSON Data Load
    
    func loadJSON(){
        let urlPath = "URL"
        let url = NSURL(string: urlPath)
        let session = URLSession.shared
        let task = session.dataTask(with: url! as URL) { data, response, error in
            guard data != nil && error == nil else {
                print(error!.localizedDescription)
                return
            }
            do {
                let decoder = try JSONDecoder().decode(Welcome.self,  from: data!)
                let status = decoder.status

                if status == true {
                    print(decoder.date)
                    self.newsData = decoder.date.Com
                    DispatchQueue.main.async {
                        self.firstLabel.text = decoder.date.Name
                        self.secondLabel.text = decoder.date.pN
                        self.thirdLabel.text = decoder.date.cr
                        self.fourthLabel.text = decoder.date.de
                        self.tableView.reloadData()
                    }
                } else {
                    
                }
            } catch { print(error) }
        }
        task.resume()
    }
    
    // MARK: Tableview Delegates
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:MyCustomCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! MyCustomCell
        
        let item = self.newsData[indexPath.row]
        cell.nameLabel.text = item.uame
        cell.subnameLabel.text = item.cr
        cell.newsLabel.text = item.com
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }
}

