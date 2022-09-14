//
//  DashboardViewController.swift
//  randomGenerator
//
//  Created by R C on 11/30/20.
//

import UIKit
import GoogleMobileAds
import StoreKit
import SwiftKeychainWrapper
import Locksmith
//import KeychainSwift



class Global {
    var webString = String()
    var adViewHeight = NSLayoutConstraint()
    var noAds = Bool()
}
let global = Global()


class DashboardViewController: UIViewController, GADBannerViewDelegate {
//    let paid = SettingsViewController()
    //        lazy var banner: GADBannerView = {
    //            let banner = GADBannerView(adSize: kGADAdSizeMediumRectangle)
    //            //Change this add Unit id to below when ready to publish
    //            //        banner.adUnitID = "ca-app-pub-5243010963011406/1783105361"
    //            banner.adUnitID = "ca-app-pub-3940256099942544/2934735716"
    //            banner.load(GADRequest())
    //            banner.delegate = self
    //            banner.rootViewController = self
    //            banner.frame = CGRect(x:  0, y: view.frame.size.height-50, width: view.frame.size.width, height: 50).integral
    //            return banner
    //        }()
    
    @IBOutlet weak var RandomNumberVC: UIButton!
    @IBOutlet weak var RandomLetterVC: UIButton!
    @IBOutlet weak var RandomEightBallVC: UIButton!
    @IBOutlet weak var RandomCompassVC: UIButton!
    @IBOutlet weak var RandomAnimalVC: UIButton!
    @IBOutlet weak var RandomCoinVC: UIButton!
    @IBOutlet weak var googleAdBanner: GADBannerView!
    @IBOutlet weak var googleAdHeight: NSLayoutConstraint!
    var buttons = [UIButton]()
    static var adsRemoval = false
    let dictionary = Locksmith.loadDataForUserAccount(userAccount: "Randomizer")
//    let settings = SettingsViewController()
//        let keychain = KeychainSwift()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if dictionary?.isEmpty == true {
            googleAdBanner.isHidden = true
                print("There is no banner")
            } else {
                setUpBanner()
                print("There is a banner!")
            }
//        if (DashboardViewController.adsRemoval == true) {
//            googleAdBanner.isHidden = true
//                print("There is no banner")
//            } else {
//                setUpBanner()
//                print("There is a banner!")
//            }
        
        
        
