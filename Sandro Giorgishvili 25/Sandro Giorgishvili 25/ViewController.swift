//
//  ViewController.swift
//  Sandro Giorgishvili 25
//
//  Created by TBC on 24.08.22.
//

import UIKit

class ViewController: UIViewController, CategoryCellDelegate {
    
    func deleteDirectory(cell: CategoryCell) {
        
        if let indexPath = directoryTableView.indexPath(for: cell) {
            deleteDirectory(directoryName: categories[indexPath.row])
            categories.remove(at: indexPath.row)
            directoryTableView.reloadData()
        }
    }
    
    @IBOutlet weak var directoryTableView: UITableView!
    
    var categories = [String]()
    static var alerts = [String]()
    static var alertDate = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
    }
    
    func setUpTableView() {
        directoryTableView.delegate = self
        directoryTableView.dataSource = self
    }
    
    @IBAction func addTapped(_ sender: Any) {
        promptUserForCreatingCategory()
    }
    
    func promptUserForCreatingCategory() {
        let ac = UIAlertController(title: "Enter new directory name", message: nil, preferredStyle: .alert)
        
        ac.addTextField()
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) {
            UIAlertAction in
            NSLog("Cancel Pressed")
        }
        
        // set cancel button color to red
        cancelAction.setValue(UIColor.red, forKey: "titleTextColor")
        
        // add submit action
        let submitAction = UIAlertAction(title: "Create", style: .default) { [self, unowned ac] _ in
            
            guard let categoryName = ac.textFields?[0].text else { return }
            
            // check if textfield is not empty then add it
            if !categoryName.isEmpty {
                
                // chekc if new directory name is unique
                if categories.contains(categoryName) {
                    showAlertWithOkButton(title: nil, message: "There already exists directory with that name")
                } else {
                    
                    categories.append(categoryName)
                    // creating directory with category name
                    createDirectoryWithName(directoryName: categoryName)
                    
                    directoryTableView.reloadData()
                }
            } else {
                showAlertWithOkButton(title: nil, message: "Can not create directory with an empty name")
            }
        }
        
        ac.addAction(submitAction)
        ac.addAction(cancelAction)
        
        present(ac, animated: true)
    }
    
    func pushToRemainderViewController(title: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let remainderVC = storyboard.instantiateViewController(withIdentifier: "RemainderVC") as! RemainderVC
        remainderVC.setTitle(title: title)
        self.navigationController?.pushViewController(remainderVC, animated: true)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        cell.delegate = self
        
        cell.setCellWithValuesOf(categoryName: categories[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pushToRemainderViewController(title: categories[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        45
    }
}

extension UIViewController {
    // function to show alert
    func showAlertWithOkButton(title: String?, message: String) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let titleAttrString = NSMutableAttributedString(string: message, attributes: [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17)
        ])
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alertController.setValue(titleAttrString, forKey:"attributedTitle")
        let action = UIAlertAction(title: "OK", style: .cancel)
        alertController.addAction(action)
        alertController.view.backgroundColor = UIColor.clear
        self.present(alertController, animated: true)
    }
    
    func createDirectoryWithName(directoryName: String) {
        let manager = FileManager.default
        
        guard let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        print(url)
        
        let newFolderUrl = url.appendingPathComponent(directoryName)
        
        do {
            try manager.createDirectory(
                at: newFolderUrl,
                withIntermediateDirectories: true,
                attributes: nil)
        } catch {
            print(error)
        }
    }
    
    func createFileForDirectory(directoryName: String, FileName: String, alertTime: String) {
        let manager = FileManager.default
        
        guard let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        let existingFolderUrl = url.appendingPathComponent(directoryName)
        let data = alertTime.data(using: .utf8)
                
        do {
            let fileUrl = existingFolderUrl.appendingPathComponent(FileName)
            manager.createFile(
                atPath: fileUrl.path,
                contents: data,
                attributes: nil)
        }
    }
    
    func deleteDirectory(directoryName: String) {
        
        let manager = FileManager.default
        
        guard let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        let folderUrl = url.appendingPathComponent(directoryName).path
        
        do {
            try manager.removeItem(atPath: folderUrl)
        } catch {
            print(error)
        }
    }
    
    func deleteDirectoryFile(directoryName: String, directoryFileName: String) {
        
        let manager = FileManager.default
        
        guard let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        let existingFolderUrl = url.appendingPathComponent(directoryName)
        let fileUrl = existingFolderUrl.appendingPathComponent(directoryFileName + ".txt").path
        
        do {
            try manager.removeItem(atPath: fileUrl)
        } catch {
            print(error)
        }
    }
}

