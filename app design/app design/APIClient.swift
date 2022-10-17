//
//  APIClient.swift
//  app design
//
//  Created by Pinal on 09/09/2022.
//


import Foundation
import Alamofire
import SVProgressHUD
import UIKit

class APIClient: NSObject {
    
    class var sharedInstance: APIClient {
        
        struct Static {
            static let instance: APIClient = APIClient()
        }
        return Static.instance
    }
    
    var responseData: NSMutableData!
    
    func pushNetworkErrorVC()
    {
        
        //        if let networkErrorVC = AppUtilites.sharedInstance.getViewController(controllerName: "NetworkErrorViewController") as? NetworkErrorViewController {
        //
        //            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
        //                if let vc = appDelegate.window?.rootViewController
        //                {
        //                    vc.present(networkErrorVC, animated: true, completion: {
        //
        //                    })
        //                }
        //            }
        //        }
    }
    
    func MakeLoginAPICall(email: String, password: String, completionHandler:@escaping (NSDictionary?, Error?, Int?) -> Void) {
        
        let parameters = [USER_NAME: email, USER_PASSWORD: password]
        print(parameters)
        
        UserDefaults.standard.set(email, forKey: "currentUserEmail")
        UserDefaults.standard.set(password, forKey: "currentUserPassword")
        UserDefaults.standard.synchronize()
        
        if NetConnection.isConnectedToNetwork() == true
        {
            
         //   let headers: HTTPHeaders = ["Content-type":"application/json",
//                                        "Authorization":"bearer \(appdelegate.dicGetAuthToken.value(forKey: "access_token") as! String)"]
            
         
            
            AF.request(BASE_URL + USER_LOGIN, method: .post, parameters: parameters, encoding: URLEncoding(destination: .httpBody), headers: []).responseJSON { response in
                
                switch(response.result) {
                    
                case .success:
                    if response.value != nil{
                        if let responseDict = ((response.value as AnyObject) as? NSDictionary) {
                            completionHandler(responseDict, nil, response.response?.statusCode)
                        }
                    }
                case .failure:
                    print(response.error!)
                    completionHandler(nil, response.error, response.response?.statusCode)
                }
            }
        }
        else
        {
            print("No Network Found!")
            pushNetworkErrorVC()
            SVProgressHUD.dismiss()
        }
    }
    
    func MakeAPICallWithoutAuthHeaderPost(_ url: String, parameters: [String: Any], completionHandler:@escaping (AnyObject?, Error?, Int?) -> Void) {
        
        print("url = \(BASE_URL + url)")
        print(parameters)
        
        if NetConnection.isConnectedToNetwork() == true
        {
            AF.request(BASE_URL + url, method: .post, parameters: parameters, encoding: URLEncoding(destination: .methodDependent), headers: [:]).responseJSON { response in
                
                switch(response.result) {
                    
                case .success:
                    if response.value != nil{
                        if let responseDict = ((response.value as AnyObject) as? AnyObject) {
                            completionHandler(responseDict, nil, response.response?.statusCode)
                        }
                    }
                    
                case .failure:
                    print(response.error!)
                    print("Http Status Code: \(String(describing: response.response?.statusCode))")
                    completionHandler(nil, response.error, response.response?.statusCode )
                }
            }
        }
        else
        {
            print("No Network Found!")
            pushNetworkErrorVC()
            SVProgressHUD.dismiss()
        }
    }
    
    
    func MakeAPICallWithAuthHeaderPost(_ url: String, parameters: [String: Any], completionHandler:@escaping (AnyObject?, Error?, Int?) -> Void) {
        
        print("url = \(BASE_URL + url)")
        print(parameters)
        
        if NetConnection.isConnectedToNetwork() == true
        {
            let headers: HTTPHeaders = ["Authorization":"Basic \(appdelegate.dicLogin.value(forKey: "Cipher")!)"]

            print(headers)
            
            AF.request(BASE_URL + url, method: .post, parameters: parameters, encoding: URLEncoding(destination: .httpBody), headers: headers).responseJSON { response in
                
                switch(response.result) {
                    
                case .success:
                    if response.value != nil{
                        if let responseDict = ((response.value as AnyObject) as? AnyObject) {
                            completionHandler(responseDict, nil, response.response?.statusCode)
                        }
                    }
                    
                case .failure:
                    print(response.error!)
                    print("Http Status Code: \(String(describing: response.response?.statusCode))")
                    completionHandler(nil, response.error, response.response?.statusCode )
                }
            }
        }
        else
        {
            print("No Network Found!")
            pushNetworkErrorVC()
            SVProgressHUD.dismiss()
        }
    }
    
