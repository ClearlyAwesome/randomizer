//
//  MyFormViewController.swift
//  randomGenerator
//
//  Created by R C on 11/29/21.
//

import UIKit
import Eureka
import MapKit
import ImageRow
import PostalAddressRow
import SplitRow
import ViewRow
import AVKit
import AVFoundation
import SwiftUI


class MyFormViewController: FormViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    //MARK: - Starter Variables
    let longitude = CLLocationManager().location?.coordinate.longitude
    let latitude = CLLocationManager().location?.coordinate.latitude
    let secondsPerDay = 24 * 60 * 60
    let initialHeight = Float(200.0)
    let mapDetails = MapViewController()
    let options = ["Facebook", "Insta", "Yolo", "YouTube"]
    let optionss = ["dog", "horse", "snake", "ferret"]
    @State private var counter = 0
    var navigationOptionsBackup : RowNavigationOptions?
    let submitAndPayButton = UIButton()
    
    var rowHeight = CGFloat()
    var videoPlayer:AVPlayer?
    var videoPlayerLayer:AVPlayerLayer?
    var playerLooper:NSObject?
    let myForm = Form()
    let myRow  = SwitchRow("SwitchRow") { row in      // initializer
        row.title = "The title"
    }.onChange { row in
        row.title = (row.value ?? false) ? "The title expands when on" : "The title"
        row.updateCell()
    }.cellSetup { cell, row in
        cell.backgroundColor = .lightGray
    }.cellUpdate { cell, row in
        cell.textLabel?.font = .italicSystemFont(ofSize: 18.0)
    }
    let myButton = UIButton(frame: CGRect(x: 100,
                                          y: 100,
                                          width: 200,
                                          height: 100))
    var leftValue = String()
    var rightValue = String()
    let helpMe = UIImage(systemName: "questionmark.circle.fill")
    typealias Emoji = String
    typealias Switcher = Image
    let 👦🏼 = "👦🏼", 🍐 = "🍐", 💁🏻 = "💁🏻", 🐗 = "🐗", 🐼 = "🐼", 🐻 = "🐻", 🐖 = "🐖", 🐡 = "🐡"
    let continents = ["Africa", "Antarctica", "Asia", "Australia", "Europe", "North America", "South America"]
    let devices = ["iPhone6", "iPhone7","iPhone10", "iPhone11","iPhone12", "iPhone13", "iPhone14"]
    let deleteAction = SwipeAction(style: .destructive, title: "Delete", handler: { (action, row, completionHandler) in
        print("Delete")
        completionHandler?(true)
    })
   
    //MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        settings()
       

