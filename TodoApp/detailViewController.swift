//
//  detailViewController.swift
//  TodoApp
//
//  Created by t2023-m0078 on 2023/08/09.
//

import UIKit


class DetailViewController: UIViewController{
    
    @IBOutlet weak var navBar: UINavigationItem!
    
    @IBOutlet weak var doneTimeLabel: UILabel!
    

    var titleText:String?
    var contentText:String?
    var createdDateText:String?
    var doneDateText:String?
    var indexPath:IndexPath?
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var createdDateLabel: UILabel!
    
    @IBOutlet weak var doneDateLabel: UILabel!
    
    func drawView(){
        navBar.title = titleText
        contentLabel.text = contentText
        createdDateLabel.text = createdDateText
        doneDateLabel.text = doneDateText
        
        if doneDateText == "" {
            doneTimeLabel.isHidden = true
            doneDateLabel.isHidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawView()

    }

    
    
    @IBAction func editButton(_ sender: Any) {
        let PopUp = OverLayerPopUp() // 여기서 reloadData가 실행되도록
        PopUp.appear(sender: self)
        // 셀에서 텍스트 떼서 팝업창 텍스트에 넣기
        PopUp.titleField.text = dataList[indexPath?.row ?? 0].title
        PopUp.contentField.text = dataList[indexPath?.row ?? 0].content
        // 클로저로 데이터전달, 그리고 리로드 실행시키기
        PopUp.callReload = { [self] in
            dataList[indexPath?.row ?? 0].title = PopUp.titleField.text ?? ""
            dataList[indexPath?.row ?? 0].content = PopUp.contentField.text ?? ""
            titleText = dataList[indexPath?.row ?? 0].title
            contentText = dataList[indexPath?.row ?? 0].content
            drawView()
        }
    }
    
    
    @IBAction func deleteButton(_ sender: Any) {
        let alert = UIAlertController(title:"확인",message: "정말 삭제하시겠습니까?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "네", style: .destructive, handler: {_ in
            print("네")
            dataList.remove(at: self.indexPath?.row ?? 0)
            self.navigationController?.popViewController(animated: true)
        }))
        alert.addAction(UIAlertAction(title: "아니오", style: .cancel, handler: {_ in print("아니오")}))
        
        present(alert, animated: true)
        

    }
    
    
    
    
    
    
}
