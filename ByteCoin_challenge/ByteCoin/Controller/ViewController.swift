import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var bitcoinLabel: UILabel!
    
    var coinManager = CoinManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coinManager.delegate = self
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        
    }
    
}
//MARK: - CoinManagerDelegate
extension ViewController: CoinManagerDelegate {
    func didFailWithError(error: Error) {
        print(error)
    }
    
    func didUpdatePriceCoin(_ coinManager: String, currency: String) {
        DispatchQueue.main.async {
            self.bitcoinLabel.text = coinManager
            self.currencyLabel.text = currency
            print(coinManager)
        }
    }
}

//MARK: - UIPickerViewDelegate, UIPickerViewDataSource

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let coinPrice = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: coinPrice)
        coinManager.fetchPriceCoin()
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
}
