//
//  SmshostingVerify.swift
//  SmshostingVerifyTest
//
//  Created by Sviluppo 3 on 29/05/17.
//  Copyright © 2017 i-contact. All rights reserved.
//

import Foundation
import UIKit

public class SmshostingVerify: NSObject {
    
    //Urls
    static var baseUrl = "https://api.smshosting.it"
    static var urlSendCode:String  = baseUrl + "/rest/api/verify/send"
    static var urlVerifyCode:String = baseUrl + "/rest/api/verify/check"
    static var countryCodesList:String = "http://api.smshosting.it/sp/api/user/country/available"
    
    //keys
    static var saveTokenKey = "smsh-auth-key"
    static var saveSecretKey = "smsh-auth-secret"
    
    //Country Codes
    public static var countryCodes = "[{\"countyName\":\"AFGHANISTAN\",\"countyCode\":\"AF\",\"prefix\":93},{\"countyName\":\"ALBANIA\",\"countyCode\":\"AL\",\"prefix\":355},{\"countyName\":\"ALGERIA\",\"countyCode\":\"DZ\",\"prefix\":213},{\"countyName\":\"ANDORRA\",\"countyCode\":\"AD\",\"prefix\":376},{\"countyName\":\"ARGENTINA\",\"countyCode\":\"AR\",\"prefix\":54},{\"countyName\":\"ARMENIA\",\"countyCode\":\"AM\",\"prefix\":374},{\"countyName\":\"AUSTRALIA\",\"countyCode\":\"AU\",\"prefix\":61},{\"countyName\":\"AUSTRIA\",\"countyCode\":\"AT\",\"prefix\":43},{\"countyName\":\"AZERBAIJAN\",\"countyCode\":\"AZ\",\"prefix\":994},{\"countyName\":\"BAHRAIN\",\"countyCode\":\"BH\",\"prefix\":973},{\"countyName\":\"BANGLADESH\",\"countyCode\":\"BD\",\"prefix\":880},{\"countyName\":\"BELARUS\",\"countyCode\":\"BY\",\"prefix\":375},{\"countyName\":\"BELGIUM\",\"countyCode\":\"BE\",\"prefix\":32},{\"countyName\":\"BENIN\",\"countyCode\":\"BJ\",\"prefix\":229},{\"countyName\":\"BOLIVIA\",\"countyCode\":\"BO\",\"prefix\":591},{\"countyName\":\"BOSNIA\",\"countyCode\":\"BA\",\"prefix\":387},{\"countyName\":\"BOTSWANA\",\"countyCode\":\"BW\",\"prefix\":267},{\"countyName\":\"BRAZIL\",\"countyCode\":\"BR\",\"prefix\":55},{\"countyName\":\"BRUNEI\",\"countyCode\":\"BN\",\"prefix\":673},{\"countyName\":\"BULGARIA\",\"countyCode\":\"BG\",\"prefix\":359},{\"countyName\":\"BURUNDI\",\"countyCode\":\"BI\",\"prefix\":257},{\"countyName\":\"CAMBODJA\",\"countyCode\":\"KH\",\"prefix\":855},{\"countyName\":\"CAMEROON\",\"countyCode\":\"CM\",\"prefix\":237},{\"countyName\":\"CAPE VERDE\",\"countyCode\":\"CV\",\"prefix\":238},{\"countyName\":\"CENTRAL AFRICA REP.\",\"countyCode\":\"CF\",\"prefix\":236},{\"countyName\":\"CHILE\",\"countyCode\":\"CL\",\"prefix\":56},{\"countyName\":\"CHINA\",\"countyCode\":\"CN\",\"prefix\":86},{\"countyName\":\"CONGO\",\"countyCode\":\"CG\",\"prefix\":242},{\"countyName\":\"CROATIA\",\"countyCode\":\"HR\",\"prefix\":385},{\"countyName\":\"CUBA\",\"countyCode\":\"CU\",\"prefix\":53},{\"countyName\":\"CYPRUS\",\"countyCode\":\"CY\",\"prefix\":357},{\"countyName\":\"CZEK REPUBLIC\",\"countyCode\":\"CZ\",\"prefix\":420},{\"countyName\":\"DENMARK\",\"countyCode\":\"DK\",\"prefix\":45},{\"countyName\":\"DOMINICAN REPUBLIC\",\"countyCode\":\"DO\",\"prefix\":1809},{\"countyName\":\"ECUADOR\",\"countyCode\":\"EC\",\"prefix\":593},{\"countyName\":\"EGYPT\",\"countyCode\":\"EG\",\"prefix\":20},{\"countyName\":\"EL SALVADOR\",\"countyCode\":\"SV\",\"prefix\":503},{\"countyName\":\"ESTONIA\",\"countyCode\":\"EE\",\"prefix\":372},{\"countyName\":\"ETHIOPIA\",\"countyCode\":\"ET\",\"prefix\":251},{\"countyName\":\"FAROE ISLANDS\",\"countyCode\":\"FO\",\"prefix\":298},{\"countyName\":\"FIJI\",\"countyCode\":\"FJ\",\"prefix\":679},{\"countyName\":\"FINLAND\",\"countyCode\":\"FI\",\"prefix\":358},{\"countyName\":\"FRANCE\",\"countyCode\":\"FR\",\"prefix\":33},{\"countyName\":\"GABON\",\"countyCode\":\"GA\",\"prefix\":241},{\"countyName\":\"GEORGIA\",\"countyCode\":\"GE\",\"prefix\":995},{\"countyName\":\"GERMANY\",\"countyCode\":\"DE\",\"prefix\":49},{\"countyName\":\"GHANA\",\"countyCode\":\"GH\",\"prefix\":233},{\"countyName\":\"GIBILTERRA\",\"countyCode\":\"GI\",\"prefix\":350},{\"countyName\":\"GREECE\",\"countyCode\":\"GR\",\"prefix\":30},{\"countyName\":\"GREENLAND\",\"countyCode\":\"GL\",\"prefix\":299},{\"countyName\":\"GUADALUPE\",\"countyCode\":\"GP\",\"prefix\":590},{\"countyName\":\"GUATEMALA\",\"countyCode\":\"GT\",\"prefix\":502},{\"countyName\":\"GUINEA\",\"countyCode\":\"GQ\",\"prefix\":240},{\"countyName\":\"GUINEA\",\"countyCode\":\"GN\",\"prefix\":224},{\"countyName\":\"HONG KONG\",\"countyCode\":\"HK\",\"prefix\":852},{\"countyName\":\"HUNGARY\",\"countyCode\":\"HU\",\"prefix\":36},{\"countyName\":\"ICELAND\",\"countyCode\":\"IS\",\"prefix\":354},{\"countyName\":\"INDIA\",\"countyCode\":\"IN\",\"prefix\":91},{\"countyName\":\"INDONESIA\",\"countyCode\":\"ID\",\"prefix\":62},{\"countyName\":\"IRELAND\",\"countyCode\":\"IE\",\"prefix\":353},{\"countyName\":\"ISRAELE\",\"countyCode\":\"IL\",\"prefix\":972},{\"countyName\":\"ITALY\",\"countyCode\":\"IT\",\"prefix\":39},{\"countyName\":\"IVORY COAST\",\"countyCode\":\"CI\",\"prefix\":225},{\"countyName\":\"JAPAN\",\"countyCode\":\"JP\",\"prefix\":81},{\"countyName\":\"JORDAN\",\"countyCode\":\"JO\",\"prefix\":962},{\"countyName\":\"KENYA\",\"countyCode\":\"KE\",\"prefix\":254},{\"countyName\":\"KUWAIT\",\"countyCode\":\"KW\",\"prefix\":965},{\"countyName\":\"KYRGYSTHAN\",\"countyCode\":\"KG\",\"prefix\":996},{\"countyName\":\"LATVIA\",\"countyCode\":\"LV\",\"prefix\":371},{\"countyName\":\"LEBANON\",\"countyCode\":\"LB\",\"prefix\":961},{\"countyName\":\"LIBYA\",\"countyCode\":\"LY\",\"prefix\":218},{\"countyName\":\"LIECHTENSTEIN\",\"countyCode\":\"LI\",\"prefix\":423},{\"countyName\":\"LITHUANIA\",\"countyCode\":\"LT\",\"prefix\":370},{\"countyName\":\"LUSSEMBURGO\",\"countyCode\":\"LU\",\"prefix\":352},{\"countyName\":\"MACAO\",\"countyCode\":\"MO\",\"prefix\":853},{\"countyName\":\"MACEDONIA\",\"countyCode\":\"MK\",\"prefix\":389},{\"countyName\":\"MADACASCAR\",\"countyCode\":\"MG\",\"prefix\":261},{\"countyName\":\"MALAWI\",\"countyCode\":\"MW\",\"prefix\":265},{\"countyName\":\"MALAYSIA\",\"countyCode\":\"MY\",\"prefix\":60},{\"countyName\":\"MALDIVES\",\"countyCode\":\"MV\",\"prefix\":960},{\"countyName\":\"MALTA\",\"countyCode\":\"MT\",\"prefix\":356},{\"countyName\":\"MARTINIQUE\",\"countyCode\":\"MQ\",\"prefix\":596},{\"countyName\":\"MAURITANIA\",\"countyCode\":\"MR\",\"prefix\":222},{\"countyName\":\"MAURITIUS\",\"countyCode\":\"MU\",\"prefix\":230},{\"countyName\":\"MEXICO\",\"countyCode\":\"MX\",\"prefix\":52},{\"countyName\":\"MOLDOVA\",\"countyCode\":\"MD\",\"prefix\":373},{\"countyName\":\"MONACO\",\"countyCode\":\"MC\",\"prefix\":377},{\"countyName\":\"MONGOLIA\",\"countyCode\":\"MN\",\"prefix\":976},{\"countyName\":\"MOROCCO\",\"countyCode\":\"MA\",\"prefix\":212},{\"countyName\":\"MOZAMBICO\",\"countyCode\":\"MZ\",\"prefix\":258},{\"countyName\":\"NAMIDIA\",\"countyCode\":\"NA\",\"prefix\":264},{\"countyName\":\"NETHERLANDS\",\"countyCode\":\"NL\",\"prefix\":31},{\"countyName\":\"NEW CALEDONIA\",\"countyCode\":\"NC\",\"prefix\":687},{\"countyName\":\"NEW ZELAND\",\"countyCode\":\"NZ\",\"prefix\":64},{\"countyName\":\"NIGERIA\",\"countyCode\":\"NG\",\"prefix\":234},{\"countyName\":\"NORWAY\",\"countyCode\":\"NO\",\"prefix\":47},{\"countyName\":\"OMAN\",\"countyCode\":\"OM\",\"prefix\":968},{\"countyName\":\"PAKISTAN\",\"countyCode\":\"PK\",\"prefix\":92},{\"countyName\":\"PERU\",\"countyCode\":\"PE\",\"prefix\":51},{\"countyName\":\"PHILIPPINES\",\"countyCode\":\"PH\",\"prefix\":63},{\"countyName\":\"POLAND\",\"countyCode\":\"PL\",\"prefix\":48},{\"countyName\":\"PORTUGAL\",\"countyCode\":\"PT\",\"prefix\":351},{\"countyName\":\"QUATAR\",\"countyCode\":\"QA\",\"prefix\":974},{\"countyName\":\"REUNION\",\"countyCode\":\"RE\",\"prefix\":262},{\"countyName\":\"ROMANIA\",\"countyCode\":\"RO\",\"prefix\":40},{\"countyName\":\"RUSSIA\",\"countyCode\":\"RU\",\"prefix\":7},{\"countyName\":\"SAN MARINO\",\"countyCode\":\"SM\",\"prefix\":378},{\"countyName\":\"SATELLITE\",\"prefix\":882},{\"countyName\":\"SAUDI ARABIA\",\"countyCode\":\"SA\",\"prefix\":966},{\"countyName\":\"SENEGAL\",\"countyCode\":\"SN\",\"prefix\":221},{\"countyName\":\"SEYCHELLES\",\"countyCode\":\"SC\",\"prefix\":248},{\"countyName\":\"SINGAPORE\",\"countyCode\":\"SG\",\"prefix\":65},{\"countyName\":\"SLOVAK REPUBLIC\",\"countyCode\":\"SK\",\"prefix\":421},{\"countyName\":\"SLOVENIA\",\"countyCode\":\"SI\",\"prefix\":386},{\"countyName\":\"SOUTH AFRICA\",\"countyCode\":\"ZA\",\"prefix\":27},{\"countyName\":\"SPAIN\",\"countyCode\":\"ES\",\"prefix\":34},{\"countyName\":\"SRI LANKA\",\"countyCode\":\"LK\",\"prefix\":94},{\"countyName\":\"SUD COREA\",\"countyCode\":\"KR\",\"prefix\":82},{\"countyName\":\"SUDAN\",\"countyCode\":\"SD\",\"prefix\":249},{\"countyName\":\"SWAZILAND\",\"countyCode\":\"SZ\",\"prefix\":268},{\"countyName\":\"SWEDEN\",\"countyCode\":\"SE\",\"prefix\":46},{\"countyName\":\"SWITZERLAND\",\"countyCode\":\"CH\",\"prefix\":41},{\"countyName\":\"SYRIA\",\"countyCode\":\"SY\",\"prefix\":963},{\"countyName\":\"TAIWAN\",\"countyCode\":\"TW\",\"prefix\":886},{\"countyName\":\"TANZANIA\",\"countyCode\":\"TZ\",\"prefix\":255},{\"countyName\":\"THAILAND\",\"countyCode\":\"TH\",\"prefix\":66},{\"countyName\":\"TOGO\",\"countyCode\":\"TG\",\"prefix\":228},{\"countyName\":\"TUNISIA\",\"countyCode\":\"TN\",\"prefix\":216},{\"countyName\":\"TURKEY\",\"countyCode\":\"TR\",\"prefix\":90},{\"countyName\":\"TURKMENISTAN\",\"countyCode\":\"TM\",\"prefix\":993},{\"countyName\":\"UGANDA\",\"countyCode\":\"UG\",\"prefix\":256},{\"countyName\":\"UKRAINE\",\"countyCode\":\"UA\",\"prefix\":380},{\"countyName\":\"UNITED ARAB EMIRATES\",\"countyCode\":\"AE\",\"prefix\":971},{\"countyName\":\"UNITED KINGDOM\",\"countyCode\":\"GB\",\"prefix\":44},{\"countyName\":\"URUGUAY\",\"countyCode\":\"UY\",\"prefix\":598},{\"countyName\":\"USA/CANADA\",\"countyCode\":\"US\",\"prefix\":1},{\"countyName\":\"UZBEKISTAN\",\"countyCode\":\"UZ\",\"prefix\":998},{\"countyName\":\"VENEZUELA\",\"countyCode\":\"VE\",\"prefix\":58},{\"countyName\":\"VIETNAM\",\"countyCode\":\"VN\",\"prefix\":84},{\"countyName\":\"YEMEN\",\"countyCode\":\"YE\",\"prefix\":967},{\"countyName\":\"YUGOSLAVIA\",\"prefix\":381},{\"countyName\":\"ZAMBIA\",\"countyCode\":\"ZM\",\"prefix\":260},{\"countyName\":\"ZIMBABWE\",\"countyCode\":\"ZW\",\"prefix\":263}]"

    
    public static func startWithKeyAndSecret(key:String, secret:String){
        
        let defaults = UserDefaults.standard
        defaults.set(key, forKey: SmshostingVerify.saveTokenKey)
        defaults.set(secret, forKey: SmshostingVerify.saveSecretKey)
        defaults.synchronize()
    }
    
