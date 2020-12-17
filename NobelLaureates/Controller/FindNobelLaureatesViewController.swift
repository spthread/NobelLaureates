import UIKit

protocol ReceiveLocationDetails {
    func latestLocation(lat: Double, long: Double)
}

protocol ReceiveSelectedYear {
    func selected(year: String)
}

class FindNobelLaureatesViewController: UIViewController {

    @IBOutlet weak var yearField: UIButton!
    @IBOutlet weak var locationField: UIButton!
    @IBOutlet weak var findLaureatesButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    let transitionDelegate: UIViewControllerTransitioningDelegate? = TransitionController()
    var viewModel: FindNobelLaureatesViewModelInput
    var models: [LaureateViewModel] = []
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        viewModel = FindNobelLaureatesViewModel() as FindNobelLaureatesViewModelInput
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        viewModel = FindNobelLaureatesViewModel() as FindNobelLaureatesViewModelInput
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        yearField.setTitle(viewModel.getYear(), for: .normal)
        locationField.setTitle(viewModel.getLocation(), for: .normal)
    }
    
    private func setupUI() {
        yearField.layer.cornerRadius = 10.0
        locationField.layer.cornerRadius = 10.0
        findLaureatesButton.layer.cornerRadius = 10.0
    }
    
    @IBAction func findLaureates(sender: Any) {
        models = []
        tableView.reloadData()

        viewModel.findLaureates { [unowned self] (laureates) -> (Void) in
            reloadWithData(list: laureates)
        }
    }
    
    private func reloadWithData(list: [LaureateViewModel]) {
        models = list
        tableView.reloadData()
    }
    
    @IBAction func showYearPicker(sender: Any) {
        guard let picker = self.storyboard?.instantiateViewController(withIdentifier: "PickYearViewController") as? PickYearViewController else {
            return
        }
        picker.modalPresentationStyle = .custom
        picker.transitioningDelegate = transitionDelegate
        picker.view.layer.cornerRadius = 10.0
        picker.view.clipsToBounds = true
        self.present(picker, animated: true, completion: nil)
    }
    
}

extension FindNobelLaureatesViewController: ReceiveLocationDetails {

    func latestLocation(lat: Double, long: Double) {
        reloadWithData(list: [])
        viewModel.setLocation(lat: lat, long: long)
        locationField.setTitle(viewModel.getLocation(), for: .normal)
    }

}

extension FindNobelLaureatesViewController: ReceiveSelectedYear {

    func selected(year: String) {
        reloadWithData(list: [])
        viewModel.setYear(year: year)
        yearField.setTitle(viewModel.getYear(), for: .normal)
    }

}
