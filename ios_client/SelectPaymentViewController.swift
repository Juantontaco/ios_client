//
//  SelectPaymentViewController.swift
//  ios_client
//
//  Created by Max Dignan on 5/28/18.
//  Copyright © 2018 RideZoot. All rights reserved.
//

import UIKit

class SelectPaymentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView : UITableView!
    
    var sources : [PaymentSource]!
    
    var scooterId : String?
    
    var freezeTable : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setUpTableView()
        addVerticalGradient()
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func addPaymentSourceButtonPressed(_ sender: Any) {
        
        let addPaymentSourceVC : AddPaymentSourceViewController = self.storyboard?.instantiateViewController(withIdentifier: "AddPaymentSourceViewController") as! AddPaymentSourceViewController

        addPaymentSourceVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        
        addPaymentSourceVC.shouldHaveBackButton = true
        
        present(addPaymentSourceVC, animated: true, completion: nil)
    }
    
    func setUpTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.tableView.backgroundColor = .clear
        
        loadSourcesData()
    }
    
    func loadSourcesData() {
        NetworkHelper().getPaymentSources(completion: { paymentSources in
            
            if let pSources = paymentSources {
                self.sources = pSources
                self.tableView.reloadData()
            } else {
                self.toastMessage(message: "There was an error receiving sources", danger: false)
            }
        })
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell : UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "cell")
        
        if indexPath.count > 0 {
            let newCell : PaymentSourceTableViewCell = Bundle.main.loadNibNamed("PaymentSourceTableViewCellView", owner: self, options: nil)!.first as! PaymentSourceTableViewCell
            
            newCell.paymentSource = sources[indexPath.row]
            
            newCell.render()
            
            cell = newCell
        } else {
            cell.textLabel?.text = "Not up yet"
        }
        
        cell.backgroundColor = .white
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 20
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if sources != nil {
            return sources.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if freezeTable {
            return
        }
        if sources.count == 0 {
            return
        }
        
        freezeTable = true
        
        let selectedPaymentSource : PaymentSource = sources[indexPath.row]
        
        let paymentSourceId : String = selectedPaymentSource.sourceID
        
        NetworkHelper().startRide(scooterSpecialIDCode: scooterId!, chosenPaymentSourceId: paymentSourceId, completion: { rideId in
            
            print(rideId as Any)
            if let rId : String = rideId {
                self.sendToInRideVC(rideId: rId)
            }
            
            
            
            self.freezeTable = false
        })
    }
    
    func sendToInRideVC(rideId: String) {
        let inRideVC : InRideViewController = self.storyboard?.instantiateViewController(withIdentifier: "InRideViewController") as! InRideViewController

        inRideVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        
        inRideVC.rideId = rideId

        present(inRideVC, animated: true, completion: nil)
    }

}
