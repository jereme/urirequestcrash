//
//  ViewController.swift
//  Crashomatic
//
//  Created by Jereme Claussen on 6/20/17.
//  Copyright © 2017 Jereme Claussen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var deathByAThousandCuts: UIButton?
    @IBOutlet var deathByOneCut: UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didTapDeathByAThousandCuts() {
        for _ in 0...100 {
            Crashamotron.testAFCrash()
        }
    }

    @IBAction func didTapDeathByOneCut() {
        Crashamotron.testAFCrash()
    }
}
