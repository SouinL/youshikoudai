//
//  DataModel.swift
//  LWY
//
//  Created by ant on 2018/5/24.
//  Copyright © 2018年 com.cornerant. All rights reserved.
//

import UIKit
import SwiftyJSON

class DataModel: NSObject {

    var image : String!
    var text  : String!
 
    class func loadDataModels(data:Any) -> [DataModel]{
        let json = JSON(data)
        var dataModels = [DataModel]()
        for (_,subJson):(String, JSON) in json{
            let dataModel = DataModel()
            
            dataModel.image = subJson["image"].stringValue
            dataModel.text = subJson["text"].stringValue
            dataModels.append(dataModel)
            
        }
        
        return dataModels
    }


}