    public static func sendPinWithPhoneNumberAndText(phoneNumber: String, text: String, sandbox:Bool, completion: @escaping (_ result: [String:Any]) -> Void) {
        //Send SMS with PIN
        
        let defaults = UserDefaults.standard
        if(defaults.value(forKey: SmshostingVerify.saveTokenKey) != nil && defaults.value(forKey: SmshostingVerify.saveSecretKey) != nil){
            
            
            
            let username = defaults.value(forKey: SmshostingVerify.saveTokenKey) as! String
            let password = defaults.value(forKey: SmshostingVerify.saveSecretKey)  as! String
            let loginString = String(format: "%@:%@", username, password)
            let userPasswordData = loginString.data(using: String.Encoding.utf8)
            let base64EncodedCredential:String = (userPasswordData?.base64EncodedString())!
            let authString = "Basic " + String(base64EncodedCredential)
            let config = URLSessionConfiguration.default
            config.httpAdditionalHeaders = ["Authorization" : authString]
            let session = URLSession(configuration: config)
            
            var request = URLRequest(url: URL(string: SmshostingVerify.urlSendCode)!)
            request.httpMethod = "POST"
            
            var postString = "to=" + phoneNumber + "&text=" + text
            if(sandbox){
                postString = postString + "&sandbox=true"
            }
            request.httpBody = postString.data(using: .utf8)
            
            let task = session.dataTask(with: request) { data, response, error in
                
                
                if(error == nil){
                    
                    if(data != nil){
                        let responseJSON = try? JSONSerialization.jsonObject(with: data!, options: [])
                        if let responseJSON = responseJSON as? [String: Any] {
                            completion(responseJSON)
                        }
                    }
                    else{
                        completion(SmshostingVerify.handleRequestErrors(response: response, data: data, error: error))
                    }
                    
                }else{
                    completion(SmshostingVerify.handleRequestErrors(response: response, data: data, error: error))
                }
                
            }
            task.resume()
            
            
            
        }
        else{
            
            completion(SmshostingVerify.handleNoCredentials())
            
        }

    }
    
    
    public static func verifyWithIdAndCode(verifyId: String, verifyCode: String, completion: @escaping (_ result: [String:Any]) -> Void) {
        //Verify with received PIN
        
        let defaults = UserDefaults.standard
        if(defaults.value(forKey: SmshostingVerify.saveTokenKey) != nil && defaults.value(forKey: SmshostingVerify.saveSecretKey) != nil){
            
            
            
            let username = defaults.value(forKey: SmshostingVerify.saveTokenKey) as! String
            let password = defaults.value(forKey: SmshostingVerify.saveSecretKey)  as! String
            let loginString = String(format: "%@:%@", username, password)
            let userPasswordData = loginString.data(using: String.Encoding.utf8)
            let base64EncodedCredential:String = (userPasswordData?.base64EncodedString())!
            let authString = "Basic " + String(base64EncodedCredential)
            let config = URLSessionConfiguration.default
            config.httpAdditionalHeaders = ["Authorization" : authString]
            let session = URLSession(configuration: config)
            
            let url:String = SmshostingVerify.urlVerifyCode + "?verify_id=" + verifyId + "&verify_code=" + verifyCode
            
            var request = URLRequest(url: URL(string: url)!)
            request.httpMethod = "GET"
            
            
            let task = session.dataTask(with: request) { data, response, error in
                
                if(error == nil){
                    
                    if(data != nil){
                        let responseJSON = try? JSONSerialization.jsonObject(with: data!, options: [])
                        if let responseJSON = responseJSON as? [String: Any] {
                            completion(responseJSON)
                        }
                    }
                    else{
                        
                        completion(SmshostingVerify.handleRequestErrors(response: response, data: data, error: error))
                        
                    }
                    
                }else{
                    completion(SmshostingVerify.handleRequestErrors(response: response, data: data, error: error))
                }
                
            }
            task.resume()
            
            
            
        }
        else{
            
            completion(SmshostingVerify.handleNoCredentials())
            
        }
        
    }
    
