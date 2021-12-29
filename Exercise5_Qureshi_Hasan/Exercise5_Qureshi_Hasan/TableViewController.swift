//
//  TableViewController.swift
//  Exercise5_Qureshi_Hasan
//
//  Created by Hasan Qureshi on 10/8/21.
//  Copyright © 2021 Hasan Qureshi. All rights reserved.
//

import UIKit

struct jsonData: Codable {
    init() {
        name = ""
        designed_by = ""
        logo = URL(string: "www.google.com")!
        first_appeared = 0
        about = ""
    }
    
    let name: String
    let designed_by: String
    let logo: URL
    let first_appeared: Int
    let about: String
}

class TableViewController: UITableViewController {

    var information = [jsonData]()
    var selectedInformation = jsonData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "http://www.cpl.uh.edu/courses/ubicomp/fall2021/webservice/languages.json")
        
        if url != nil {
            downloadData(url: url!)
        }
    }
    func decodeData(downloaded_data: Data) {
        do {
            let downloaded_info = try JSONDecoder().decode(Array<jsonData>.self, from:downloaded_data)
            self.information = downloaded_info
            
            // ?
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            print("Error in decoding")
        }
    }
    
    func downloadData(url: URL) {
        let task = URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
            //Decoding Part
            if let downloaded_data = data {
                self.decodeData(downloaded_data: downloaded_data)
            } else if let error=error {
                print(error)
            }
        })
        
        task.resume()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return information.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "languages", for: indexPath)

        // Configure the cell...
        let cell_lbl1 = cell.viewWithTag(1) as! UILabel
        let cell_lbl2 = cell.viewWithTag(2) as! UILabel
        let cell_img = cell.viewWithTag(3) as! UIImageView
        
        // Set the contents of labels
        cell_lbl1.text = information[indexPath.row].name
        cell_lbl2.text = "Est. \(information[indexPath.row].first_appeared)"
                
        
        // Download the img from saved URL type variable information[indexPath.row].logo
        URLSession.shared.dataTask(with: information[indexPath.row].logo, completionHandler: {(data, response, error) in

            if error != nil {
                print(error!)
                return
            }
            
            DispatchQueue.main.async {
                cell_img.image = UIImage(data: data!)
            }
            
        }).resume()
        
        return cell
    }
    
    // set the height of each row
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail_segue" {
            let seg = segue.destination as! ViewController
            seg.passData = selectedInformation
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedInformation = information[indexPath.row]
        self.performSegue(withIdentifier: "detail_segue", sender: self)
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
