//
//  HighScoreViewController.swift
//  BubblePop
//
//  Created by Liying Wu on 16/4/21.
//

import UIKit

class HighScoreViewController: UIViewController {
    
    // A UI table view will be displayed
    @IBOutlet weak var scoreTableView: UITableView!
    
    var tableDetail: [[String]] = []
    var tableLineAmt = 0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = "BubblePop"
        
        let nib = UINib(nibName: "customTableViewCell", bundle: nil)
        scoreTableView.register(nib, forCellReuseIdentifier: "customTableViewCell")
        self.scoreTableView.rowHeight = 44
    }
}

extension HighScoreViewController: UITableViewDelegate, UITableViewDataSource {
    // Tell the data source to return the number of rows in a given section of a table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Extract data from UserDefaults
        if let unwrappedDetail = UserDefaults.standard.value(forKey: "ScoreBoard") as? [[String]] {
            tableLineAmt = unwrappedDetail.count
        }
        return tableLineAmt
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Use template of the custom table view cell
        let cell = scoreTableView.dequeueReusableCell(withIdentifier: "customTableViewCell", for: indexPath) as! customTableViewCell
        // Extract data from UserDefaults
        if let unwrappedDetail = UserDefaults.standard.value(forKey: "ScoreBoard") as? [[String]] {
            self.tableDetail = unwrappedDetail
        }
        // Since each element in the array follows the pattern of ["plaer name", "score"], assign [0] to the custom cell's name label and [1] to custom cell's score label
        cell.nameLabel.text = tableDetail[indexPath.row][0]
        cell.scoreLabel.text = tableDetail[indexPath.row][1]
        
        return cell
    }
}