//        displayForm()
        //        createForm()
        //        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swiped(sender:)))
        //        rightSwipe.direction = .left
        //        self.tableView.addGestureRecognizer(rightSwipe)
    }
    //MARK: - Functions
    @objc func multipleSelectorDone(_ item:UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
    }
    //    @objc func swiped(sender:UIGestureRecognizer){
    //            print("Swiped.....!")
    //        }
    @objc func cancel(_ item:UIBarButtonItem) {
        dismiss(animated: true)
    }
    @objc func done(_ item:UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
        printMe()
    }
    func printMe() {
        let errors = form.validate()
        if (errors.count > 0) {
            print("ruh-roh")
        } else {
            print("saved")
        }
    }
    func showAlert() {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        let titleAttributes = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 25)!, NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
        let titleString = NSAttributedString(string: "Submit and Pay?", attributes: titleAttributes)
        let messageAttributes = [NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 17)!, NSAttributedString.Key.foregroundColor: UIColor.black]
        let messageString = NSAttributedString(string: "\nBy clicking 'I agree' you are acknowledging the Terms of Service, Privacy Policy, and Billing Terms.\n\nYou have reviewed all fields prior to submitting.", attributes: messageAttributes)
        alert.setValue(titleString, forKey: "attributedTitle")
        alert.setValue(messageString, forKey: "attributedMessage")
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        alert.addAction(UIAlertAction(title: "I agree", style: .default, handler: nil))
        alert.isSpringLoaded = true
        present(alert, animated: true, completion: nil)
    }
    func showMe() {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        let titleAttributes = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 25)!, NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
        let titleString = NSAttributedString(string: "Change Cover Image?", attributes: titleAttributes)
        let messageAttributes = [NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 17)!, NSAttributedString.Key.foregroundColor: UIColor.black]
        let messageString = NSAttributedString(string: "Yes! I want to change my cover image", attributes: messageAttributes)
        alert.setValue(titleString, forKey: "attributedTitle")
        alert.setValue(messageString, forKey: "attributedMessage")
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
        alert.isSpringLoaded = true
        present(alert, animated: true, completion: nil)
    }
    func addRow() {
        let newRow = form.allRows.index(after: 15)
        print("newRow")
        print(newRow)
        print(newRow.description)
        self.navigationItem.title = "Create an Ad in 2 Steps:"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(MyFormViewController.done(_:)))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(MyFormViewController.cancel(_:)))
        animateScroll = true
        // Leaves 20pt of space between the keyboard and the highlighted row after scrolling to an off screen row
        rowKeyboardSpacing = 15
        tableView.tableFooterView = UIView()
        form = Section()
        +++ TextRow("Nameerr"){
            $0.title = $0.tag
            $0.placeholder = "Enter text here"
            $0.add(rule: RuleRequired())
            $0.validationOptions = .validatesOnChangeAfterBlurred
        }
        +++ ButtonRow("Tell Me Meeee"){
            $0.title = $0.tag
        } .onCellSelection({ cell, row in
            self.createForm()
        })
    }
    @objc func switchValueChanged(){
        print("hey")
    }
    @objc func buttonAction() {
        print("Button pressed")
    }
    @objc func pressed() {
        self.showAlert()
    }
    @IBAction func openPhotoLibraryButton(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            var imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
//    [];
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
            submitAndPayButton.setImage(UIImage(named: "snake"), for: .normal)
        }
    }
    @IBAction func showEdit(_ sender: UIButton) {
//        showEditProfilePage()
        let menuItems = UIMenu(title: "More", options: .displayInline, children: [
            UIAction(title: "Edit Profile", image: UIImage(systemName: "pencil.circle"), handler: { _ in
                self.showAlert()
            }),
            UIAction(title: "Edit Profile Photo", image: UIImage(systemName: "camera"), handler: { _ in //do action here
                self.openPhotoLibraryButton(sender: UIButton())
            }),
            UIAction(title: "Edit Cover Photo", image: UIImage(systemName: "camera"), handler: { _ in //do action here
            }),
        ])
        let menu = UIMenu(title: "", children: [menuItems])
        sender.menu = menu
        sender.showsMenuAsPrimaryAction = true
    }
    @objc func sliderValueDidChange(sender:UISlider!)
    {
        print(Int(sender.value))
    }
    
    //MARK: - Main Function
    func createForm() {
        self.navigationItem.title = "Create an Ad in 2 Steps:"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(MyFormViewController.done(_:)))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(MyFormViewController.cancel(_:)))
        animateScroll = true
        // Leaves 20pt of space between the keyboard and the highlighted row after scrolling to an off screen row
        rowKeyboardSpacing = 15
        tableViewStyle = .insetGrouped
        tableView.layer.cornerRadius = 25.0
        tableView.tableFooterView = UIView()
        SegmentedRow<String>.defaultCellSetup = { cell, row in
            cell.segmentedControl.backgroundColor = .systemTeal
            
        }
        SegmentedRow<String>.defaultCellUpdate = { cell, row in
            if self.traitCollection.userInterfaceStyle == .dark {
                cell.segmentedControl.selectedSegmentTintColor = .black
            } else {
                cell.segmentedControl.selectedSegmentTintColor = .white
            }
        }
        SwitchRow.defaultCellUpdate = {  cell, row in
            if self.traitCollection.userInterfaceStyle == .dark {
                cell.switchControl.onTintColor = .purple
            } else {
                cell.switchControl.onTintColor = .systemTeal
            }
        }
        TimeRow.defaultCellSetup = { cell, row in
            let date = DateFormatter()
            date.pmSymbol = "PM"
            date.amSymbol = "AM"
        }
        TimeRow.defaultCellUpdate = { cell, row in
            let date = DateFormatter()
            date.pmSymbol = "PM"
            date.amSymbol = "AM"
        }
        
        form = Section()
        <<< SegmentedRow<String>("segments"){
            $0.options = ["About You","Details"]
            //            "Ad Catalog"
            $0.value = "About You"
        }
        //MARK: - Section 1 About You
        +++ Section("About You"){
            $0.tag = "About You"
            $0.hidden = "$segments != 'About You'"
        }
        <<< TextRow("Name"){
            $0.title = $0.tag
            $0.placeholder = "Enter text here"
            $0.add(rule: RuleRequired())
            $0.validationOptions = .validatesOnChangeAfterBlurred
        }
        .cellUpdate { cell, row in
            if !row.isValid {
                cell.titleLabel?.textColor = .systemRed
            }
        }
        <<< PhoneRow("Phone Number"){
            $0.title = $0.tag
            $0.placeholder = "Enter phone #"
        }
        <<< TextRow("Email") {
            $0.title = $0.tag
            $0.placeholder = "support@geoGrid.com"
            $0.add(rule: RuleRequired())
            $0.add(rule: RuleEmail())
            $0.validationOptions = .validatesOnChangeAfterBlurred
        }
        .cellUpdate { cell, row in
            if !row.isValid {
                cell.titleLabel?.textColor = .systemRed
            }
        }
        +++ Section("About Your Business"){
            $0.tag = "Your Business"
            $0.hidden = "$segments != 'About You'"
        }
        
        <<< TextRow("Business Name"){
            $0.title = $0.tag
            $0.placeholder = "Enter text here"
        }
        <<< PickerInputRow<String>("Business Type"){
            $0.title = $0.tag
            $0.options = ["Real Estate", "Automotive", "Political"]
            $0.value = $0.options.randomElement()
        }
        <<< URLRow("Business Website"){
            $0.title = $0.tag
            $0.placeholder = "www.geoGrid.com"
            $0.add(rule: RuleRequired())
            $0.add(rule: RuleURL())
            $0.validationOptions = .validatesOnChangeAfterBlurred
        }
        .cellUpdate { cell, row in
            if !row.isValid {
                cell.titleLabel?.textColor = .systemRed
            }
        }
        +++ Section("Business Address"){
            $0.tag = "Business Addy"
            $0.hidden = "$segments != 'About You'"
        }
        <<< PostalAddressRow() {
            //            $0.title = "Business Address"
            $0.streetPlaceholder = "Street"
            $0.cityPlaceholder = "City"
            $0.statePlaceholder = "State"
            $0.countryPlaceholder = "Country"
            $0.postalCodePlaceholder = "Zip code"
        }
        +++ Section(){
            $0.tag = "Profile"
            $0.hidden = "$segments != 'About You'"
        }
        <<< ButtonRow("Use my profile information"){ row in
            row.title =  row.tag
        }
        //        <<< ButtonRow("Sync With My Profile"){ row in
        //            row.title =  row.tag
        //            row.cell.tintColor = .systemRed
        //        }
        //        +++ MultivaluedSection(multivaluedOptions: [.Insert, .Delete],
        //                               header: "Social Media",
        //                               footer: "Allow your customers to reach out to you.") {
        //            $0.hidden = "$segments != 'About You'"
        //            $0.addButtonProvider = { section in
        //                return ButtonRow(){
        //                    $0.title = "Add Account"
        //                }
        //            }
        //            $0.multivaluedRowToInsertAt = { index in
        //                return SplitRow<ActionSheetRow<String>, AccountRow>(){
        //                    $0.rowLeft = ActionSheetRow<String>(){
        //                        $0.options = ["Facebook","Twitter","Instagram","Phone #"]
        //                        $0.value = "Select"
        //                    }
        //                    $0.rowRight = AccountRow(){
        //                        $0.placeholder = "Type Here"
        //                        $0.value = "@GeoGrid"
        //                    }.cellUpdate{ cell, row in
        //                        cell.textField?.clearButtonMode = .whileEditing
        //                        cell.textField?.textAlignment = .center
        //                    }
        //                }
        //            }
        //            $0 <<< SplitRow<ActionSheetRow<String>, AccountRow>(){
        //                $0.rowLeft = ActionSheetRow<String>(){
        //                    $0.options = ["Facebook","Twitter","Instagram","Phone #"]
        //                    $0.value = "Select"
        //                }
        //                $0.rowRight = AccountRow(){
        //                    $0.placeholder = "Type Here"
        //                    $0.value = "@GeoGrid"
        //                }.cellUpdate{ cell, row in
        //                    cell.textField?.clearButtonMode = .whileEditing
        //                    cell.textField?.textAlignment = .center
        //                }
        //            }
        //        }
        //MARK: - Section 2 Ad Details
        
        +++ Section("Campaign Details"){
            $0.tag = "Details"
            $0.hidden = "$segments != 'Details'" // .Predicate(NSPredicate(format: "$segments != 'Sport'"))
        }
        <<< TextRow("Ad Campaign Name"){
            $0.title = $0.tag
            $0.placeholder = "Enter text here"
            $0.add(rule: RuleRequired())
            $0.validationOptions = .validatesOnChangeAfterBlurred
        }
        .cellUpdate { cell, row in
            if !row.isValid {
                cell.titleLabel?.textColor = .systemRed
            }
        }
        <<< TextRow("Message to Audience"){ row in
            row.title = row.tag
            row.placeholder = "Enter text here"
            row.add(rule: RuleRequired())
            row.validationOptions = .validatesOnChangeAfterBlurred
            row.cell.height = {100}
            row.cell.textLabel?.numberOfLines = 0
        }
        .cellUpdate { cell, row in
            if !row.isValid {
                cell.titleLabel?.textColor = .systemRed
            }
        }
        <<< TextRow("Ad Cover Image URL"){
            $0.title = $0.tag
            $0.placeholder = "Enter text here"
        }
        <<< ImageRow() { row in
            row.title = "Ad Cover Page"
            row.sourceTypes = [.PhotoLibrary, .SavedPhotosAlbum]
            row.clearAction = .yes(style: UIAlertAction.Style.destructive)
        }
        +++ Section("Advertising Numbers"){
            $0.tag = "Duration"
            $0.hidden = "$segments != 'Details'" // .Predicate(NSPredicate(format: "$segments != 'Sport'"))
        }
        <<< DecimalRow("Budget For Ad"){
            $0.useFormatterDuringInput = true
            $0.title = $0.tag
            $0.value = 2015
            let formatter = CurrencyFormatter()
            formatter.locale = .current
            formatter.numberStyle = .currency
            $0.formatter = formatter
        }
        <<< DateInlineRow("Start Date"){
            $0.title = $0.tag
            $0.value = Date()
            let formatter = DateFormatter()
            formatter.locale = .current
            formatter.dateStyle = .long
            $0.dateFormatter = formatter
        }
        <<< DateInlineRow("End Date"){
            $0.title = $0.tag
            $0.value = Date(timeInterval: Double(+secondsPerDay) * Double(10), since: Date())
            let formatter = DateFormatter()
            formatter.locale = .current
            formatter.dateStyle = .long
            $0.dateFormatter = formatter
        }
        <<< SwitchRow("Enter Blackout times"){
            $0.title = $0.tag
        } .cellSetup({ cell, row in
            
            //                .row.addTarget(self, action: #selector(switchValueChanged: _), for: .valueChanged)
        })
        <<< TimeRow("Starting Time"){
            $0.title = $0.tag
            $0.hidden = .function(["Enter Blackout times"], { form -> Bool in
                let row: RowOf<Bool>! = form.rowBy(tag: "Enter Blackout times")
                return row.value ?? false == false
            })
        }
        <<< TimeRow("Ending Time"){
            $0.title = $0.tag
            $0.hidden = .function(["Enter Blackout times"], { form -> Bool in
                let row: RowOf<Bool>! = form.rowBy(tag: "Enter Blackout times")
                return row.value ?? false == false
            })
        }
        
        +++ Section("Ad Location"){
            $0.hidden = "$segments != 'Details'" // .Predicate(NSPredicate(format: "$segments != 'Sport'"))
        }
        <<< SegmentedRow<String>("Drop Location") {
            $0.title = $0.tag
            $0.options = ["Point on Map","Address", "Country"]
            $0.value = "Point on Map"
            $0.hidden = "$segments != 'Details'"
        }
        
        <<< LocationRow("Ad Drop Location"){
            $0.title = $0.tag
            $0.value = CLLocation(latitude: latitude ?? -34.9124, longitude: longitude ?? -56.1594)
            $0.validationOptions = .validatesOnChange //2
            $0.cellUpdate { (cell, row) in //3
                if !row.isValid {
                    cell.textLabel?.textColor = .red
                } else {
                    let lastLocation = row.value
                    let geocoder = CLGeocoder()
                    geocoder.reverseGeocodeLocation(lastLocation!,
                                                    completionHandler: { (placemarks, error) in
                        if error == nil {
                            let place = placemarks![0]
                            var adressString : String = ""
                            if place.thoroughfare != nil {
                                adressString = adressString + place.thoroughfare! + ", "
                            }
                            if place.subThoroughfare != nil {
                                adressString = adressString + place.subThoroughfare! + " "
                            }
                            if place.locality != nil {
                                adressString = adressString + place.locality! + " - "
                            }
                            if place.postalCode != nil {
                                adressString = adressString + place.postalCode! + " "
                            }
                            if place.subAdministrativeArea != nil {
                                adressString = adressString + place.subAdministrativeArea! + " - "
                            }
                            if place.country != nil {
                                adressString = adressString + place.country!
                            }
                            
                            //                            row.value = adressString.trimmingCharacters(in: .whitespacesAndNewlines)
                        }
                    })
                }
            }
        }
        <<< SliderRow("Diameter from location") {
            $0.title = $0.tag
            $0.value = 30
        } .cellSetup({ cell, row in
            cell.tintColor = .systemTeal
            
        })
        //MARK: - Address Segmented Fields
        <<< TextRow("Address Block") {
            $0.title = "Address"
            $0.placeholder = "Enter address here"
            $0.hidden = "$segments != 'Address'"
        }
        +++ MultivaluedSection(multivaluedOptions: [.Insert, .Delete],
                               header: "Customer Reach",
                               footer: "Filter out the customers you want. \n*Note: Some customers have these traits disabled.") {
            $0.hidden = "$segments != 'Details'"
            $0.addButtonProvider = { section in
                return ButtonRow(){
                    $0.title = "Add New Tag"
                }
            }
            $0.multivaluedRowToInsertAt = { index in
                return SplitRow<ActionSheetRow<String>, MultipleSelectorRow<String>>(){
                    $0.rowLeft = ActionSheetRow<String>(){
                        $0.options = ["Religion","Ethnicity","Gender", "Country", "Age", "Devices", "Pets", "Car Type"]
                        $0.value = "Select Trait"
                    }   .onCellSelection({ cell, row in
                        self.leftValue = cell.row.value!
                        print(self.leftValue)
                    })  .cellUpdate({ cell, row in
                        self.leftValue = cell.row.value!
                        print(self.leftValue)
                    })
                    $0.rowRight = MultipleSelectorRow<String>(){
                        $0.title = $0.tag
                    } .onPresent { from, to in
                        to.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: from, action: #selector(MyFormViewController.multipleSelectorDone(_:)))
                        
                    } .onCellSelection({ cell, row in
                        switch self.leftValue {
                            case "Religion":
                                row.options = ["Christianity", "Roman Catholic","Protestant", "Hebrew", "Lutheran","Buddhist"]
                            case "Ethnicity":
                                row.options = ["Caucasian", "African American","Hispanic", "Alaskan", "Canadian","Arabic"]
                            case "Gender":
                                row.options = ["Male", "Female", "Other", "All"]
                            case "Age":
                                row.options = ["Christianity", "Roman Catholic","Protestant", "Hebrew", "Lutheran","Buddhist"]
                            case "Country":
                                row.options = ["USA", "France","Italy", "Cairo", "Canada","Germany"]
                            case "Devices":
                                row.options = self.devices
                            case "Pets":
                                row.options = ["Dog", "Cat","Fish", "Amphibians", "Llama","Exotic"]
                            case "Car Type":
                                row.options = ["Honda", "Dodge", "Toyota", "Chevrolet", "Tesla", "BMW", "Mercedes Benz"]
                            default:
                                row.options = ["There's been an error. Please select again."]
                        }
                    }) .cellUpdate({ cell, row in
                        switch self.leftValue {
                            case "Religion":
                                row.options = ["Christianity", "Roman Catholic","Protestant", "Hebrew", "Lutheran","Buddhist"]
                            case "Ethnicity":
                                row.options = ["Caucasian", "African American","Hispanic", "Alaskan", "Canadian","Arabic"]
                            case "Gender":
                                row.options = ["Male", "Female", "Other", "All"]
                            case "Age":
                                row.options = ["Christianity", "Roman Catholic","Protestant", "Hebrew", "Lutheran","Buddhist"]
                            case "Country":
                                row.options = ["USA", "France","Italy", "Cairo", "Canada","Germany"]
                            case "Devices":
                                row.options = self.devices
                            case "Pets":
                                row.options = ["Dog", "Cat","Fish", "Amphibians", "Llama","Exotic"]
                            case "Car Type":
                                row.options = ["Honda", "Dodge", "Toyota", "Chevrolet", "Tesla", "BMW", "Mercedes Benz"]
                            default:
                                row.options = ["There's been an error. Please select again."]
                        }
                    }).cellSetup({ cell, row in
                        switch self.leftValue {
                            case "Religion":
                                row.options = ["Christianity", "Roman Catholic","Protestant", "Hebrew", "Lutheran","Buddhist"]
                            case "Ethnicity":
                                row.options = ["Caucasian", "African American","Hispanic", "Alaskan", "Canadian","Arabic"]
                            case "Gender":
                                row.options = ["Male", "Female", "Other", "All"]
                            case "Age":
                                row.options = ["Christianity", "Roman Catholic","Protestant", "Hebrew", "Lutheran","Buddhist"]
                            case "Country":
                                row.options = ["USA", "France","Italy", "Cairo", "Canada","Germany"]
                            case "Devices":
                                row.options = self.devices
                            case "Pets":
                                row.options = ["Dog", "Cat","Fish", "Amphibians", "Llama","Exotic"]
                            case "Car Type":
                                row.options = ["Honda", "Dodge", "Toyota", "Chevrolet", "Tesla", "BMW", "Mercedes Benz"]
                            default:
                                row.options = ["There's been an error. Please select again."]
                        }
                    })
                }
            }
        }
        +++ MultivaluedSection(multivaluedOptions: [.Reorder, .Insert, .Delete],
                               header: "Action Buttons",
                               footer: "Adds an action for the user to take on your AD. \nAdd your social media accounts to the AD.") {
            $0.hidden = "$segments != 'Details'"
            $0.addButtonProvider = { section in
                return ButtonRow(){
                    $0.title = "Add New Tag"
                }
            }
            $0.multivaluedRowToInsertAt = { index in
                return SplitRow<ActionSheetRow<String>, URLRow>(){
                    $0.rowLeft = ActionSheetRow<String>(){
                        $0.options = ["Go To Store","Directions","Survey", "Download","Facebook","Twitter","Instagram","Phone #"]
                        $0.value = $0.options!.randomElement()
                    }
                    $0.rowRight = URLRow(){
                        $0.placeholder = "www.geoGrid.com"
                        $0.add(rule: RuleRequired())
                        $0.add(rule: RuleURL())
                        $0.validationOptions = .validatesOnChangeAfterBlurred
                        //                        $0.placeholder = "Username"
                    }.cellUpdate{ cell, row in
                        cell.textField?.clearButtonMode = .whileEditing
                        cell.textField?.textAlignment = .right
                    } .cellSetup({ cell, row in
                        cell.textLabel?.numberOfLines = 0
                    })
                }
            }
            $0 <<< SplitRow<ActionSheetRow<String>, URLRow>(){
                $0.rowLeft = ActionSheetRow<String>(){
                    $0.options = ["Go To Store","Directions","Survey", "Download","Facebook","Twitter","Instagram","Phone #"]
                    $0.value = "Go To Store"
                } .cellSetup({ cell, row in
                    cell.tintColor = .red
                    
                })
                $0.rowRight = URLRow(){
                    $0.placeholder = "www.geoGrid.com"
                    $0.add(rule: RuleRequired())
                    $0.add(rule: RuleURL())
                    $0.validationOptions = .validatesOnChangeAfterBlurred
                    //                        $0.placeholder = "Username"
                }.cellUpdate{ cell, row in
                    cell.textField?.clearButtonMode = .whileEditing
                    cell.textField?.textAlignment = .right
                }
            }
        }
        
        +++ Section("Advanced Options"){
            $0.tag = "Catalog"
            $0.hidden = "$segments != 'Details'" // .Predicate(NSPredicate(format: "$segments != 'Sport'"))
        }
        //        +++ Section(footer: "Billboard adds a map pin with an Icon \nMap Pin adds a dot the user can click on."){
        //            $0.tag = "Your ad"
        //            $0.hidden = "$segments != 'Details'" // .Predicate(NSPredicate(format: "$segments != 'Sport'"))
        //        }
        
        <<< SwitchRow("Add to Catalog?"){
            $0.title = $0.tag
        } .cellSetup({ cell, row in
            cell.imageView?.image = self.helpMe
        })
        <<< SegmentedRow<String> { (row) in
            row.title = "Type"
            row.options = ["Billboard", "Map Pin", "Both"]
            row.value = "Map Pin"
        }
        .cellSetup { (cell, row) in
            cell.segmentedControl.setContentHuggingPriority(UILayoutPriority(rawValue: 750), for: .horizontal)
            cell.segmentedControl.apportionsSegmentWidthsByContent = false
            cell.imageView?.image = self.helpMe
            cell.imageView?.image?.withTintColor(.blue)
        }
        .onChange { [unowned self] (row) in
            guard let imageName = row.value else { return }
            guard let imageRow = self.form.rowBy(tag: "xxxx") as? ViewRow<UIImageView> else { return }
            
            let image = UIImage(named: imageName)
            imageRow.cell.view!.image = image
        }     .onCellSelection({ cell, row in
            self.showAlert()
        })
        
        <<< ViewRow<UIImageView>("xxxx")
            .cellSetup { (cell, row) in
                //  Construct the view for the cell
                cell.view = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 300))
                cell.view!.contentMode = .scaleAspectFit
                cell.view!.clipsToBounds = true
                
                //  Get something to display
                let image = UIImage(named: "Billboard")
                cell.view!.image = image
                
                //  Make the image view occupy the entire row:
                cell.viewRightMargin = 0.0
                cell.viewLeftMargin = 0.0
                cell.viewTopMargin = 0.0
                cell.viewBottomMargin = 0.0
            }
        
        //        <<< ViewRow("view") { (row) in
        //                            row.title = "My View Title" // optional
        //                        }
        //                        .cellSetup { (cell, row) in
        //                            //  Construct the view
        //                            let bundle = Bundle.main
        //                            let nib = UINib(nibName: "CoinViewController", bundle: bundle)
        //                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //                            let vc = storyboard.instantiateViewController(withIdentifier: "numbers")
        //                            vc.modalPresentationStyle = .automatic
        //                            cell.view = storyboard.instantiateViewController(withIdentifier: "numbers")
        //                            cell.view?.backgroundColor = cell.backgroundColor
        //                        }
        //MARK: - Section 3 Customer
        +++ Section(){
            $0.tag = "Customer2"
            $0.hidden = "$segments != 'Details'"
        }
        //MARK: - Video Row: This works.
        //I am using a VIEW ROW but playing a video in it. This is going to be very useful in the future.
        //        <<< ViewRow<UIView>()
        //            .cellSetup { [self] (cell, row) in
        //                            //  Construct the view - in this instance the a rudimentary view created here
        //                            cell.view = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 200))
        ////
        //                            // Get the path to the resource in the bundle
        //                                   let bundlePath = Bundle.main.path(forResource: "GeoGrid", ofType: "m4v")
        //                                   guard bundlePath != nil else {
        //                                       return
        //                                   }
        //
        //                                   // Create a URL from it
        //                                   let url = URL(fileURLWithPath: bundlePath!)
        //
        //                                   // Create the video player item
        //                                   let item = AVPlayerItem(url: url)
        //
        //                                   // Assign an array of 1 item to AVQueuePlayer
        //                                   videoPlayer = AVQueuePlayer(items: [item])
        //
        //                                   // Loop the video
        //                                   playerLooper = AVPlayerLooper(player: videoPlayer! as! AVQueuePlayer, templateItem: item)
        //
        //                                   // Create the layer
        //                                   videoPlayerLayer = AVPlayerLayer(player: videoPlayer)
        //
        //                                   // Adjust the size and frame
        //                videoPlayerLayer!.frame = cell.view!.bounds
        //                                   videoPlayerLayer!.videoGravity = AVLayerVideoGravity.resizeAspectFill
        //                                   cell.layer.addSublayer(videoPlayerLayer!)
        //
        //                                   // Add it to the view and play it
        //                                   videoPlayer?.play()
        //
        //                            //  Adjust the cell margins to suit
        //                            cell.viewTopMargin = 0.0
        //                            cell.viewBottomMargin = 0.0
        //                            cell.viewLeftMargin = 0.0
        //                            cell.viewRightMargin = 0.0
        //
        //                        }
        <<< ViewRow<UIView>()
            .cellSetup { [self] (cell, row) in
                cell.view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
                //                cell.view!.backgroundColor = UIColor.orange
                tableView.separatorStyle = .none
                let submitAndPayButton = UIButton()
                submitAndPayButton.setTitle("Submit for payment", for: .normal)
                submitAndPayButton.setTitleColor(.white, for: .normal)
                submitAndPayButton.backgroundColor = .systemTeal
                submitAndPayButton.layer.cornerRadius = 25.0
                submitAndPayButton.frame = CGRect(x: 100, y: 0, width: 200, height: 50)
                cell.backgroundColor = .clear
                submitAndPayButton.addTarget(self, action: #selector(pressed), for: .touchUpInside)
                cell.addSubview(submitAndPayButton)
            }
    }
    func displayForm() {
        self.navigationItem.title = "Edit Profile:"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(MyFormViewController.done(_:)))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(MyFormViewController.cancel(_:)))
