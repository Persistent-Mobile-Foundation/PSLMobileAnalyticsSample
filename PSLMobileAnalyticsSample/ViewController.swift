

import UIKit
import IBMMobileFirstPlatformFoundation

extension OCLogger {
    //Log methods with no metadata
    
    func logTraceWithMessages(message:String, _ args: CVarArg...) {
        log(withLevel: OCLogger_TRACE, message: message, args:getVaList(args), userInfo:Dictionary<String, String>())
    }
    
    func logFatalWithMessages(message:String, _ args: CVarArg...) {
        log(withLevel: OCLogger_FATAL, message: message, args:getVaList(args), userInfo:Dictionary<String, String>())
    }
    
    @objc func sendfuc(){
        OCLogger.send()
    }
}

class ViewController: UIViewController {

    @IBOutlet var userContextField: UITextField!
    @IBOutlet var httpAPIField: UITextField!
    @IBOutlet var logMessageField: UITextField!
    @IBOutlet var customLogMessageField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let serverURL = WLClient.sharedInstance().serverUrl()
        
        print("Testing Server Connection")
        WLAuthorizationManager.sharedInstance().obtainAccessToken(forScope: nil) { (token, error) -> Void in
            
            if (error != nil) {
                print("Did not recieve an access token from server \(String(describing: serverURL)): " + error.debugDescription)
            } else {
                print("Recieved the following access token value from server \(String(describing: serverURL)): " + (token?.value)!)
                WLAnalytics.sharedInstance()?.send()
            }
        }
    }
    
    @IBAction func userContextAction(sender: AnyObject) {
        print("inside user context")
        let userID : String = userContextField.text!;
        if(!userID.isEmpty){
            WLAnalytics.sharedInstance().setUserContext(userID)
            WLAnalytics.sharedInstance()?.send()
        }
    }

    @IBAction func callHttpApiAction(sender: AnyObject) {
        print("inside http api invoke")
        let address : String = httpAPIField.text!;
        
        if(!address.isEmpty){
            let request = WLResourceRequest(
                url: URL(string: address),
                method: WLHttpMethodGet
            )
            
            request!.send { (response, error) -> Void in
                if(error == nil){
                    NSLog(response!.responseText)
                }
                else{
                    NSLog(error.debugDescription)
                }
            }
            WLAnalytics.sharedInstance()?.send()
        }
    }

    @IBAction func logMessageAction(sender: AnyObject) {
        print("inside log message")
        let logmessage : String = logMessageField.text!
        if(!logmessage.isEmpty){
            OCLogger.setLevel(OCLogger_DEBUG);
            let logger : OCLogger = OCLogger.getInstanceWithPackage("MyTestLoggerPackage");
            logger.logFatalWithMessages(message: logmessage);
            logger.sendfuc();
            WLAnalytics.sharedInstance()?.send();
        }
    }

    @IBAction func logCustomMessageAction(sender: AnyObject) {
        print("inside log custom message")
        let customDataString:String = customLogMessageField.text!
        if(!customDataString.isEmpty){
            let dictionary = convertToDictionary(text: customDataString)
            WLAnalytics.sharedInstance().log("CUSTOM_MESSAGE", withMetadata	:(dictionary as! [AnyHashable : Any]));
            WLAnalytics.sharedInstance()?.send()
        }
    }

    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    @IBAction func callAdaptertAction(sender: AnyObject) {
        print("inside adapter call")
        let request = WLResourceRequest(
            url: URL(string: "/adapters/javaAdapter/resource/unprotected"),
            method: WLHttpMethodGet
        )
        
        request!.send { (response, error) -> Void in
            if(error == nil){
                NSLog(response!.responseText)
            }
            else{
                NSLog(error.debugDescription)
            }
        }
        WLAnalytics.sharedInstance()?.send()
    }

    @IBAction func invokeFeedbackAction(sender: AnyObject) {
        WLAnalytics.sharedInstance()?.triggerFeedbackMode()
    }

    @IBAction func triggerCrashAction(sender: AnyObject) {
        print("inside crash")
        
        //NSException(name: NSExceptionName("Test crash"), reason: "Ensure that BMSAnalytics framework is catching uncaught exceptions", userInfo: nil).raise()
        [0][1]
    }
}

