//: [Previous](@previous)
import Foundation

/*
 { "menu": {
        "id": "file",
        "value": "File",
        "popup": {
            "menuitem": [
                {"value": "New", "onClick": "CreateNewDoc()"}
                {"value": "Open", "onClick": "openDoc()"}
                {"value": "Close", "onClick": "closeDoc()"}
            ]
        }
    }
 }
 */
let jsonString = "{\"menu\": {" +
    "\"id\": \"file\"," +
    "\"value\": \"File\"," +
    "\"popup\": {" +
        "\"menuitem\": [" +
            "{\"value\": \"New\", \"onclick\": \"CreateNewDoc()\"}," +
            "{\"value\": \"Open\", \"onclick\": \"OpenDoc()\"}," +
            "{\"value\": \"Close\", \"onclick\": \"CloseDoc()\"}" +
            "]" +
    "}" +
"}}"
let json = try! JSONSerialization.jsonObject(with: jsonString.data(using: .utf8, allowLossyConversion: true)!, options: [])
// 访问Menu中popu中的第一个menuitem的value值
if let jsonDic = json as? NSDictionary {
    if let menu = jsonDic["menu"] as? [String: AnyObject] {
        if let popup: AnyObject = menu["popup"] {
            if let popupDic = popup as? [String: AnyObject] {
                if let menuItems: AnyObject = popupDic["menuitem"] {
                    if let menuItemsArr = menuItems as? [AnyObject] {
                        if let item0 = menuItemsArr[0]
                            as? [String: AnyObject] {
                            if let value: AnyObject = item0["value"] {
                                print(value)
                            }
                        }
                    }
                }
            }
        }
    }
}





//: [Next](@next)