//        self.navigationController?.navigationBar.backgroundImage(for: UIImage(named: "background5")) as! UIBarMetrics
        self.navigationController?.navigationBar.addSubview(submitAndPayButton)
        animateScroll = false
        // Leaves 15pt of space between the keyboard and the highlighted row after scrolling to an off screen row
        rowKeyboardSpacing = 15
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        form = Section()
        //MARK: - Section 1 About You
        +++ Section(){
            $0.tag = "About You"
        }
        <<< ViewRow<UIImageView>("x2xxx")
            .cellSetup { [self] (cell, row) in
                //  Construct the view for the cell
                cell.view = UIImageView(frame: CGRect(x: 0, y: 0, width: 400, height: 100))
                cell.view!.contentMode = .scaleAspectFill
                cell.view!.clipsToBounds = true
                
                //  Get something to display
//                let image = UIImage(named: "background5")
//                cell.view!.image = image
                
                //  Make the image view occupy the entire row:
                cell.viewRightMargin = 0.0
                cell.viewLeftMargin = 0.0
                cell.viewTopMargin = 0.0
                cell.viewBottomMargin = 0.0
                let stackView = UIStackView()
                stackView.axis = .horizontal
                stackView.alignment = .fill // .leading .firstBaseline .center .trailing .lastBaseline
                stackView.distribution = .fill // .fillEqually .fillProportionally .equalSpacing .equalCentering

                let label = UILabel()
                label.text = "Text"
                label.textColor = .red
                stackView.addArrangedSubview(label)
                // for horizontal stack view, you might want to add width constraint to label or whatever view you're adding.
                
                submitAndPayButton.clipsToBounds = true
//                                submitAndPayButton.setTitle("Submit for payment", for: .normal)
                submitAndPayButton.setImage(UIImage(named: "dog"), for: .normal)
                //                submitAndPayButton.setTitleColor(.white, for: .normal)
                //                submitAndPayButton.backgroundColor = .systemTeal
                submitAndPayButton.layer.cornerRadius = 25.0
                submitAndPayButton.center = cell.view!.center
                submitAndPayButton.frame = CGRect(x: (row.view?.center.x)!-45, y: (row.view?.center.y)!, width: 100, height: 100)
//                cell.backgroundColor = .clear
                submitAndPayButton.addTarget(self, action: #selector(self.showEdit), for: .touchUpInside)
                cell.addSubview(submitAndPayButton)
                cell.addSubview(stackView)
            } .onCellSelection({ cell, row in
                self.showEdit(UIButton())
            })
        +++ Section(){
            $0.hidden = false
        }
        +++ Section(){
            $0.hidden = false
        }
        <<< TextRow(){
            $0.title = "User Name:"
            $0.placeholder = "Joliet123"
        }
        <<< MultipleSelectorRow<String>() {
            $0.title = "Pet Type"
            $0.options = ["Cat", "Dog", "Lizard", "Horse", "Ferret", "Fish"]
//            $0.value = "Dog"
            $0.selectorTitle = "Choose your pet!"
        }
        .onPresent { from, to in
            to.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: from, action: #selector(MyFormViewController.multipleSelectorDone(_:)))
        }
        <<< CheckRow() {
                       $0.title = "CheckRow"
                       $0.value = true
                   }
        <<< TextRow(){
            $0.title = "Event Title:"
            $0.placeholder = "Enter event name"
        } .cellSetup({ cell, row in
            cell.height = {60}
        })
        <<< TextAreaRow() {
            $0.title = "More Info"
        }
        +++ Section("Tell You"){
            $0.tag = "Tell You"
        }
        <<< SplitRow<TextRow, StepperRow>(){
            $0.rowLeft = TextRow(){
                $0.value = "Minimum Age:"
            } .cellSetup({ cell, row in
                cell.tintColor = .red
                
            })
            $0.rowRight = StepperRow() {
                $0.value = 1
            }
        }
        <<< SplitRow<TextRow, StepperRow>(){
            $0.rowLeft = TextRow(){
                $0.value = "Cover Charge:"
            } .cellSetup({ cell, row in
                cell.tintColor = .red
                
            })
            $0.rowRight = StepperRow() {
                $0.value = 1
            } .cellSetup({ cell, row in
                cell.tintColor = .green
            })
        }
        <<< SplitRow<LabelRow, TextAreaRow>(){
            $0.rowLeft = LabelRow(){
                $0.value = "More Information"
            } .cellSetup({ cell, row in
                cell.tintColor = .red
            })
            $0.rowRight = TextAreaRow() {
                $0.title = "More Info"
                $0.textAreaHeight = .dynamic(initialTextViewHeight: 80)
            }
            
        }
        
    }
    func settings() {
        self.navigationItem.title = "Settings"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(MyFormViewController.done(_:)))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(MyFormViewController.cancel(_:)))
        animateScroll = true
        // Leaves 20pt of space between the keyboard and the highlighted row after scrolling to an off screen row
        rowKeyboardSpacing = 15
        tableViewStyle = .insetGrouped
        tableView.layer.cornerRadius = 25.0
        tableView.tableFooterView = UIView()
     
        SwitchRow.defaultCellUpdate = {  cell, row in
            if self.traitCollection.userInterfaceStyle == .dark {
                cell.switchControl.onTintColor = .purple
            } else {
                cell.switchControl.onTintColor = .systemTeal
            }
        }
        form = Section()

        //MARK: - Settings: Section 1 (General)
        +++ Section(){
            $0.tag = "General"
        }
        <<< PushRow<String>() {
                       $0.title = "Notifications"
//            $0.
            $0.options = ["hey", "heerey", "he43y", "yyhey"]
            $0.value = "hey"
                       $0.selectorTitle = "Choose an Emoji!"
                       }
                       .onPresent { from, to in
                       
                           to.selectableRowCellUpdate = { cell, row in
                               var detailText: String?
                               switch row.selectableValue {
                                   case "hey" : detailText = "Person"
                               case "he43y": detailText = "Animal"
                               case "yyhey": detailText = "Food"
                               default: detailText = ""
                               }
                               cell.detailTextLabel?.text = detailText
                           }
                       } .cellSetup({ cell, row in
                           cell.imageView?.image = UIImage(named: "dog")
                       })
   
        <<< PushRow<String>() {
                       $0.title = "Notifications"
//            $0.
            $0.options = ["hey", "heerey", "he43y", "yyhey"]
            $0.value = "hey"
                       $0.selectorTitle = "Choose an Emoji!"
                       }
                       .onPresent { from, to in
                       
                           to.selectableRowCellUpdate = { cell, row in
                               var detailText: String?
                               switch row.selectableValue {
                                   case "hey" : detailText = "Person"
                               case "he43y": detailText = "Animal"
                               case "yyhey": detailText = "Food"
                               default: detailText = ""
                               }
                               cell.detailTextLabel?.text = detailText
                           }
                       } .cellSetup({ cell, row in
                           cell.imageView?.image = UIImage(named: "dog")
                       })
        <<< PushRow<String>() {
                       $0.title = "Notifications"
//            $0.
            $0.options = ["hey", "heerey", "he43y", "yyhey"]
            $0.value = "hey"
                       $0.selectorTitle = "Choose an Emoji!"
                       }
                       .onPresent { from, to in
                       
                           to.selectableRowCellUpdate = { cell, row in
                               var detailText: String?
                               switch row.selectableValue {
                                   case "hey" : detailText = "Person"
                               case "he43y": detailText = "Animal"
                               case "yyhey": detailText = "Food"
                               default: detailText = ""
                               }
                               cell.detailTextLabel?.text = detailText
                           }
                       } .cellSetup({ cell, row in
                           cell.imageView?.image = UIImage(named: "dog")
                       })

        <<< PushRow<String>() {
                       $0.title = "Notifications"
//            $0.
            $0.options = ["hey", "heerey", "he43y", "yyhey"]
            $0.value = "hey"
                       $0.selectorTitle = "Choose an Emoji!"
                       }
                       .onPresent { from, to in
                       
                           to.selectableRowCellUpdate = { cell, row in
                               var detailText: String?
                               switch row.selectableValue {
                                   case "hey" : detailText = "Person"
                               case "he43y": detailText = "Animal"
                               case "yyhey": detailText = "Food"
                               default: detailText = ""
                               }
                               cell.detailTextLabel?.text = detailText
                           }
                       } .cellSetup({ cell, row in
                           cell.imageView?.image = UIImage(named: "dog")
                       })

        <<< PushRow<String>() {
                       $0.title = "Notifications"
//            $0.
            $0.options = ["hey", "heerey", "he43y", "yyhey"]
            $0.value = "hey"
                       $0.selectorTitle = "Choose an Emoji!"
                       }
                       .onPresent { from, to in
                       
                           to.selectableRowCellUpdate = { cell, row in
                               var detailText: String?
                               switch row.selectableValue {
                                   case "hey" : detailText = "Person"
                               case "he43y": detailText = "Animal"
                               case "yyhey": detailText = "Food"
                               default: detailText = ""
                               }
                               cell.detailTextLabel?.text = detailText
                           }
                       } .cellSetup({ cell, row in
                           cell.imageView?.image = UIImage(named: "dog")
                       })
        +++ Section("Legal"){
            $0.tag = "Legal"
            Stepper("The counter is \(self.counter)", value: self.$counter)
        }
        <<< PushRow<String>() {
                       $0.title = "About"
            $0.options = ["hey", "heerey", "he43y", "yyhey"]
            $0.value = "hey"
                       $0.selectorTitle = "Choose an Emoji!"
                       }
                       .onPresent { from, to in
                       
                           to.selectableRowCellUpdate = { cell, row in
                               var detailText: String?
                               switch row.selectableValue {
                                   case "hey" : detailText = "Person"
                               case "he43y": detailText = "Animal"
                               case "yyhey": detailText = "Food"
                               default: detailText = ""
                               }
                               cell.detailTextLabel?.text = detailText
                           }
                       } .cellSetup({ cell, row in
                           cell.imageView?.image = UIImage(named: "dog")
                       })
        <<< PushRow<String>() {
                       $0.title = "Privacy Policy"
            $0.options = ["hey", "heerey", "he43y", "yyhey"]
            $0.value = "hey"
                       $0.selectorTitle = "Choose an Emoji!"
                       }
                       .onPresent { from, to in
                       
                           to.selectableRowCellUpdate = { cell, row in
                               var detailText: String?
                               switch row.selectableValue {
                                   case "hey" : detailText = "Person"
                               case "he43y": detailText = "Animal"
                               case "yyhey": detailText = "Food"
                               default: detailText = ""
                               }
                               cell.detailTextLabel?.text = detailText
                           }
                       } .cellSetup({ cell, row in
                           cell.imageView?.image = UIImage(named: "dog")
                       })
        <<< PushRow<String>() {
                       $0.title = "Terms of Use"
            $0.options = ["hey", "heerey", "he43y", "yyhey"]
            $0.value = "hey"
                       $0.selectorTitle = "Choose an Emoji!"
                       }
                       .onPresent { from, to in
                       
                           to.selectableRowCellUpdate = { cell, row in
                               var detailText: String?
                               switch row.selectableValue {
                                   case "hey" : detailText = "Person"
                               case "he43y": detailText = "Animal"
                               case "yyhey": detailText = "Food"
                               default: detailText = ""
                               }
                               cell.detailTextLabel?.text = detailText
                           }
                       } .cellSetup({ cell, row in
                           cell.imageView?.image = UIImage(named: "dog")
                       })
        <<< ViewRow<UIView>()