    func MakeAPICallWithoutAuthHeaderGet(_ url: String, parameters: [String: Any], completionHandler:@escaping (AnyObject?, Error?, Int?) -> Void) {
        
        print("url = \(BASE_URL + url)")
        
        if NetConnection.isConnectedToNetwork() == true
        {
            AF.request(BASE_URL + url, method: .get, encoding: URLEncoding(destination: .methodDependent), headers: [:]).responseJSON { response in
                
                switch(response.result) {
                    
                case .success:
                    if response.value != nil{
                        if let responseDict = ((response.value as AnyObject) as? AnyObject) {
                            completionHandler(responseDict, nil, response.response?.statusCode)
                        }
                    }
                    
                case .failure:
                    print(response.error!)
                    print("Http Status Code: \(String(describing: response.response?.statusCode))")
                    completionHandler(nil, response.error, response.response?.statusCode )
                }
            }
        }
        else
        {
            print("No Network Found!")
            pushNetworkErrorVC()
            SVProgressHUD.dismiss()
        }
    }
    
//    func MakeAPICallWihAuthHeaderGet(_ url: String, parameters: [String: Any], completionHandler:@escaping (AnyObject?, Error?, Int?) -> Void) {
//
//        print("url = \(url)")
//
//        if NetConnection.isConnectedToNetwork() == true
//        {
//            //let user_token = UserDefaults.standard.value(forKey: "auth_Token") as? String
//
//        let headers: HTTPHeaders = ["Authorization":"Bearer \(appdelegate.accessToken)"]
//
//
//            AF.request(url, method: .get, encoding: URLEncoding(destination: .httpBody), headers: headers).responseJSON { response in
//
//                switch(response.result) {
//
//                case .success:
//                    if response.value != nil{
//                        if let responseDict = ((response.value as AnyObject) as? AnyObject) {
//                            completionHandler(responseDict, nil, response.response?.statusCode)
//                        }
//                    }
//
//                case .failure:
//                    print(response.error!)
//                    print("Http Status Code: \(String(describing: response.response?.statusCode))")
//                    completionHandler(nil, response.error, response.response?.statusCode )
//                }
//            }
//        }
//        else
//        {
//            print("No Network Found!")
//            pushNetworkErrorVC()
//            SVProgressHUD.dismiss()
//        }
//    }
    func MakeAPICallWihAuthHeaderPut(_ url: String, parameters: [String: Any], completionHandler:@escaping (AnyObject?, Error?, Int?) -> Void) {
        
        print("url = \(url)")
        
        if NetConnection.isConnectedToNetwork() == true
        {
            let headers: HTTPHeaders = ["Authorization":"Bearer \(appdelegate.accessToken)"]
            
            AF.request(url, method: .put, encoding: URLEncoding(destination: .httpBody), headers: headers).responseJSON { response in
                
                switch(response.result) {
                    
                case .success:
                    if response.value != nil{
                        if let responseDict = ((response.value as AnyObject) as? AnyObject) {
                            completionHandler(responseDict, nil, response.response?.statusCode)
                        }
                    }
                    
                case .failure:
                    print(response.error!)
                    print("Http Status Code: \(String(describing: response.response?.statusCode))")
                    completionHandler(nil, response.error, response.response?.statusCode )
                }
            }
        }
        else
        {
            print("No Network Found!")
            pushNetworkErrorVC()
            SVProgressHUD.dismiss()
        }
    }
    //responseString
    func MakeAPICallWihAuthHeaderGet(_ url: String, parameters: [String: Any], completionHandler:@escaping (AnyObject?, Error?, Int?) -> Void) {
        
        print("url = \(url)")
        
        if NetConnection.isConnectedToNetwork() == true
        {
          
            let headers: HTTPHeaders = ["Authorization":"Basic \(appdelegate.dicLogin.value(forKey: "Cipher")!)"]
            

            AF.request(BASE_URL + url, method: .get, encoding: URLEncoding(destination: .httpBody), headers: headers).responseString { response in
                
                switch(response.result) {
                    
                case .success:
                    if response.value != nil{
                        if let responseDict = ((response.value as AnyObject) as? AnyObject) {
                            completionHandler(responseDict, nil, response.response?.statusCode)
                        }
                    }
                    
                case .failure:
                    print(response.error!)
                    print("Http Status Code: \(String(describing: response.response?.statusCode))")
                    completionHandler(nil, response.error, response.response?.statusCode )
                }
            }
            
        }
        else
        {
            print("No Network Found!")
            pushNetworkErrorVC()
            SVProgressHUD.dismiss()
        }
    }
    //responseJSON
    func MakeAPICallWihAuthHeaderGet2(_ url: String, parameters: [String: Any], completionHandler:@escaping (AnyObject?, Error?, Int?) -> Void) {
        
        print("url = \(url)")
        
        if NetConnection.isConnectedToNetwork() == true
        {
          
            let headers: HTTPHeaders = ["Authorization":"Basic \(appdelegate.dicLogin.value(forKey: "Cipher")!)"]
            

            AF.request(BASE_URL + url, method: .get, encoding: URLEncoding(destination: .httpBody), headers: headers).responseJSON { response in
                
                switch(response.result) {
                    
                case .success:
                    if response.value != nil{
                        if let responseDict = ((response.value as AnyObject) as? AnyObject) {
                            completionHandler(responseDict, nil, response.response?.statusCode)
                        }
                    }
                    
                case .failure:
                    print(response.error!)
                    print("Http Status Code: \(String(describing: response.response?.statusCode))")
                    completionHandler(nil, response.error, response.response?.statusCode )
                }
            }
            
        }
        else
        {
            print("No Network Found!")
            pushNetworkErrorVC()
            SVProgressHUD.dismiss()
        }
    }

    
    
