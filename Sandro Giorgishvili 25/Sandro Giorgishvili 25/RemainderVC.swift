//
//  RemainderVC.swift
//  Sandro Giorgishvili 25
//
//  Created by TBC on 24.08.22.
//

import UIKit

class RemainderVC: UIViewController, AlertCellDelegate {
    func editAlert(cell: AlertCell) {
        if let indexPath = alertsTableView.indexPath(for: cell) {
            promtUserForEditingAlert(index: indexPath.row)
        }
    }
    
    func deleteDirectoryFile(cell: AlertCell) {
        if let indexPath = alertsTableView.indexPath(for: cell) {
            deleteDirectoryFile(directoryName: directory, directoryFileName: ViewController.alerts[indexPath.row])
            ViewController.alerts.remove(at: indexPath.row)
            ViewController.alertDate.remove(at: indexPath.row)
            alertsTableView.reloadData()
        }
    }
    
    var ac = UIAlertController()
    
    var currentAlertName: String!
    var currentAlertTime: String!
    
    var directory: String!
    
    @IBOutlet weak var alertsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
    }
    
    func setUpTableView() {
        alertsTableView.delegate = self
        alertsTableView.dataSource = self
    }
    
    func setTitle(title: String) {
        self.title = title + " remainders"
        directory = title
    }
    
    @IBAction func addTapped(_ sender: Any) {
        promptUserForCreatingCategory()
    }
    
    func promptUserForCreatingCategory() {
        ac = UIAlertController(title: "Enter new directory name", message: nil, preferredStyle: .alert)
        
        ac.addTextField()
        ac.addTextField()
        
        ac.textFields![0].placeholder = "Remainder name"
        ac.textFields![1].placeholder = "Remainder date"
        
        setUpDatePicker()
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) {
            UIAlertAction in
            NSLog("Cancel Pressed")
        }
        
        // set cancel button color to red
        cancelAction.setValue(UIColor.red, forKey: "titleTextColor")
        
        // add submit action
        let submitAction = UIAlertAction(title: "Create", style: .default) { [self, unowned ac] _ in
            
            guard let alertName = ac.textFields?[0].text else { return }
            guard let alertTime = ac.textFields?[1].text else { return }
            
            currentAlertName = alertName
            currentAlertTime = alertTime
            
            // check if textfield is not empty then add it
            if !alertName.isEmpty && !alertTime.isEmpty {
                
                // chekc if new directory name is unique
                if ViewController.alerts.contains(alertName) {
                    showAlertWithOkButton(title: nil, message: "There already exists alert with that name")
                } else {
                    
                    ViewController.alerts.append(alertName)
                    ViewController.alertDate.append(alertTime)
                    
                    createFileForDirectory(directoryName: directory, FileName: alertName + ".txt",alertTime: alertTime)
                    
                    alertsTableView.reloadData()
                }
            } else {
                showAlertWithOkButton(title: nil, message: "Can not create alert with empty date or name")
            }
        }
        
        ac.addAction(submitAction)
        ac.addAction(cancelAction)
        
        present(ac, animated: true)
    }
    
    func promtUserForEditingAlert(index: Int) {
        ac = UIAlertController(title: "Edit alert", message: nil, preferredStyle: .alert)
        
        ac.addTextField()
        ac.addTextField()
        
        ac.textFields![0].placeholder = currentAlertName
        ac.textFields![1].placeholder = currentAlertTime
        
        setUpDatePicker()
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) {
            UIAlertAction in
            NSLog("Cancel Pressed")
        }
        
        // set cancel button color to red
        cancelAction.setValue(UIColor.red, forKey: "titleTextColor")
        
        // add submit action
        let submitAction = UIAlertAction(title: "Save", style: .default) { [self, unowned ac] _ in
            
            guard let alertName = ac.textFields?[0].text else { return }
            guard let alertTime = ac.textFields?[1].text else { return }
            
            // check if textfield is not empty then add it
            if !alertName.isEmpty && !alertTime.isEmpty {
                
                // chekc if new directory name is unique
                if ViewController.alerts.contains(alertName) {
                    showAlertWithOkButton(title: nil, message: "There already exists alert with that name")
                } else {
                    
                    ViewController.alerts.remove(at: index)
                    ViewController.alertDate.remove(at: index)
                    ViewController.alerts.append(alertName)
                    ViewController.alertDate.append(alertTime)
                    
                    deleteDirectoryFile(directoryName: directory, directoryFileName: currentAlertName)
                    createFileForDirectory(directoryName: directory, FileName: alertName + ".txt",alertTime: alertTime)
                    
                    alertsTableView.reloadData()
                }
            } else {
                showAlertWithOkButton(title: nil, message: "Can not edit alert with empty date or name")
            }
        }
        
        ac.addAction(submitAction)
        ac.addAction(cancelAction)
        
        present(ac, animated: true)
    }

func setUpDatePicker() {
    let datePicker = UIDatePicker()
    datePicker.datePickerMode = .dateAndTime
    datePicker.addTarget(self, action: #selector(dateChange(datePicker:)), for: UIControl.Event.valueChanged)
    datePicker.frame.size = CGSize(width: 0, height: 300)
    datePicker.preferredDatePickerStyle = .wheels
    datePicker.minimumDate = Date()
    ac.textFields![1].inputView = datePicker
    
    ac.textFields![1].text = formatDate(date: Date())
}

@objc func dateChange(datePicker: UIDatePicker)
{
    ac.textFields![1].text = formatDate(date: datePicker.date)
}

func formatDate(date: Date) -> String
{
    let formatter = DateFormatter()
    formatter.dateFormat = "MMMM dd HH:mm"
    return formatter.string(from: date)
}
}


extension RemainderVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ViewController.alerts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlertCell", for: indexPath) as! AlertCell
        cell.delegate = self
        
        cell.setCellWithValuesOf(alertName: ViewController.alerts[indexPath.row], alertDate: ViewController.alertDate[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
}
