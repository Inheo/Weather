//
//  AlertWithTextField.swift
//  Weather
//
//  Created by Даниял on 27.10.2022.
//

import SwiftUI

struct AlertFindPlace: UIViewControllerRepresentable {
    @Binding var text: String
    @Binding var isPresented: Bool
    
    var title: String?
    var message: String?
    var preferredStyle: UIAlertController.Style = .alert
    var placeholder: String?
    var replaceSpaces = true
    
    var completion: (String) -> Void = { _ in }
    var cancel: () -> Void = { }

    func makeUIViewController(context: Context) -> UIViewController {
      return UIViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        context.coordinator.alert = alert
        
        alert.addTextField { textField in
            textField.placeholder = "Enter some text"
            textField.text = self.text
            textField.delegate = context.coordinator
            
        }
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel) { _ in
            self.text = ""
            self.isPresented = false
            cancel()
        })
        
        alert.addAction(UIAlertAction(title: "Add",
                                      style: .default) { _ in
            if let textField = alert.textFields?.first, var text = textField.text {
                text = replaceSpaces ? text.split(separator: " ").joined(separator: "%20") : text
                self.text = text
                completion(text)
                self.isPresented = false
                self.text = ""
            }
        })
        
        DispatchQueue.main.async {
            uiViewController.present(alert, animated: true, completion: {
                self.isPresented = false
            })
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

extension AlertFindPlace {
    class Coordinator: NSObject, UITextFieldDelegate {
        var alert: UIAlertController?
        var control: AlertFindPlace
        
        init(_ control: AlertFindPlace) {
            self.control = control
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            control.text = textField.text ?? ""
        }
    }
}

struct AlertWithTextField_Previews: PreviewProvider {
    static var previews: some View {
        AlertFindPlace(text: .constant("Moscow"),
                           isPresented: .constant(true),
                           title: "Search the city")
    }
}