    func MakeAPICallWithAuthHeaderPost2(_ url: String, parameters: [String: Any], completionHandler:@escaping (AnyObject?, Error?, Int?) -> Void) {
        
        print("url = \(BASE_URL + url)")
        print(parameters)
        
        if NetConnection.isConnectedToNetwork() == true
        {
           // let headers: HTTPHeaders =  ["Content-Type": "application/x-www-form-urlencoded"]
            
            let headers: HTTPHeaders = ["d-token":"\(appdelegate.firebasTokenID)"]

            print(headers)
            
            AF.request(BASE_URL + url, method: .post, parameters: parameters, encoding: URLEncoding(destination: .httpBody), headers: headers).responseJSON { response in
                
                switch(response.result) {
                    
                case .success:
                    if response.value != nil{
                        if let responseDict = ((response.value as AnyObject) as? AnyObject) {
                            completionHandler(responseDict, nil, response.response?.statusCode)
                        }
                    }
                    
                case .failure:
                    print(response.error!)
                    print("Http Status Code: \(String(describing: response.response?.statusCode))")
                    completionHandler(nil, response.error, response.response?.statusCode )
                }
            }
        }
        else
        {
            print("No Network Found!")
            pushNetworkErrorVC()
            SVProgressHUD.dismiss()
        }
    }
    
    func MakeAPICallWihAuthHeaderPost(_ url: String, parameters: [String: Any], completionHandler:@escaping (AnyObject?, Error?, Int?) -> Void) {
        
        print("url = \(BASE_URL + url)")
        
        if NetConnection.isConnectedToNetwork() == true
        {
            let user_token = UserDefaults.standard.value(forKey: "auth_Token") as? String
            
            let headers: HTTPHeaders = ["Authorization":"Token \(user_token ?? "")"]
            print(user_token ?? "")
            
            AF.request(BASE_URL + url, method: .post, parameters: parameters, encoding: URLEncoding(destination: .httpBody), headers: headers).responseJSON { response in
                
                switch(response.result) {
                    
                case .success:
                    if response.value != nil{
                        if let responseDict = ((response.value as AnyObject) as? AnyObject) {
                            completionHandler(responseDict, nil, response.response?.statusCode)
                        }
                    }
                    
                case .failure:
                    print(response.error!)
                    print("Http Status Code: \(String(describing: response.response?.statusCode))")
                    completionHandler(nil, response.error, response.response?.statusCode )
                }
            }
        }
        else
        {
            print("No Network Found!")
            pushNetworkErrorVC()
            SVProgressHUD.dismiss()
        }
    }
    
    func showIndicator(){
        SVProgressHUD.show()
    }
    
    func hideIndicator(){
        SVProgressHUD.dismiss()
    }
    
    func showSuccessIndicator(message: String){
        SVProgressHUD.showSuccess(withStatus: message)
    }
}


