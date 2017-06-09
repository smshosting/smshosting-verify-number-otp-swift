# Smshosting Verify OTP
You can use Smshosting Verify to:
* check that a person has access to a specific phone number
* verify a transaction 
* 2-factor authentication

How to verify a phone number:
1. SmshostingVerify sends a pin via sms to the required number
2. The user inserts pin into application
3. SmshostingVerify check that the PIN entered by user is the one you sent

## INSTALLATION
### CocoaPods
Available soon
### Copy File
Copy **SmshostingVerify.swift** file into your project

## USAGE
### Initialization
In your **AppDelegate.swift**
```Swift

SmshostingVerify.startWithKeyAndSecret( key:"AUTH_KEY", secret:"AUTH_SECRET" )

```
You can obtain your AUTH_KEY and AUTH_SECRET by logging into your [smshosting.it](https://www.smshosting.it) account.
### Send Pin
```Swift
SmshostingVerify.sendPinWithPhoneNumberAndText(phoneNumber: completeNumber, text:"SMSHosting code ${verify_code}", sandbox:false, completion: {
(result: [String:Any]) in
   DispatchQueue.main.async {
      if(result["errorCode"] == nil){
            //Request Done
            //Pin sent, do what you want...
         }
         else{
            //Request Error
            //Pin NOT sent, handle error...
         }
      }
   })
```
### Verify Pin
```Swift
SmshostingVerify.verifyWithIdAndCode(verifyId: verifyId, verifyCode: pinTextField.text!, completion: {
(result: [String:Any]) in
   DispatchQueue.main.async {
         if(result["errorCode"] == nil){
            //Request Done
            if(result["verify_status"] != nil){
                  let statusString:String = result["verify_status"] as! String
                  if(statusString == "VERIFIED"){
                     //Verification done!                      
                  }
                  else{
                     //Verification failed, entered pin is not valid
                  }
            }
         }
         else{
            //Request Error
            //Verification failed, handle error...
         }
      }
   })
```
## MORE...
Smshosting OTP API documentation: https://www.smshosting.it/it/docs/sms-rest-api/sms-otp
