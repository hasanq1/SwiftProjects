//
//  TableViewController.swift
//  Exercise6_Qureshi_Hasan
//
//  Created by Hasan Qureshi on 10/14/21.
//  Copyright © 2021 Hasan Qureshi. All rights reserved.
//

import UIKit


struct companyStats: Codable {
    init() {
        company = ""
        hq_latitude = 0
        hq_longitude = 0
    }
    let company:String
    let hq_latitude:Double
    let hq_longitude:Double
}
class TableViewController: UITableViewController {
    var companies = [companyStats]()
    var selectedCompany = companyStats()
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "http://cpl.uh.edu/courses/ubicomp/fall2021/webservice/companies_map.json")
        if url != nil {
            getInfo(url: url!)
        }
    }
    func decodeData(fetchedData: Data) {
        do {
            let linkContent = try JSONDecoder().decode(Array<companyStats>.self, from:fetchedData)
            self.companies = linkContent
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            print("Error in decoding")
        }
    }
    func getInfo(url: URL) {
        let task = URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
            //Decoding Part
            if let fetchedData = data {
                self.decodeData(fetchedData: fetchedData)
            } else if error != nil {
                print("Error in download Data")
            }
        })
        task.resume()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return companies.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "companies", for: indexPath)

        // Configure the cell...
        let cell_lbl1 = cell.viewWithTag(1) as! UILabel
        
        // Set the contents of labels
        cell_lbl1.text = companies[indexPath.row].company
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         selectedCompany = companies[indexPath.row]
         self.performSegue(withIdentifier: "map_segue", sender: self)
     }
     
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "map_segue")
        {
            let seg = segue.destination as! ViewController
            seg.companyList = selectedCompany
        }
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