//        SKPaymentQueue.default().add(self)
//        let keychainData = KeychainWrapper.standard.bool(forKey: "hidden")
//        KeychainWrapper.wipeKeychain()
//        if keychainData == true {
//            googleAdBanner.isHidden = true
//        } else {
//            googleAdBanner.isHidden = false
//        }
//        //        if global.noAds == true {
//        //            googleAdBanner.isHidden = true
//        //        } else {
//        //            setUpBanner()
//        //        }
        
        
        let barButton = UIBarButtonItem(image: UIImage(systemName: "gearshape.fill"), style: .plain, target: self, action:  #selector(showSettings))
        navigationItem.rightBarButtonItem  = barButton
        buttons = [RandomCoinVC, RandomAnimalVC, RandomLetterVC, RandomNumberVC, RandomCompassVC, RandomEightBallVC]; do {
            for button in buttons {
                button.createProfileButton()
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
       print("yo")
        print(dictionary?.keys)
        print("keys")
        print(dictionary?.values)
        print("values")
        print(dictionary?.isEmpty)
        if dictionary?.isEmpty == true {
            googleAdBanner.isHidden = true
                print("There is no banner")
            } else {
                setUpBanner()
                print("There is a banner!")
            }
//        print(dictionary?.keys)
//        print(dictionary?.values)
//        print(dictionary?.count)
//        if (DashboardViewController.adsRemoval == true) {
//            googleAdBanner.isHidden = true
//                print("There is no banner")
//            } else {
//                setUpBanner()
//                print("There is a banner!")
//            }
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if dictionary?.isEmpty == true {
            googleAdBanner.isHidden = true
                print("There is no banner")
            } else {
                setUpBanner()
                print("There is a banner!")
            }
        
//        if (DashboardViewController.adsRemoval == true) {
//            googleAdBanner.isHidden = true
//                print("There is no banner")
//            } else {
//                setUpBanner()
//                print("There is a banner!")
//            }
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        if global.noAds == true {
//            googleAdBanner.isHidden = true
//        } else {
//            setUpBanner()
//        }
//    }
    
    func setUpBanner() {
        //        print(keychain.allKeys)
        //Change this add Unit id to below when ready to publish
        //        banner.adUnitID = "ca-app-pub-5243010963011406/1783105361"
        //            googleAdBanner = GADBannerView(adSize: kGADAdSizeBanner)
        if let google = googleAdBanner {
            //        if (keychain.getData("purchased", asReference: false))! {
            google.adUnitID = "ca-app-pub-3940256099942544/2934735716"
            google.delegate = self
            google.rootViewController = self
            google.load(GADRequest())
            google.frame = CGRect(x:  0, y: view.frame.size.height-50, width: view.frame.size.width, height: 50).integral
            self.view.addSubview(google)
            print("nope! here are ads, mf!!")
            //        } else {
            print("yikes")
            //        }
        }
    }
    //    }
    @objc func showSettings() {
        let sb = (storyboard?.instantiateViewController(withIdentifier: "settings"))!
        sb.modalTransitionStyle = .coverVertical
        sb.modalPresentationStyle = .overCurrentContext
        present(sb, animated: true, completion: nil)
    }
    
    
    //extension DashboardViewController: GADBannerViewDelegate {
    
    //MARK: - Google Ad Functions
    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
        // Add banner to view and add constraints as above.
        //        setUpBanner()
        print("ad received")
    }
    func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
        print("bannerView:didFailToReceiveAdWithError: \(error.localizedDescription)")
        print("ad error")
    }
    
    func bannerViewDidRecordImpression(_ bannerView: GADBannerView) {
        print("bannerViewDidRecordImpression")
        print("recorded")
        //        bannerView.isHidden = true
    }
    
    func bannerViewWillPresentScreen(_ bannerView: GADBannerView) {
        print("bannerViewWillPresentScreen")
    }
    
    func bannerViewWillDismissScreen(_ bannerView: GADBannerView) {
        print("bannerViewWillDismissScreen")
    }
    
    func bannerViewDidDismissScreen(_ bannerView: GADBannerView) {
        print("bannerViewDidDismissScreen")
    }
    func bannerViewDidRecordClick(_ bannerView: GADBannerView) {
//        setUpBanner()
        print("clicked")
    }
}
//MARK: - StoreKit Extension
extension DashboardViewController: SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    enum Product: String, CaseIterable {
        case ads = "com.Cleary.ads"
        case other = "some other content"
    }
    
    func noAds() {
        if SKPaymentQueue.canMakePayments() {
            let set : Set<String> = [Product.ads.rawValue]
            let productRequest = SKProductsRequest(productIdentifiers: set)
            productRequest.delegate = self
            productRequest.start()
        }
        KeychainWrapper.standard.set(false, forKey: "hidden")
//        self.view.reloadInputViews()
        
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        if let oProduct = response.products.first {
            print("Product is available")
            //buy function
            self.purchase(aproduct: oProduct)
        } else {
            print("Product is not available")
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        //        let main = DashboardViewController()
        
        for transaction in transactions {
            switch transaction.transactionState {
                case .purchasing:
                    print("Customer is about to purchase")
                case .purchased:
                    //                    keychain.set("noAds", forKey: "purchased")
                    do {
                        try Locksmith.saveData(data: ["did purchase ads" : "yes"], forUserAccount: "Randomizer")
                    } catch {
                        //Could not save
                        print("ruh roh")
                    }
//                    DashboardViewController.adsRemoval = true
                    print("Purchase complete")
                    print(transaction.payment.productIdentifier)
                    print("donesooooo")
//                    global.noAds = true
                    //                    main.googleAdHeight?.constant = 0.0
                    //                    main.googleAdBanner?.isHidden = true
                    //                    global.adViewHeight.constant = 0.0
                    SKPaymentQueue.default().finishTransaction(transaction)
                    dismiss(animated: true, completion: nil)
                case .failed:
                    SKPaymentQueue.default().finishTransaction(transaction)
                    print("Purchase failed")
                case .deferred:
                    print("deferred")
                case .restored:
                    print("restored")
                @unknown default:
                    print("ruh-roh")
            }
            
        }
        
    }
    func purchase(aproduct: SKProduct) {
        let payment = SKPayment(product: aproduct)
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().add(payment)
    }
}

