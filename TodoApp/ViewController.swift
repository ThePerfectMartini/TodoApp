//
//  ViewController.swift
//  TodoApp
//
//  Created by t2023-m0078 on 2023/07/31.
//

import UIKit

class ViewController: UIViewController{
    // 구조체 선언
    
    @IBAction func mainAddButton(_ sender: Any) {
        let PopUp = OverLayerPopUp() // 여기서 reloadData가 실행되도록
        PopUp.appear(sender: self)
        
        PopUp.callReload = {
            dataList.append(todoCellData(title: PopUp.titleField.text ?? "", content: PopUp.contentField.text ?? ""))
            self.myTableView.reloadData()
        }
        
    }
    //클래스 만들어서 관리할 것
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailPageSegue"{
            guard let vcData = segue.destination as? DetailViewController,
            let cellData = sender as? todoCellData else {return}
            vcData.titleText = cellData.title
            vcData.contentText = cellData.content
            vcData.createdDateText = cellData.dateString
            vcData.doneDateText = cellData.doneDateString
            vcData.indexPath = cellData.index
        }
    }
    

    
    
    @objc func checkBoxTapped(sender: UITapGestureRecognizer){
        guard let number = sender.view?.tag else {return}
        if dataList[number].isDone == true {
            dataList[number].isDone = false
            dataList[number].doneDateString = ""
        }else{
            dataList[number].isDone = true
            dataList[number].setDoneDate()
        }
        
        self.myTableView.reloadData()
    }
    
    
    
    
    
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let myTableViewCellNib = UINib(nibName: "myTableViewCell", bundle: nil)
        
        self.myTableView.register(myTableViewCellNib, forCellReuseIdentifier: "MyTableViewCell")
        
        self.myTableView.rowHeight = UITableView.automaticDimension
        
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.myTableView.reloadData()
    }


}









extension ViewController:UITableViewDelegate{
    
    
}

extension ViewController:UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dataList[indexPath.row].index = indexPath
        performSegue(withIdentifier: "detailPageSegue", sender: dataList[indexPath.row])
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "MyTableViewCell", for: indexPath) as! myTableViewCell
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(checkBoxTapped(sender:)))
        cell.checkBox.addGestureRecognizer(gesture)
        cell.checkBox.tag = indexPath.row
        
        
        
        
        cell.userTitle.text = dataList[indexPath.row].title
        cell.userContent.text = dataList[indexPath.row].content
        dataList[indexPath.row].setDate()
        cell.date.text = dataList[indexPath.row].dateString
        
        if dataList[indexPath.row].isDone == false {
            cell.check.isHidden = true
        }else{
            cell.check.isHidden = false
        }
        
        
        
        return cell
    }
    
    //에딧버튼 딜리트버튼 로우액션으로 추가하기
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteButton = UITableViewRowAction(style: .normal, title: "delete") {(rowAction, indexPath) in
            dataList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)

            
        }
        let editButton = UITableViewRowAction(style: .normal, title: "edit") {(rowAction, indexPath) in
            let PopUp = OverLayerPopUp() // 여기서 reloadData가 실행되도록
            PopUp.appear(sender: self)
            // 셀에서 텍스트 떼서 팝업창 텍스트에 넣기
            PopUp.titleField.text = dataList[indexPath.row].title
            PopUp.contentField.text = dataList[indexPath.row].content
            // 클로저로 데이터전달, 그리고 리로드 실행시키기
            PopUp.callReload = {
                dataList[indexPath.row].title = PopUp.titleField.text ?? ""
                dataList[indexPath.row].content = PopUp.contentField.text ?? ""
                self.myTableView.reloadData()
            }
            
            tableView.reloadRows(at: [indexPath], with: .automatic)

            
        }
        deleteButton.backgroundColor = UIColor.red
        editButton.backgroundColor = UIColor.green
        
        return[deleteButton,editButton]
    }
    
    
    
}
