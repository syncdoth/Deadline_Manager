import UIKit

class ColleaguesViewController: UIViewController {
    

    @IBOutlet weak var tableView2: UITableView!
    
    var col_dataSource : MessagesDataSource?
    
    let service = OutlookService.shared()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        col_tableView.estimatedRowHeight = 90;
        col_tableView2.rowHeight = UITableViewAutomaticDimension
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
