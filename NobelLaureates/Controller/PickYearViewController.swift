
import UIKit

class PickYearViewController: UIViewController, UICollectionViewDataSource {
    
    var yearList: [String] = []
    var callback: ((String)->(Void))? = nil
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    private func setUp() {
        for i in 1900...2020 {
            yearList.append("\(i)")
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        yearList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PickYearViewCell", for: indexPath) as? PickYearViewCell else {
            fatalError()
        }
        cell.yearLabel.text = yearList[indexPath.row]
        return cell
    }
    
    func setHandler(callback: @escaping ((String)->(Void))) {
        self.callback = callback
    }
    
    private func sendSendSelectedYear(selectedYear: String) {
        guard let pController = presentationController, let presentingVC = pController.presentingViewController as? ReceiveSelectedYear else {
            return
        }
        presentingVC.selected(year: selectedYear)
    }
}

extension PickYearViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedYear = yearList[indexPath.row]
        sendSendSelectedYear(selectedYear: selectedYear)
        self.dismiss(animated: true, completion: nil)
    }
}
