//
//  SettingsVC.swift
//  simpleweather
//
//  Created by Agent X on 1/14/18.
//  Copyright © 2018 Andrii Halabuda. All rights reserved.
//

import UIKit
import StoreKit

class SettingsVC: UIViewController {
    @IBOutlet weak var scaleSegmentControl: UISegmentedControl!
    @IBOutlet weak var payButton: CustomButton!
    
    let AD_FREE_ID = "com.andrewapps.simpleweather.adFree"
    var products = [SKProduct]()
    var productID = ""
//    let appUrl = URL(string: "itms-apps://itunes.apple.com/app/id00000")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestProducts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setScaleControl()
        changeButton()
    }
    
    @IBAction func dismiss(sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func scaleControlChanged(_ sender: UISegmentedControl) {
        if scaleSegmentControl.selectedSegmentIndex == 0 {
            celsiusSelected = true
            UserDefaults.standard.set(celsiusSelected, forKey: "celsiusSelected")
        } else {
            celsiusSelected = false
            UserDefaults.standard.set(celsiusSelected, forKey: "celsiusSelected")
        }
        print(celsiusSelected)
    }
    
    func setScaleControl() {
        scaleSegmentControl.selectedSegmentIndex = celsiusSelected ? 0 : 1
    }
    
    // Restore previous purchases
    @IBAction func restoreBtnTapped(_ sender: Any) {
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    @IBAction func purchaseTapped(_ sender: Any) {
        if products.count != 0 {
            purchaseProduct(product: products[0])
        }
    }
    
    func unlockAdFree() {
        if productID == AD_FREE_ID {
            adFreePurchaseMade = true
            UserDefaults.standard.set(adFreePurchaseMade, forKey: "adFreePurchaseMade")
            changeButton()
        }
    }
    
    func restoreAdFree() {
        adFreePurchaseMade = true
        UserDefaults.standard.set(adFreePurchaseMade, forKey: "adFreePurchaseMade")
        changeButton()
    }
    
    // Alert Controller
    func showAlertWithTitle(_ title:String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertVC.addAction(okAction)
        DispatchQueue.main.async {
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    func changeButton() {
        if adFreePurchaseMade {
            payButton.setTitle("Done", for: .normal)
            payButton.setTitleColor(.white, for: .normal)
            payButton.isEnabled = false
            payButton.layer.backgroundColor = UIColor(red: 110/255, green: 159/255, blue: 252/255, alpha: 1.0).cgColor
            payButton.layer.borderWidth = 0
        }
    }
}

// MARK: - StoreKit delegate methods
extension SettingsVC: SKProductsRequestDelegate, SKPaymentTransactionObserver {
    // Request products from Apple
    func requestProducts() {
        let productIdentifiers : Set<String> = [AD_FREE_ID]
        let productsRequest = SKProductsRequest(productIdentifiers: productIdentifiers)
        productsRequest.delegate = self
        productsRequest.start()
    }
    
    // Handling Apple response
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        print("Products ready: \(response.products.count)")
        print("Products not ready: \(response.invalidProductIdentifiers.count)")
        print("Product:", response.products[0].productIdentifier)
        self.products = response.products
    }
    
    // Creating payment queue
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchased:
                print("Purchased")
                SKPaymentQueue.default().finishTransaction(transaction)
                unlockAdFree()
                break
            case .failed:
                print("Failed")
                SKPaymentQueue.default().finishTransaction(transaction)
                break
            case .restored:
                print("Restored")
                restoreAdFree()
                SKPaymentQueue.default().finishTransaction(transaction)
                break
            case .purchasing:
                print("Purchasing")
                break
            case .deferred:
                print("Deffered")
                break
            @unknown default:
                print("Unknown error occured")
            }
        }
    }
    
    // Check if purchases are available
    func canMakePurchases() -> Bool { return SKPaymentQueue.canMakePayments() }
    
    // Make a purchase
    func purchaseProduct(product: SKProduct) {
        if self.canMakePurchases() {
            let payment = SKPayment(product: product)
            SKPaymentQueue.default().add(self)
            SKPaymentQueue.default().add(payment)
            print("PRODUCT TO PURCHASE: \(product.productIdentifier)")
            productID = product.productIdentifier
            // IAP Purchases disabled on the Device
        } else {
            showAlertWithTitle("WeatherGPS", message: "Purchases are disabled in your device!")
        }
    }
}
