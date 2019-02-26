//
//  CustomerInfoViewController.swift
//  MedicalProject
//
//  Created by Ricky Yang on 2/10/19.
//

import UIKit
import Firebase

class CustomerInfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var customerInfo: DatabaseReference!
    var customerList = [Customers]()

    @IBOutlet weak var customerTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customerList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomerTableViewCell
        
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping;

        let eachCustomer:Customers
        eachCustomer = customerList[indexPath.row]
        
        let customerInfoString: String?
        
        customerInfoString = "Customer Name: \(eachCustomer.custName!)\nCustomer Address: \(eachCustomer.custAddy!)\nCustomer Number: \(eachCustomer.custNum!)\nEquipment Type: \(eachCustomer.choice!)\nDelivery Date: \(eachCustomer.deliv!)\nDelivery Time: \(eachCustomer.time!)\nDelivery Status: \(eachCustomer.delivStat!)\nBed Quantity: \(eachCustomer.bed!)\nBlood Glucose: \(eachCustomer.bloodGlucose!)\nIV Solution: \(eachCustomer.iVSolution!)\nInfusion Pump: \(eachCustomer.infusion!)\nNebulizer: \(eachCustomer.nebulizer!)\nPulse Oximeter: \(eachCustomer.pulseOx!)\nSyringe: \(eachCustomer.syringe!)\nThermometer: \(eachCustomer.thermometer!)\nWalker: \(eachCustomer.walker!)"
        
        cell.textLabel?.text = customerInfoString
        /*cell.lblCustAddress.text = eachCustomer.custAddy
        cell.lblDelivDate.text = eachCustomer.deliv
        cell.lblDelivTime.text = eachCustomer.time
        cell.lblDelivStatus.text = eachCustomer.delivStat */
        
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        customerTableView.delegate = self
        customerTableView.dataSource = self
        // Do any additional setup after loading the view.
        customerInfo = Database.database().reference().child("customer")
        
        
        customerInfo?.observeSingleEvent(of: .value) { (snapshot:DataSnapshot) in
            for customers in snapshot.children.allObjects as! [DataSnapshot] {
                let custObj = customers.value as? [String: AnyObject]
                let custName = custObj?["customerName"]
                let custAddress = custObj?["customerAddress"]
                let custNum = custObj?["customerNumber"]
                let choice = custObj?["choice"]
                let delivDate = custObj?["date"]
                let delivTime = custObj?["time"]
                let delivStatus = custObj?["status"]
                
                let bedQuant = custObj?["Bed"]
                let bloodQuant = custObj?["BloodGlucoseMontior"]
                let iVQuant = custObj?["IVSolution"]
                let infusionQunat = custObj?["InfusionPump"]
                let nebulizerQuant = custObj?["Nebulizer"]
                let pulseQuant = custObj?["PulseOximeter"]
                let syringeQuant = custObj?["Syringe"]
                let thermomQuant = custObj?["Thermometer"]
                let walkerQuant =  custObj?["Walker"]
                
                // Retrieving Data from Firebase IS WORKING!
                
                
                let customer = Customers(custName: custName as! String?, custAddy: custAddress as! String?, custNum: custNum as! String?, choice: choice as! String?, deliv: delivDate as! String?, time: delivTime as! String?, delivStat: delivStatus as! String?, bed: bedQuant as! String?, bloodGlucose: bloodQuant as! String?,
                    iVSolution: iVQuant as! String?,
                    infusion: infusionQunat as! String?,
                    nebulizer: nebulizerQuant as! String?,
                    pulseOx: pulseQuant as! String?,
                    syringe: syringeQuant as! String?,
                    thermometer: thermomQuant as! String?,
                    walker: walkerQuant as! String?)
                
                self.customerList.append(customer)
            }
            self.customerTableView?.reloadData()
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}