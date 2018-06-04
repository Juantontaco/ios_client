//
//  PaymentSourcesViewController.swift
//  ios_client
//
//  Created by Max Dignan on 5/26/18.
//  Copyright © 2018 RideZoot. All rights reserved.
//

import UIKit
import Stripe

class PaymentSourcesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView : UITableView!
    
    var sources : [PaymentSource]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addVerticalGradient()
        showLogo()
        showMenu()
        setUpTableView()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addCardButtonPressed(_ sender: Any) {
        
        let addPaymentSourceVC : AddPaymentSourceViewController = self.storyboard?.instantiateViewController(withIdentifier: "AddPaymentSourceViewController") as! AddPaymentSourceViewController

//        let addPaymentSourceVC :  STPAddCardViewController = STPAddCardViewController()
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
        NetworkHelper().getPaymentSources(includeFreeRides: false, completion: { paymentSources in
            
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
        
        if indexPath.count > 0 && sources != nil && sources.count > 0 {
            let newCell : PaymentSourceTableViewCell = Bundle.main.loadNibNamed("PaymentSourceTableViewCellView", owner: self, options: nil)!.first as! PaymentSourceTableViewCell
            
            newCell.paymentSource = sources[indexPath.row]
            
            newCell.render()
            
            cell = newCell
        } else {
            cell.textLabel?.text = "Not loaded yet, or no cards yet."
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

}
