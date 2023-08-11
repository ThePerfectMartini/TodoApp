//
//  popUp.swift
//  TodoApp
//
//  Created by t2023-m0078 on 2023/08/02.
//

import UIKit


class OverLayerPopUp: UIViewController, UIGestureRecognizerDelegate {
    
    var callReload:(() -> ()) = {}
    
    @IBAction func addButton(_ sender: Any) {
        callReload()
        hide()
    }
    
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var titleField: UITextField!
    
    @IBOutlet weak var contentField: UITextField!
    
    
    //    let gesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped(sender:))) 위치 문제였음
    
    @objc func viewTapped(sender: UITapGestureRecognizer){
        hide()
        print("call")
    }
    
    @IBOutlet weak var contentView: UIView!
    
    
    init() {
        super.init(nibName: "OverLayerPopUp", bundle: nil)
        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configView()
        
    }
    
    func configView(){
        
        //        gesture.delegate = self
        let gesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped(sender:)))
        
        self.backView.addGestureRecognizer(gesture)
        
        self.view.backgroundColor = .clear
        self.backView.backgroundColor = .black.withAlphaComponent(0.6)
        self.backView.alpha = 0
        self.contentView.alpha = 0
        self.contentView.layer.cornerRadius = 10
    }
    
    func appear(sender: UIViewController) {
        sender.present(self, animated: false) {
            self.show()
        }
    }
    
    private func show(){
        UIView.animate(withDuration: 0.3, delay: 0.0){
            self.backView.alpha = 1
            self.contentView.alpha = 1
            
        }
    }
    
    func hide(){
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut){
            self.backView.alpha = 0
            self.contentView.alpha = 0
        } completion: { _ in
            self.dismiss(animated: false)
            self.removeFromParent()
        }
    }
}
