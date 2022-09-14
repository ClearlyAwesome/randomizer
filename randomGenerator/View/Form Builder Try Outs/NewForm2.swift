//
//  NewForm2.swift
//  randomGenerator
//
//  Created by R C on 12/24/21.
//

import UIKit
import Eureka
import MapKit
import PostalAddressRow
import SwiftUI


class NewForm2: FormViewController {
    
    let longitude = CLLocationManager().location?.coordinate.longitude
    let latitude = CLLocationManager().location?.coordinate.latitude
    let secondsPerDay = 24 * 60 * 60
    let options = ["Facebook", "Insta", "Yolo", "YouTube"]
    var navigationOptionsBackup : RowNavigationOptions?
    let continents = ["Africa", "Antarctica", "Asia", "Australia", "Europe", "North America", "South America"]
    @objc func multipleSelectorDone(_ item:UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
    }
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
        let alert = UIAlertController(title: "Welcome!", message: "Flip coin or press button", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createForm()
    }
    
    func createForm() {
        self.navigationItem.title = "Create an Ad in 3 Steps:"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(MyFormViewController.done(_:)))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(MyFormViewController.cancel(_:)))
        animateScroll = true
        // Leaves 20pt of space between the keyboard and the highlighted row after scrolling to an off screen row
        rowKeyboardSpacing = 15
        
        TextRow.defaultCellUpdate = { cell, row in
            //cell.textLabel?.font = UIFont.italicSystemFont(ofSize: 12)
        }
        
        form = Section()
        <<< SegmentedRow<String>("segments"){
            $0.options = ["About You","Details", "Audience"]
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
        <<< ButtonRow("Sync With My Profile"){ row in
            row.title =  row.tag
            row.cell.tintColor = .systemRed
        }
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
        <<< LocationRow("Ad Drop Location"){
            $0.title = $0.tag
            $0.value = CLLocation(latitude: -34.9124, longitude: -56.1594)
        }
        
        <<< SliderRow("Diameter from location") {
            $0.title = $0.tag
            $0.value = 30
        }
        <<< LabelRow("Actions Left & Right: iOS >= 11") {
            $0.title = $0.tag
            
            let moreAction = SwipeAction(style: .normal, title: "More") { (action, row, completionHandler) in
                print("More")
                completionHandler?(true)
            }
            
            let deleteAction = SwipeAction(style: .destructive, title: "Delete", handler: { (action, row, completionHandler) in
                print("Delete")
                completionHandler?(true)
            })
            
            $0.trailingSwipe.actions = [deleteAction,moreAction]
            $0.trailingSwipe.performsFirstActionWithFullSwipe = true
        }
        +++ Section(footer: "Billboard adds a map pin with an Icon \nMap Pin adds a dot the user can click on."){
            $0.tag = "Your ad"
            $0.hidden = "$segments != 'Details'" // .Predicate(NSPredicate(format: "$segments != 'Sport'"))
        }
        <<< SegmentedRow<String>("Campaign Type"){
//            $0.title = "Campaign Type"
            $0.options = ["Billboard", "Map Pin", "Both"]
            
        }.cellSetup { cell, row in
            cell.segmentedControl.backgroundColor = .systemTeal
            //                        cell.imageView?.image = UIImage(systemName: "pencil")
        } .cellUpdate({ cell, row in
            if self.traitCollection.userInterfaceStyle == .dark {
                cell.segmentedControl.selectedSegmentTintColor = .black
            } else {
                cell.segmentedControl.selectedSegmentTintColor = .white
                cell.segmentedControl.selectedSegmentTintColor = .white
            }
        })
        .onCellSelection({ cell, row in
            self.showAlert()
        })
//        <<< ButtonRow("Difference?"){
//            $0.title = $0.tag
//        } .onCellSelection({ cell, row in
//            self.showAlert()
//        })
        //MARK: - MultiValue Section
//        +++ MultivaluedSection(multivaluedOptions: [.Reorder, .Insert, .Delete],
//                               header: "Call to Action",
//                               footer: "4 Actions are Recommended."){  section in
//        list.enumerated().forEach({ offset, string in {
//                $0.addButtonProvider = { section in
//                    return ButtonRow(){
//                        $0.title = "Add New Action"
//                    }
//                }
//                $0.multivaluedRowToInsertAt = { index in
//                    return TextRow() {
//
//                        $0.title = $0.tag
//                    }
//                }
//                $0 <<< TextRow() {
//                    $0.title = "Yo"
//                    $0.placeholder = "Tag Name"
////                    $0.hidden = .function(["Heyzz"], { form -> Bool in
////                        let row: RowOf<Bool>! = form.rowBy(tag: "Heyzz")
////                        return row.value ?? false == false
////                    })
//                }
//        }

    +++ Section("Advertising Numbers"){
        $0.tag = "Duration"
        $0.hidden = "$segments != 'Details'" // .Predicate(NSPredicate(format: "$segments != 'Sport'"))
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
    <<< DecimalRow("Budget For Ad"){
        $0.useFormatterDuringInput = true
        $0.title = $0.tag
        $0.value = 2015
        let formatter = CurrencyFormatter()
        formatter.locale = .current
        formatter.numberStyle = .currency
        $0.formatter = formatter
    }
    <<< SwitchRow("Enter Blackout times"){
        $0.title = $0.tag
    }
    <<< TimeRow("Starting Time"){
        $0.title = $0.tag
        //            $0.title = "Starting Time"
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
    //        <<< StepperRow() {
    //            $0.title = $0.tag
    //            $0.title = "Call to Action Buttons"
    //            $0.value = 1
    //        }.cellSetup({ (cell, row) in
    //            cell.stepper.maximumValue = 4.0
    //        })
    +++ Section(){
        $0.tag = "Catalog"
        $0.hidden = "$segments != 'Details'" // .Predicate(NSPredicate(format: "$segments != 'Sport'"))
    }
    <<< SwitchRow("Add to Catalog?"){
        $0.title = $0.tag
    }
    
    <<< ButtonRow("What is This?"){
        $0.title = $0.tag
    } .onCellSelection({ cell, row in
        self.showAlert()
    })
    //        <<< AlertRow<String>("Alert Row") {
    //            $0.title = $0.tag
    //            $0.cancelTitle = "Dismiss"
    //            $0.selectorTitle = "Who is there?"
    //            $0.options = ["Female", "Male", "Other", "All"]
    //            $0.value = $0.options?.first
    //        }.onChange { row in
    //            print(row.value ?? "No Value")
    //        }
    //        .onPresent{ _, to in
    //            to.view.tintColor = .purple
    //        }
    
    <<< SwitchRow("Show Next Section"){
        $0.title = $0.tag
        $0.hidden = .function(["Add to Catalog?"], { form -> Bool in
            let row: RowOf<Bool>! = form.rowBy(tag: "Add to Catalog?")
            return row.value ?? false == false
        })
    }
    +++ Section(footer: "This section is shown only when 'Show Next Row' switch is enabled"){
        $0.hidden = .function(["Show Next Section"], { form -> Bool in
            let row: RowOf<Bool>! = form.rowBy(tag: "Show Next Section")
            return row.value ?? false == false
        })
    }
    <<< TextRow() {
        $0.placeholder = "Gonna dissapear soon!!"
    }
    
    //MARK: - Section 3 Customer
    +++ Section(){
        $0.tag = "Customer"
        $0.hidden = "$segments != 'Audience'"
        
    }
       
    +++ Section("Advertising Numbers"){
        $0.tag = "Customer2"
        $0.hidden = "$segments != 'Audience'"
    }
    
    <<< PushRow<String>(){
        $0.title = "Gender"
        //            $0.cell.imageView?.image = UIImage(systemName: "pencil")
        $0.options = ["Female", "Male", "Other", "All"]
        $0.value = ""
        $0.selectorTitle = "Choose Gender of Audience"
        
    } .onPresent { from, to in
        to.dismissOnSelection = true
        to.dismissOnChange = false
    }
    <<< PasswordRow("password") {
        $0.placeholder = "password"
    }
    
    <<< ButtonRow("Submit"){
        $0.title = "Submit"
        //            row.tag = "Submit"
    } .onCellSelection({ (cell, row) in
        
        //            var theVariable = self.form.values().keys
        //            print(theVariable)
        //            switch theVariable {
        //                case "Audience" :
        //                    print("hey")
        //                case "Audience1" :
        //                    print("hey")
        //                case "Audience2":
        //                    print("hey")
        //                case "Audience3" :
        //                    print("hey")
        //                case "Audience5" :
        //                    print("hey")
        //                case default :
        //                    print("hey")
        //            }
    })
    //        //MARK: - Section 4 May Delete this
    //        +++ Section(){
    //            $0.tag = "Submit"
    //            $0.hidden = "$segments != 'Ad Catalog'" // .Predicate(NSPredicate(format: "$segments != 'Sport'"))
    //        }
    //        <<< ButtonRow(){ row in
    //            row.title = "Submit"
    //        }
    //        <<< SwitchRow("Show Next Row"){
    //            $0.title = $0.tag
    //        }
    //        <<< SwitchRow("Show Next Section"){
    //            $0.title = $0.tag
    //            $0.hidden = .function(["Show Next Row"], { form -> Bool in
    //                let row: RowOf<Bool>! = form.rowBy(tag: "Show Next Row")
    //                return row.value ?? false == false
    //            })
    //        }
    //
    //        +++ Section(footer: "This section is shown only when 'Show Next Row' switch is enabled"){
    //            $0.hidden = .function(["Show Next Section"], { form -> Bool in
    //                let row: RowOf<Bool>! = form.rowBy(tag: "Show Next Section")
    //                return row.value ?? false == false
    //            })
    //        }
    //        <<< TextRow() {
    //            $0.placeholder = "Gonna dissapear soon!!"
    //        }
    //        form += MultivaluedSection(multivaluedOptions: [.Reorder, .Insert, .Delete],
    //                                   header: "Multivalued TextField",
    //                                   footer: "Insert adds a 'Add Item' (Add New Tag) button row as last cell.") {
    //            $0.addButtonProvider = { section in
    //                return ButtonRow(){
    //                    $0.tag = "multi"
    //
    //                    $0.title = "Add New Tag"
    //                }
    //
    //            }
    //            $0.multivaluedRowToInsertAt = { index in
    //                return NameRow() {
    //                    $0.placeholder = "Tag Name"
    //                }
    //            }
    //            $0 <<< NameRow() {
    //                $0.placeholder = "Tag Name"
    //            }
    //        }
    //        +++ Section()
    
    
    
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
    //MARK: - Eureka Logo View
    class EurekaLogoViewNib: UIView {
        
        @IBOutlet weak var imageView: UIImageView!
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
    }
}
    func displayForm() {
        form +++ TextRow()
     <<< AlertRow<String>() {
            $0.title = "User Clicks"
            $0.cancelTitle = "Dismiss"
            $0.selectorTitle = "Who is there?"
            $0.options = ["Go To Website", "Download my app", "Buy my product", "Call me" ]
            $0.value = $0.options?.first
        }.onChange { row in
            print(row.value ?? "No Value")
        }
        .onPresent{ _, to in
            to.view.tintColor = .purple
            
        }
    }
}//end of view controller

//MARK: - Dead Code

//        form +++ Section("Tell Us About Your Ad")
//
//        <<< TextRow(){ row in
//            row.title = "Campaign Name"
//            row.placeholder = "Enter text here"
//        }
//        <<< TextRow(){ row in
//            row.title = "Message to Audience"
//            row.placeholder = "Enter text here"
//        }
//        <<< TextRow(){ row in
//            row.title = "Ad Cover Image URL"
//            row.placeholder = "Enter text here"
//        }
//        <<< TextRow(){ row in
//            row.title = "Campaign Name"
//            row.placeholder = "Enter text here"
//        }
//        <<< PhoneRow(){
//            $0.title = "Phone Row"
//            $0.placeholder = "And numbers here"
//        }
//        +++ Section("The Ad Numbers")
//        <<< DateRow(){
//            $0.title = "Start Date"
//            $0.value = Date()
//            let formatter = DateFormatter()
//            formatter.locale = .current
//            formatter.dateStyle = .long
//            $0.dateFormatter = formatter
//        }
//        <<< DateRow(){
//            $0.title = "End Date"
//            $0.value = Date()
//            let formatter = DateFormatter()
//            formatter.locale = .current
//            formatter.dateStyle = .long
//            $0.dateFormatter = formatter
//        }
//        <<< DecimalRow(){
//            $0.useFormatterDuringInput = true
//            $0.title = "Budget For Ad"
//            $0.value = 2015
//            let formatter = CurrencyFormatter()
//            formatter.locale = .current
//            formatter.numberStyle = .currency
//            $0.formatter = formatter
//        }
//
//        form +++ SelectableSection<ListCheckRow<String>>("Where do you live", selectionType: .singleSelection(enableDeselection: true))
//
//        let continents = ["Africa", "Antarctica", "Asia", "Australia", "Europe", "North America", "South America"]
//        for option in continents {
//            form.last! <<< ListCheckRow<String>(option){ listRow in
//                listRow.title = option
//                listRow.selectableValue = option
//                listRow.value = nil
//            }
//        }
//        form +++ Section()
//        <<< SwitchRow("switchRowTag"){
//            $0.title = "Show message"
//        }
//        <<< LabelRow(){
//            //            $0.hidden = Condition.predicate(NSPredicate(format: "$switchTag == false"))
//            $0.hidden = Condition.function(["switchRowTag"], { form in
//                return !((form.rowBy(tag: "switchRowTag") as? SwitchRow)?.value ?? false)
//            })
//            $0.title = "Switch is on!"
//        }


//        form +++
//        MultivaluedSection(multivaluedOptions: [.Reorder, .Insert, .Delete],
//                           header: "Multivalued TextField",
//                           footer: "Insert adds a 'Add Item' (Add New Tag) button row as last cell.") {
//            $0.addButtonProvider = { section in
//                return ButtonRow(){
//                    $0.title = "Add New Tag"
//                }
//            }
//            $0.multivaluedRowToInsertAt = { index in
//                return NameRow() {
//                    $0.placeholder = "Tag Name"
//                }
//            }
//            $0 <<< NameRow() {
//                $0.placeholder = "Tag Name"
//            }
//        }

//form
//        +++ Section(header: "Required Rule", footer: "Options: Validates on change")
//
//        <<< TextRow() {
//            $0.title = "Required Rule"
//            $0.add(rule: RuleRequired())
//
//            // This could also have been achieved using a closure that returns nil if valid, or a ValidationError otherwise.
//            /*
//             let ruleRequiredViaClosure = RuleClosure<String> { rowValue in
//             return (rowValue == nil || rowValue!.isEmpty) ? ValidationError(msg: "Field required!") : nil
//             }
//             $0.add(rule: ruleRequiredViaClosure)
//             */
//
//            $0.validationOptions = .validatesOnChange
//        }
//        .cellUpdate { cell, row in
//            if !row.isValid {
//                cell.titleLabel?.textColor = .systemRed
//            }
//        }
//
//        +++ Section(header: "Email Rule, Required Rule", footer: "Options: Validates on change after blurred")
//
//        <<< TextRow() {
//            $0.title = "Email Rule"
//            $0.add(rule: RuleRequired())
//            $0.add(rule: RuleEmail())
//            $0.validationOptions = .validatesOnChangeAfterBlurred
//        }
//        .cellUpdate { cell, row in
//            if !row.isValid {
//                cell.titleLabel?.textColor = .systemRed
//            }
//        }
//        +++ Section(header: "Email Rule, Required Rule", footer: "Options: Validates on change after blurred")
//        <<< TextRow() { row in
//            GenericMultivaluedSection<LabelRow>(multivaluedOptions: [.Reorder, .Insert, .Delete], {
//                $0.addButtonProvider = { section in
//                    return LabelRow(){
//                        $0.title = "A Label row as add button"
//                    }
//                }
//                // ...
//            })
//        }
//        <<< SegmentedRow<String>("segments"){
//            $0.options = ["Enabled", "Disabled"]
//            $0.value = "Disabled"
//        }
//
//        <<< TextRow(){
//            $0.title = "choose enabled, disable above..."
//            $0.disabled = "$segments = 'Disabled'"
//        }
//
//        <<< SwitchRow("Disable Next Section?"){
//            $0.title = $0.tag
//            $0.disabled = "$segments = 'Disabled'"
//        }

//form +++ Section("Ad Message Here")
// <<< TextAreaRow() {
//     $0.placeholder = "TextAreaRow"
//     $0.textAreaHeight = .dynamic(initialTextViewHeight: 110)
// }
// <<< TextAreaRow() {
//     $0.value = "You also have scrollable read only textAreaRows! I have to write a big text so you will be able to scroll a lot and see that this row is scrollable. I think it is a good idea to insert a Lorem Ipsum here: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla ac odio consectetur, faucibus elit at, congue dolor. Duis quis magna eu ante egestas laoreet. Vivamus ultricies tristique porttitor. Proin viverra sem non turpis molestie, volutpat facilisis justo rutrum. Nulla eget commodo ligula. Aliquam lobortis lobortis justo id fermentum. Sed sit amet elit eu ipsum ultricies porttitor et sed justo. Fusce id mi aliquam, iaculis odio ac, tempus sem. Aenean in eros imperdiet, euismod lacus vitae, mattis nulla. Praesent ornare sem vitae ornare efficitur. Nullam dictum tortor a tortor vestibulum pharetra. Donec sollicitudin varius fringilla. Praesent posuere fringilla tristique. Aliquam dapibus vel nisi in sollicitudin. In eu ligula arcu."
//     $0.textAreaMode = .normal
//     $0.textAreaHeight = .dynamic(initialTextViewHeight: 50)
//     //            fixed(cellHeight: 110)
// }

//form     +++ Section()
//
//                <<< TextRow() {
//                    $0.title = "Gonna be disabled soon.."
//                    $0.disabled = Eureka.Condition.function(["Disable Next Section?"], { (form) -> Bool in
//                        let row: SwitchRow! = form.rowBy(tag: "Disable Next Section?")
//                        return row.value ?? false
//                    })
//                }
//
//                +++ Section()
//
//                <<< SegmentedRow<String>(){
//                    $0.options = ["Always Disabled"]
//                    $0.disabled = true
//                }
//                +++ Section(header: "Default field rows", footer: "Rows with title have a right-aligned text field.\nRows without title have a left-aligned text field.\nBut this can be changed...")
//
//                <<< NameRow() {
//                    $0.title = "Your name:"
//                    $0.placeholder = "(right alignment)"
//                }
//                .cellSetup { cell, row in
//                    cell.imageView?.image = UIImage(named: "plus_image")
//                }
//
//                <<< NameRow() {
//                    $0.placeholder = "Name (left alignment)"
//                }
//                .cellSetup { cell, row in
//                    cell.imageView?.image = UIImage(named: "plus_image")
//                }
//
//                +++ Section("Customized Alignment")
//
//                <<< NameRow() {
//                    $0.title = "Your name:"
//                }.cellUpdate { cell, row in
//                    cell.textField.textAlignment = .left
//                    cell.textField.placeholder = "(left alignment)"
//                }
//
//                <<< NameRow().cellUpdate { cell, row in
//                    cell.textField.textAlignment = .right
//                    cell.textField.placeholder = "Name (right alignment)"
//                }
//
//                +++ Section(header: "Customized Text field width", footer: "Eureka allows us to set up a specific UITextField width using textFieldPercentage property. In the section above we have also right aligned the textLabels.")
//
//                <<< NameRow() {
//                    $0.title = "Title"
//                    $0.titlePercentage = 0.4
//                    $0.placeholder = "textFieldPercentage = 0.6"
//                }
//                .cellUpdate {
//                    $1.cell.textField.textAlignment = .left
//                    $1.cell.textLabel?.textAlignment = .right
//                }
//                <<< NameRow() {
//                    $0.title = "Another Title"
//                    $0.titlePercentage = 0.4
//                    $0.placeholder = "textFieldPercentage = 0.6"
//                }
//                .cellUpdate {
//                    $1.cell.textField.textAlignment = .left
//                    $1.cell.textLabel?.textAlignment = .right
//                }
//                <<< NameRow() {
//                    $0.title = "One more"
//                    $0.titlePercentage = 0.3
//                    $0.placeholder = "textFieldPercentage = 0.7"
//                }
//                .cellUpdate {
//                    $1.cell.textField.textAlignment = .left
//                    $1.cell.textLabel?.textAlignment = .right
//                }



//        <<< DecimalRow(){
//            $0.title = "Scientific style"
//            $0.value = 2015
//            let formatter = NumberFormatter()
//            formatter.locale = .current
//            formatter.numberStyle = .scientific
//            $0.formatter = formatter
//        }
//        <<< IntRow(){
//            $0.title = "Spell out style"
//            $0.value = 2015
//            let formatter = NumberFormatter()
//            formatter.locale = .current
//            formatter.numberStyle = .spellOut
//            $0.formatter = formatter
//        }
//        +++ Section("Date formatters")
//        <<< DateRow(){
//            $0.title = "Short style"
//            $0.value = Date()
//            let formatter = DateFormatter()
//            formatter.locale = .current
//            formatter.dateStyle = .short
//            $0.dateFormatter = formatter
//        }

//        +++ Section("Other formatters")
//        <<< DecimalRow(){
//            $0.title = "Energy: Jules to calories"
//            $0.value = 100.0
//            let formatter = EnergyFormatter()
//            $0.formatter = formatter
//        }
//        <<< IntRow(){
//            $0.title = "Weight: Kg to lb"
//            $0.value = 1000
//            $0.formatter = MassFormatter()
//        }
//navigationOptions = RowNavigationOptions.Enabled.union(.SkipCanNotBecomeFirstResponderRow)
//                navigationOptionsBackup = navigationOptions
//
//                form = Section(header: "Settings", footer: "These settings change how the navigation accessory view behaves")
//
//                <<< SwitchRow("set_none") { [weak self] in
//                    $0.title = "Navigation accessory view"
//                    $0.value = self?.navigationOptions != .Disabled
//                }.onChange { [weak self] in
//                    if $0.value ?? false {
//                        self?.navigationOptions = self?.navigationOptionsBackup
//                        self?.form.rowBy(tag: "set_disabled")?.baseValue = self?.navigationOptions?.contains(.StopDisabledRow)
//                        self?.form.rowBy(tag: "set_skip")?.baseValue = self?.navigationOptions?.contains(.SkipCanNotBecomeFirstResponderRow)
//                        self?.form.rowBy(tag: "set_disabled")?.updateCell()
//                        self?.form.rowBy(tag: "set_skip")?.updateCell()
//                    }
//                    else {
//                        self?.navigationOptionsBackup = self?.navigationOptions
//                        self?.navigationOptions = .Disabled
//                    }
//                }
//
//                <<< CheckRow("set_disabled") { [weak self] in
//                    $0.title = "Stop at disabled row"
//                    $0.value = self?.navigationOptions?.contains(.StopDisabledRow)
//                    $0.hidden = "$set_none == false" // .Predicate(NSPredicate(format: "$set_none == false"))
//                }.onChange { [weak self] row in
//                    if row.value ?? false {
//                        self?.navigationOptions = self?.navigationOptions?.union(.StopDisabledRow)
//                    }
//                    else{
//                        self?.navigationOptions = self?.navigationOptions?.subtracting(.StopDisabledRow)
//                    }
//                }
//
//                <<< CheckRow("set_skip") { [weak self] in
//                    $0.title = "Skip non first responder view"
//                    $0.value = self?.navigationOptions?.contains(.SkipCanNotBecomeFirstResponderRow)
//                    $0.hidden = "$set_none  == false"
//                }.onChange { [weak self] row in
//                    if row.value ?? false {
//                        self?.navigationOptions = self?.navigationOptions?.union(.SkipCanNotBecomeFirstResponderRow)
//                    }
//                    else{
//                        self?.navigationOptions = self?.navigationOptions?.subtracting(.SkipCanNotBecomeFirstResponderRow)
//                    }
//                }
//
//        +++
//
//        NameRow() { $0.title = "Your name:" }
//
//        <<< PasswordRow() { $0.title = "Your password:" }
//
//        +++ Section()
//
//        <<< PhoneRow() { $0.title = "Your phone number" }
//
//        <<< URLRow() {
//            $0.title = "www.google.com"
//            $0.disabled = false
//        }
//
//        <<< TextRow() { $0.title = "Your father's name"}
//
//        <<< TextRow(){ $0.title = "Your mother's name"}
//    }
//Section()
//
//        <<< TextRow() {
//            $0.title = "Name"
//            $0.value = "John Doe"
//        }
//
//        <<< TextRow() {
//            $0.title = "Username"
//            $0.value = "johndoe1"
//        }
//
//        <<< EmailRow() {
//            $0.title = "Email Address"
//            $0.value = "john@doe.com"
//        }
//
//        <<< PasswordRow() {
//            $0.title = "Password"
//            $0.value = "johndoe9876"
//        }

// Remove excess separator lines on non-existent cells
//        tableView.tableFooterView = UIView()
//        <<< TextRow() {
//            $0.title = "Email Rule"
//            $0.add(rule: RuleRequired())
//            $0.add(rule: RuleEmail())
//            $0.validationOptions = .validatesOnChangeAfterBlurred
//        }
//        .cellUpdate { cell, row in
//            if !row.isValid {
//                cell.titleLabel?.textColor = .systemRed
//            }
//        }
//        <<< TextRow(){ row in
//            row.title = "Campaign Name"
//            row.placeholder = "Enter text here"
//        }
//        <<< TextRow("Message to Audience"){ row in
//            row.title = "Message to Audience"
//            row.placeholder = "Enter text here"
//        }
//        <<< TextRow(){ row in
//            row.title = "Ad Cover Image URL"
//            row.placeholder = "Enter text here"
//        }
//        <<< PickerInputRow<String>("Gender22"){
//            $0.title = "Gender #22"
//            $0.options = ["Female", "Male", "Other", "All"]
//            $0.value = $0.options.first
//        }
//        <<< TextRow(){ row in
//            row.title = "Campaign Name"
//            row.placeholder = "Enter text here"
//        }
//        <<< TextRow(){ row in
//            row.title = "Last Row"
//            row.placeholder = "Enter text here"
//        }
//        <<< PickerInputRow<String>("Picker Input Row"){
//            $0.title = "Options"
//            $0.options = []
//            for i in 1...10{
//                $0.options.append("option \(i)")
//            }
//            $0.value = $0.options.first
//        }
//
//        <<< DoublePickerInlineRow<String, Int>() {
//            $0.title = "2 Component picker"
//            $0.firstOptions = { return ["a", "b", "c"]}
//            $0.secondOptions = { _ in return [1, 2, 3]}
//        }
//        <<< TriplePickerInputRow<String, String, Int>() {
//            $0.firstOptions = { return ["iPhone6", "iPhone7","iPhone10", "iPhone4", "iPhone11","iPhone12"]}
//            $0.secondOptions = { return [$0, $0 + $0, $0 + "-" + $0, "asd"]}
//            $0.thirdOptions = { _,_ in return [1, 2, 3]}
//            $0.title = "3 Component picker"
//        }
//        +++ Section(){
//            $0.tag = "Submit"
//            $0.hidden = "$segments != 'Audience'"
//        }
//    <<< NameRow() {
//        $0.title = "Title"
//        $0.cell.textField.textAlignment = .center
//        $0.titlePercentage = 0.1
//        $0.placeholder = "textFieldPercentage = 0.6"
//        }
//        .cellUpdate {
//            $1.cell.textField.textAlignment = .center
//            $1.cell.textLabel?.textAlignment = .center
//    }