//            .cellSetup { [self] (cell, row) in
          
//                let submitAndPayButton = UIButton()
//                submitAndPayButton.setTitle("Submit for payment", for: .normal)
//                submitAndPayButton.setTitleColor(.white, for: .normal)
//                submitAndPayButton.backgroundColor = .systemTeal
//                submitAndPayButton.layer.cornerRadius = 25.0
//                submitAndPayButton.frame = CGRect(x: 100, y: 0, width: 200, height: 50)
//                cell.backgroundColor = .clear
//                submitAndPayButton.addTarget(self, action: #selector(pressed), for: .touchUpInside)
//                cell.addSubview(submitAndPayButton)
//            }
            .cellSetup({ [self] cell, row in
                cell.view = UIView(frame: CGRect(x: 20, y: 0, width: 800, height: 100))
                //                cell.view!.backgroundColor = UIColor.orange
                tableView.separatorStyle = .none
                let sliderDemo = UISlider()
                sliderDemo.minimumValue = 0
                sliderDemo.frame = CGRect(x: 0, y: 0, width: 350, height: 100)
                sliderDemo.maximumValue = 100
                sliderDemo.maximumValueImage = UIImage(systemName: "pencil")
                sliderDemo.minimumValueImage = UIImage(systemName: "pencil")
                sliderDemo.isContinuous = true
                sliderDemo.tintColor = .red
                sliderDemo.value = 50
                sliderDemo.addTarget(self, action: #selector(sliderValueDidChange), for: .valueChanged)
                cell.addSubview(sliderDemo)
            })
        
        <<< PushRow<String>() {
                       $0.title = "Share the app"
            $0.options = ["hey", "heerey", "he43y", "yyhey"]
            $0.value = "hey"
                       $0.selectorTitle = "Choose an Emoji!"
                       }
                       .onPresent { from, to in
                       
                           to.selectableRowCellUpdate = { cell, row in
                               var detailText: String?
                               switch row.selectableValue {
                                   case "hey" : detailText = "Person"
                               case "he43y": detailText = "Animal"
                               case "yyhey": detailText = "Food"
                               default: detailText = ""
                               }
                               cell.detailTextLabel?.text = detailText
                           }
                       } .cellSetup({ cell, row in
                           cell.imageView?.image = UIImage(named: "dog")
                       })
       
        
    }
        } //end of view controller

