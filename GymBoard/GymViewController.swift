//
//  GymViewController.swift
//  GymBoard
//
//  Created by João Luís on 07/03/17.
//  Copyright © 2017 JoBernas. All rights reserved.
//

import UIKit

class GymViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var data = [Entry]()
    
    var d: [Entry]? // Pode nao existir
    //var d: [Entry]! // Tem de existir
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
        data.append(Entry(label: .Weight , unit: "Kg", value: 70.0))
        data.append(Entry(label: .Height , unit: "cm", value: 170.0))
        data.append(Entry(label: .LeanMass , unit: "Kg", value: 50))
        data.append(Entry(label: .FatMass , unit: "Kg", value: 20))
        data.append(Entry(label: .Water , unit: "%", value: 54.2))
        data.append(Entry(label: .BodyMassIndex , unit: "", value: 26))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let vc = segue.destination as? BoardTableViewController {
//            //Get instance in vc and pass variable 'sender' or variable from this class
//        }
//    }

}

extension GymViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 3
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let c = tableView.dequeueReusableCell(withIdentifier: "GymTableViewCell", for: indexPath)
        
        guard let cell = c as? GymTableViewCell else { //guard is the deniel of IF (IF Can't)
            return c
        }
        
        let entry = self.data[indexPath.row]
//        cell.backgroundColor = (indexPath.row % 2 == 0) ? UIColor.grey : UIColor.white
        cell.entry = entry
        return cell
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "Section \(section)"
//    }
    
}

extension GymViewController: UITableViewDelegate {
    
 
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - tableView: <#tableView description#>
    ///   - indexPath: <#indexPath description#>
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "GymToDetails", sender: nil)
    }
    
}
