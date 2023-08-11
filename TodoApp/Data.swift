//
//  Data.swift
//  TodoApp
//
//  Created by t2023-m0078 on 2023/08/03.
//

import Foundation

var dataList:[todoCellData] = [todoCellData(title:"제목1",content:"내용1"),todoCellData(title:"제목2",content:"내용2"),todoCellData(title:"제목3",content:"내용3")]

var clearList:[todoCellData] = [todoCellData(title:"완료제목1",content:"완료내용1")]


struct todoCellData {
    var title:String
    var content:String
    
    var isDone:Bool = false
    let date = Date()
    var doneDateString:String = ""
    var dateString:String = ""
    let dateFormatter = DateFormatter()

    func setDateFormatter(){
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        
        dateFormatter.locale = Locale(identifier: "ko_KR")
    }
    
    mutating func setDate(){
        setDateFormatter()
        dateString = dateFormatter.string(from: date)
    }
    
    mutating func setDoneDate(){
        setDateFormatter()
        doneDateString = dateFormatter.string(from: Date())
    }
    
    var index:IndexPath = [0]
    
    
}
