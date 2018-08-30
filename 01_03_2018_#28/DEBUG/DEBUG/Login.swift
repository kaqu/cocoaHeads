import UIKit

class LoginVC : UIViewController {
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func loginTap() {
        if (loginTextField.text?.isEmpty ?? true) {
            errorLabel.text = "Login empty"
        } else if (passwordTextField.text?.isEmpty ?? true) {
            errorLabel.text = "Password empty"
        } else {
            guard isValid(login: loginTextField.text ?? "", andPassword: passwordTextField.text ?? "") else {
                errorLabel.text = "Invalid login or password"
                return
            }
            errorLabel.text = "_"
            navigationController?.pushViewController(UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "afterLoginVC"), animated: true)
        }
    }
    
    override func viewDidLoad() {
        // ex let $loginVC = self
        //
        // ex -o -- isValid(login: "TEST", andPassword: "TEST")
        // ex -o -- $loginVC.isValid(login: "TEST", andPassword: "TEST")
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //  ex loginTextField.text = "login" ; CATransaction.flush() ; sleep(3) ; passwordTextField.text = "test" ; CATransaction.flush() ;  sleep(3) ; loginTap()
        super.viewDidAppear(animated)
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func isValid(login: String, andPassword password: String) -> Bool {
        guard login.lowercased() == "login" else {
            return false
        }
        
        guard password.count > 0 else {
            return false
        }
        
        return true
    }
}
