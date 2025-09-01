// ExampleViewController.swift
// SwiftExample Copyright© 2017-2025; Electric Bolt Limited.
 
import UIKit
import AppfigurateLibrary

class ExampleViewController: UITableViewController {

    override func viewDidLoad() {
        self.navigationItem.title = "Swift Example " + APLVersion();
        APLAddConfigurationUpdatedListener(self)

        let label = APLConfigurationLabel(frame: .zero)
        label.center = CGPoint(x: 7, y: self.navigationController!.view.bounds.size.height / 2)
        self.navigationController!.view.addSubview(label)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        switch indexPath.section {
            case 0: cell.detailTextLabel?.text = CONFIGURATION().boolean ? "true":"false"
            case 1:
                switch indexPath.row {
                    case 0: cell.detailTextLabel?.text = CONFIGURATION().string_Textfield
                    case 1: cell.detailTextLabel?.text = CONFIGURATION().string_RegexTextfield
                    case 2: cell.detailTextLabel?.text = CONFIGURATION().string_List
                    case 3: cell.detailTextLabel?.text = CONFIGURATION().string_Textfield_List
                    case 4: cell.detailTextLabel?.text = CONFIGURATION().string_RegexTextfield_List
                    case 5: cell.detailTextLabel?.text = CONFIGURATION().encrypted_string_Textfield_List
                    default: cell.detailTextLabel?.text = CONFIGURATION().encrypted_string_RegexTextfield_List
                }
            case 2:
                switch indexPath.row {
                    case 0: cell.detailTextLabel?.text = "\(CONFIGURATION().integer_Slider)"
                    case 1: cell.detailTextLabel?.text = "\(CONFIGURATION().integer_Textfield)"
                    case 2: cell.detailTextLabel?.text = "\(CONFIGURATION().integer_RegexTextfield)"
                    case 3: cell.detailTextLabel?.text = "\(CONFIGURATION().integer_List)"
                    case 4: cell.detailTextLabel?.text = "\(CONFIGURATION().integer_Textfield_List)"
                    default: cell.detailTextLabel?.text = "\(CONFIGURATION().integer_RegexTextfield_List)"
                }
            case 3:
                switch indexPath.row {
                    case 0: cell.detailTextLabel?.text = "\(CONFIGURATION().float_Slider)"
                    case 1: cell.detailTextLabel?.text = "\(CONFIGURATION().float_Textfield)"
                    case 2: cell.detailTextLabel?.text = "\(CONFIGURATION().float_RegexTextfield)"
                    case 3: cell.detailTextLabel?.text = "\(CONFIGURATION().float_List)"
                    case 4: cell.detailTextLabel?.text = "\(CONFIGURATION().float_Textfield_List)"
                    default: cell.detailTextLabel?.text = "\(CONFIGURATION().float_RegexTextfield_List)"
                }
            case 4:
                switch indexPath.row {
                    case 0: cell.detailTextLabel?.text = "\(CONFIGURATION().double_Slider)"
                    case 1: cell.detailTextLabel?.text = "\(CONFIGURATION().double_Textfield)"
                    case 2: cell.detailTextLabel?.text = "\(CONFIGURATION().double_RegexTextfield)"
                    case 3: cell.detailTextLabel?.text = "\(CONFIGURATION().double_List)"
                    case 4: cell.detailTextLabel?.text = "\(CONFIGURATION().double_Textfield_List)"
                    default: cell.detailTextLabel?.text = "\(CONFIGURATION().double_RegexTextfield_List)"
                }
            default:
                switch indexPath.row {
                    case 0: cell.detailTextLabel?.text = "\(CONFIGURATION().alwaysDarkMode ? "true" : "false")"
                    case 1: cell.detailTextLabel?.text = "\(CONFIGURATION().appTitle)"
                    case 2: cell.detailTextLabel?.text = "\(CONFIGURATION().fontSize)"
                    default: cell.detailTextLabel?.text = "\(CONFIGURATION().bookingDuration)"
            }
        }
        return cell
    }
    
}

extension ExampleViewController: APLConfigurationUpdated {

    func configurationUpdated(_ notification: Notification?) {
        self.tableView.reloadData()
    }

}