    public static func getCountryCodes( completion: @escaping (_ result: [[String:Any]]) -> Void) {
        //Get Country Codes
        
        
        let url:String = SmshostingVerify.countryCodesList
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        
        let session = URLSession(configuration: .default)
        
        print(session.configuration.timeoutIntervalForResource)
        
        let task = session.dataTask(with: request) { data, response, error in
            
            if(error == nil){
                
                if(data != nil){
                    let responseJSON = try? JSONSerialization.jsonObject(with: data!, options: [])
                    if let responseJSON = responseJSON as? [[String: Any]] {
                        completion(responseJSON)
                    }
                }
                else{
                    
                    let responseJSON = try? JSONSerialization.jsonObject(with: countryCodes.data(using: .utf8)! , options: [])
                    if let responseJSON = responseJSON as? [[String: Any]] {
                        completion(responseJSON)
                    }
                    
                }
                
            }else{
                let responseJSON = try? JSONSerialization.jsonObject(with: countryCodes.data(using: .utf8)! , options: [])
                if let responseJSON = responseJSON as? [[String: Any]] {
                    completion(responseJSON)
                }
            }
            
        }
        task.resume()
        
    }
    
    public static func handleRequestErrors(response:URLResponse?, data:Data?, error:Error?) -> [String:Any]{
        
        var errorDict:[String:Any] = [:]
        
        if(data != nil){
            let responseJSON = try? JSONSerialization.jsonObject(with: data!, options: [])
            
            if(responseJSON != nil){
                errorDict = responseJSON as! [String : Any]
            }
        }
        
        if(errorDict["errorCode"] == nil){
            errorDict["errorCode"] = -1
            
            let httpResponse = response as? HTTPURLResponse
            if( httpResponse != nil && httpResponse?.statusCode != nil ){
                errorDict["errorCode"] = httpResponse?.statusCode
            }
            
        }
        
        if(errorDict["errorMsg"] == nil){
            errorDict["errorMsg"] = "Generic Error"
        }
        
        if(error != nil){
            errorDict["errorObj"] = error
        }
        
        let errorCode:String = String(format:"%d",errorDict["errorCode"] as! Int)
        let errorMsg:String = String(format:"%@",errorDict["errorMsg"] as! String)
        print("SmshostingVerify-Log: Request Error " + errorCode + " " + errorMsg)

        return errorDict
    }
    
    public static func handleNoCredentials() -> [String:Any]{
        print("SmshostingVerify-Log: Set key and secret with method \"startWithKeyAndSecret\"")
        
        var errorDict:[String:Any] = [:]
        errorDict["errorCode"] = -1
        errorDict["errorMsg"] = "Set key and secret with method \"startWithKeyAndSecret\""
        
        return errorDict
    }
    
}
