//
//  doneListCon.swift
//  TodoApp
//
//  Created by t2023-m0078 on 2023/08/08.
//

import UIKit


class doneListCon: UIViewController{
    
    
    @IBOutlet weak var doneListView: UITableView!
    override func viewDidLoad() {
        clearList = []
        for i in dataList{
            if i.isDone == true {
                clearList.append(i)
            }
        }
        
        super.viewDidLoad()
        
        
        
        let myTableViewCellNib = UINib(nibName: "myTableViewCell", bundle: nil)
        
        self.doneListView.register(myTableViewCellNib, forCellReuseIdentifier: "MyTableViewCell")
        
        self.doneListView.rowHeight = UITableView.automaticDimension
        
        self.doneListView.delegate = self
        self.doneListView.dataSource = self

        
    }
}


extension doneListCon:UITableViewDelegate{
    
    
}

extension doneListCon:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clearList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = doneListView.dequeueReusableCell(withIdentifier: "MyTableViewCell", for: indexPath) as! myTableViewCell
        cell.userTitle.text = clearList[indexPath.row].title
        cell.userContent.text = clearList[indexPath.row].content
        
        return cell
        
    }

    
    
}
