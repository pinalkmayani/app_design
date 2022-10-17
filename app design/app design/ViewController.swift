//
//  ViewController.swift
//  app design
//
//  Created by Pinal on 08/09/2022.
//

import UIKit

class ViewController: UIViewController {
    
  
    var iconClick = false

    @IBOutlet weak var txtclientCode: UITextField!
    @IBOutlet weak var btnHidePassword: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
      // txtClientCode.text = "afhstX"
       // txtClientCode.text = "iConnect"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let clientName = appdelegate.dicCompanyCode.value(forKey: "Name") as? String {
            txtclientCode.text = clientName
        }
    }
    
    @IBAction func btnSubmit(_ sender: Any) {
        if txtclientCode.text == "" {
            AppUtilities.showAlert(title : "", message: "please enter Company code", cancelButtonTitle: "OK")
        }else {
            getClientsAPI()
        }
    }
    
    @IBAction func btnHidePassword(_ sender: Any) {
        if(iconClick==true){
            txtclientCode.isSecureTextEntry = true
            btnHidePassword.setImage(UIImage.init(named: "eye_hide"), for: .normal)
            iconClick = false
        }
        else
        {
            txtclientCode.isSecureTextEntry = false
            btnHidePassword.setImage(UIImage.init(named: "eye"), for: .normal)
        }
    }
    
    //MARK:- API CALLING
    
    func getClientAPI(){
        APIClient.sharedInstance.showIndicator()
        
        let param = [":"]
        let newURL = GET_CLIENTS + "\(txtclientCode.text!)"
        print(newURL)
        APIClient.sharedInstance.MakeAPICallWithoutAuthHeaderGet(newURL, parameters: param) { (response, error, statusCode) in
            if error == nil{
                APIClient.sharedInstance.hideIndicator()
                print("SATUS CODE \(String(describing: statusCode))")
                print("response \(String(describing: response))")
            }
            if statusCode == 200{
                let dic = response! as? NSDictionary
                appdelegate.dicCompanyCode = dic!
                
                UserDefaults.standard.setValue(appdelegate.dicCompanyCode, forKey: "Company code")
                UserDefaults.standard.synchronize()
                
                let storyBoard: UIStoryboard=UIStoryboard(name: "Main", bundle: nil)
                let controller = storyBoard.instantiateViewController(withIdentifier: "LogniVC") as!LoginVC
                self.navigationController?.pushViewController(controller, animated: true)
            }
            else {
                APIClient.sharedInstance.hideIndicator()
                AppUtilites.showAlert(title: "", message: "Company code not valid", cancelButtonTitle: "OK")
            }
        }
            
       }
    
            
           
    }
    
    
    


