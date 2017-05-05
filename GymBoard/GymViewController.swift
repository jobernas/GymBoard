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
    
    var data = [(String, Array<Entry>)]()
    var selectedIndex: Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //DEBUG
//         EntryCRUD.clearDB()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadDataFromDB()
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GymToAddEdit", let addEntryVC = segue.destination as? AddNewViewController {
            if self.selectedIndex != -1 {
                addEntryVC.setData(self.data[self.selectedIndex].0, array:self.data[self.selectedIndex].1)
                self.selectedIndex = -1
            }
        }
    }
    
    private func loadDataFromDB(){
        self.data.removeAll()
        let dbData = EntryCRUD.getAllEntries()
        print(dbData)
        var auxDict = [String : Array<Entry>]()
        for entry in Array(dbData) {
            if (auxDict.index(forKey: entry.date) != nil) {
                auxDict[entry.date]!.append(entry)
            }else{
                auxDict[entry.date] = Array<Entry>()
                auxDict[entry.date]!.append(entry)
            }
        }
        self.data = auxDict.sorted(by: { $0.0 > $1.0 })
    }

}

extension GymViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let group = self.data[section]
        return group.1.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let c = tableView.dequeueReusableCell(withIdentifier: "GymTableViewCell", for: indexPath)
        
        guard let cell = c as? GymTableViewCell else { //guard is the deniel of IF (IF Can't)
            return c
        }
        
        let group = self.data[indexPath.section]
        let entry = group.1[indexPath.row]
        cell.entry = entry
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionView = EntrySectionHeader(frame: CGRect(x:0, y:0, width:375, height: 64))
        let group = self.data[section]
        let date = group.0
        sectionView.title = "\(date)"
        sectionView.handler = self as HandleEntries
        sectionView.index = section
        return sectionView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 64.0
    }
    
}

extension GymViewController: HandleEntries {
    
    func editEntries(_ date: String, index: Int) {
        self.selectedIndex = index
        self.performSegue(withIdentifier: "GymToAddEdit", sender: nil)
    }
    
    func deleteEntries(_ date: String, index: Int) {
        self.data.remove(at: index)
        self.tableView.reloadData()
    }
    
}

extension GymViewController: UITableViewDelegate {
    
 
    /// Table View on Click
    ///
    /// - Parameters:
    ///   - tableView: tableView description
    ///   - indexPath: indexPath description
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "GymToDetails", sender: nil)
    }
    
}
