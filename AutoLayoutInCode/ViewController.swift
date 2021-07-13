//
//  ViewController.swift
//  AutoLayoutInCode
//
//  Created by Atin Agnihotri on 13/07/21.
//

import UIKit

class ViewController: UIViewController {
    
    var labelViewDictionary = [String: UILabel]()
    let labels = ["THESE", "ARE", "SOME", "AWESOME", "LABELS"]
    let labelColorDictionary: Dictionary<String, UIColor> = [
        "THESE": .red,
        "ARE": .cyan,
        "SOME": .yellow,
        "AWESOME": .orange,
        "LABELS": .green,
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        createUI()
        
    }
    
    func createUI() {
        createAllLabels()
        addConstraintsToLabels()
    }
    
    func createAllLabels() {
//        print("START CREATING LABEL")
        var indx = 1
        for indx in 0..<labels.count {
            let label = labels[indx]
//            print(label)
            createLabel(index: indx+1, text: label, color: labelColorDictionary[label] ?? .black)
        }
//        print("END CREATING LABEL")
    }
    
    func createLabel(index: Int, text: String, color: UIColor) {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = color
        label.text = text
        label.sizeToFit()
        view.addSubview(label)
        labelViewDictionary["label\(index)"] = label
    }
    
    func addConstraintsToLabels() {
        var previousUILabel: UILabel?
        
        for indx in 0..<labels.count {
            let uiLabel = labelViewDictionary["label\(indx+1)"]
//            uiLabel?.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
            uiLabel?.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
            uiLabel?.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
//            uiLabel?.heightAnchor.constraint(greaterThanOrEqualToConstant: (view.frame.height / 5) - 10).isActive = true
            uiLabel?.heightAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.2, constant: -10).isActive = true
            
            if let previousLabel = previousUILabel {
                uiLabel?.topAnchor.constraint(equalTo: previousLabel.bottomAnchor, constant: 10).isActive = true
                uiLabel?.heightAnchor.constraint(equalTo: previousLabel.heightAnchor).isActive = true
            } else {
                uiLabel?.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            }
            previousUILabel = uiLabel
        }
        
        if let last = previousUILabel {
            last.bottomAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 10).isActive = true
        }
//        addHorizontalConstraints()
//        addVerticalConstraints()
    }
    
    func addHorizontalConstraints() {
        for eachKey in labelViewDictionary.keys {
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[\(eachKey)]|", options: [], metrics: nil, views: labelViewDictionary))
        }
    }
    
    func addVerticalConstraints() {
        let metrics = ["labelHeight": 88]
        var vfl = "V:|-"
        for indx in 0..<labels.count {
            if indx == 0 { vfl += "[label\(indx+1)(labelHeight@999)]-" }
            else { vfl += "[label\(indx+1)(label1)]-" }
        }
        vfl += "(>=10)-|"
//        vfl = vfl.trimmingCharacters(in: CharacterSet(charactersIn: "-"))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: vfl, options: [], metrics: metrics, views: labelViewDictionary))
    }


}