//MARK: - Currency Formatter Class
class CurrencyFormatter : NumberFormatter, FormatterProtocol {
    override func getObjectValue(_ obj: AutoreleasingUnsafeMutablePointer<AnyObject?>?, for string: String, range rangep: UnsafeMutablePointer<NSRange>?) throws {
        guard obj != nil else { return }
        var str = string.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
        if !string.isEmpty, numberStyle == .currency && !string.contains(currencySymbol) {
            // Check if the currency symbol is at the last index
            if let formattedNumber = self.string(from: 1), String(formattedNumber[formattedNumber.index(before: formattedNumber.endIndex)...]) == currencySymbol {
                // This means the user has deleted the currency symbol. We cut the last number and then add the symbol automatically
                str = String(str[..<str.index(before: str.endIndex)])
                
            }
        }
        obj?.pointee = NSNumber(value: (Double(str) ?? 0.0)/Double(pow(10.0, Double(minimumFractionDigits))))
    }
    
    func getNewPosition(forPosition position: UITextPosition, inTextInput textInput: UITextInput, oldValue: String?, newValue: String?) -> UITextPosition {
        return textInput.position(from: position, offset:((newValue?.count ?? 0) - (oldValue?.count ?? 0))) ?? position
    }
    
}

//MARK: - Twitter Cell Class
class TwitterCell: _FieldCell<String>, CellType {
    
    required public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open override func setup() {
        super.setup()
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.keyboardType = .twitter
    }
}
class ResultView: UIView {
    
    @IBOutlet weak var n200Label: UILabel!
    @IBOutlet weak var p300Label: UILabel!
    
}
