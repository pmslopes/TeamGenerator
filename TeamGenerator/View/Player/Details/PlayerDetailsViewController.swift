//
//  PlayerDetailsViewController.swift
//  TeamGenerator
//
//  Created by CTW00169 on 09/11/2018.
//  Copyright © 2018 Le Team Software. All rights reserved.
//

import UIKit

class PlayerDetailsViewController: UIViewController {    
    @IBOutlet weak var stackView: UIStackView!
    
    var viewModel: PlayerViewModel? {
        didSet {
            fillUI()
        }
    }
    
    var playerClosure: (PlayerViewModel, UIViewController) -> () = { _,_ in }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        styleUI()
        fillUI()
    }
    
    // MARK: Private
    fileprivate func styleUI() {
        let save = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveTapped))
        navigationItem.rightBarButtonItem = save
    }
    
    fileprivate func fillUI() {
        if !isViewLoaded {
            return
        }
        
        guard let viewModel = viewModel else {
            return
        }
        
        let nameDetailView = PlayerDetailView(frame: .zero)
        
        nameDetailView.titleLabel.text = "Nome"
        nameDetailView.textField.text = viewModel.playerName
        nameDetailView.tag = 0
        stackView.addArrangedSubview(nameDetailView)
        nameDetailView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addConstraint(nameDetailView.heightConstraint())
        
        let numberDetailView = PlayerDetailView(frame: .zero)
        numberDetailView.titleLabel.text = "Número"
        numberDetailView.textField.keyboardType = .numberPad
        numberDetailView.textField.text = viewModel.playerNumber
        numberDetailView.tag = 1
        stackView.addArrangedSubview(numberDetailView)
        numberDetailView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addConstraint(numberDetailView.heightConstraint())
        
        let strengthDetailView = PlayerDetailView(frame: .zero)
        strengthDetailView.titleLabel.text = "Força"
        strengthDetailView.textField.keyboardType = .numberPad
        strengthDetailView.textField.text = viewModel.playerStrength
        strengthDetailView.tag = 2
        stackView.addArrangedSubview(strengthDetailView)
        strengthDetailView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addConstraint(strengthDetailView.heightConstraint())
    }
    
    @objc func saveTapped() {
        let nameView = stackView.arrangedSubviews.filter { (view) -> Bool in
            return view.tag == 0
            }.first
        
        let numberView = stackView.arrangedSubviews.filter { (view) -> Bool in
            return view.tag == 1
            }.first
        
        let strengthView = stackView.arrangedSubviews.filter { (view) -> Bool in
            return view.tag == 2
            }.first
        
        guard let nameDetailView = nameView as? PlayerDetailView, let numberDetailView = numberView as? PlayerDetailView, let strengthDetailView = strengthView as? PlayerDetailView else {
            return
        }
        
        viewModel?.playerName = nameDetailView.value()
        viewModel?.playerNumber = numberDetailView.value()
        viewModel?.playerStrength = strengthDetailView.value()
        
        playerClosure(viewModel!, self)
        
//        viewModel?.update(name: nameDetailView.value(), number: numberDetailView.value(), strength: strengthDetailView.value(), completion: { (player, error)  in
//            self.navigationController?.popViewController(animated: true)
//        })
    }
}
