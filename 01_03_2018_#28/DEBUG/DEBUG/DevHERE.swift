import UIKit

class DevVC : UIViewController {
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .blue
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // ex self.view.backgroundColor = .red
        // ex CATransaction.flush()
        //
        // ex dismiss(animated: false)
        //
        // ex -i 0 -o -- otherNotCalledFunction(someArg: "TEST")
        super.viewDidAppear(animated)
    }
    
    func otherNotCalledFunction(someArg: String) -> String {
        var changedArg = someArg.uppercased()
        
        changedArg.append(" tested!")
        print("DevHERE - \(changedArg)")
        
        return changedArg
    }
}
