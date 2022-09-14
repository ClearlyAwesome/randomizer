//
//  Trying SwiftUI.swift
//  randomGenerator
//
//  Created by R C on 12/22/21.
//

import SwiftUI

struct Trying_SwiftUI: View {
    
    @State var receive = false
    @State var submit = false
    @State var email = ""
    @State var username: String = ""
    @State var isPrivate: Bool = true
    @State var notificationsEnabled: Bool = false
    @State private var previewIndex = 0
    @State private var counter = 0
    @State var burgerOptionTag: Int = 0
    @State var quantity: Int = 1
    @State var profileText = ""
    var burgerOption = ["Single Patty", "Double Patty"]
    var previewOptions = ["Always", "When Unlocked", "Never"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("About you")) {
                    Toggle(isOn: $receive) {
                        Text("Add to Catalog?")
                        
                    }
                    Stepper("The counter is \(counter)", value: $counter)
                    TextField("Your email", text: $email)
                    TextField("Your email", text: $email)
                    TextField("Your email", text: $email)
                    TextEditor(text: $profileText)
                            .foregroundColor(.black)
                    Image("dog")
                               .resizable()
                               .frame(width: 200, height: 200, alignment: .center)
                               .scaledToFit()
                }
                Section(header: Text("Order Information")) {
                    Text("Beef Burger")
                    HStack {
                        Picker("Options", selection: $burgerOptionTag) {
                            Text("Single Patty").tag(0)
                            Text("Double Patty").tag(1)
                        }
                        .pickerStyle(MenuPickerStyle())
                        Spacer()
                        Text(burgerOption[burgerOptionTag])
                    }
                    Stepper(value: $quantity, in: 1...1000) {
                        Text("Quantity: \(quantity)")
                    }
                }
                Button(action: {self.submit.toggle() }) {
                    Text("Submit")
            
                }
                
              
            }
            .navigationTitle("Create an Ad")
        }
    }
    
    struct Trying_SwiftUI_Previews: PreviewProvider {
        static var previews: some View {
            Trying_SwiftUI()
        }
    }
}
