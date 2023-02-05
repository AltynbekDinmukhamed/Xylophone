//
//  ViewController.swift
//  Xylophone
//
//  Created by Димаш Алтынбек on 29.01.2023.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    //MARK: -Views-
    let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    var player = AVAudioPlayer()
    
    //MARK: -Life cycle-
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        makeButtons()
    }

    //MARK: -functions-
    private func setUpView() {
        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stack.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            
        ])
    }
    
    private func makeButtons() {
        let buttons = ["C", "D", "E", "F", "G", "A", "B"]
        let width = view.frame.width
        print(buttons.indices)
        for i in buttons.indices {
            let label = buttons[i]
            let button: UIButton = {
                let button = UIButton()
                button.titleLabel?.font = .systemFont(ofSize: 30)
                button.backgroundColor = UIColor.init(named: label)
                button.setTitle(label, for: .normal)
                button.layer.cornerRadius = 5
                print(CGFloat(i))
                button.widthAnchor.constraint(equalToConstant: width * (1 - CGFloat(i + 3) * 0.035)).isActive = true
                button.translatesAutoresizingMaskIntoConstraints = false
                button.addTarget(self, action: #selector(didTapApp), for: .touchUpInside)
                return button
            }()
            stack.addArrangedSubview(button)
        }
    }
    
    func playMusic(_ title: String) {
        guard let url = Bundle.main.url(forResource: title, withExtension: "wav") else { return }
        player = try! AVAudioPlayer(contentsOf: url)
        player.play()
    }
    
    @objc func didTapApp(_ sender: UIButton) {
        if let title = sender.currentTitle { playMusic(title)}
    }
}

