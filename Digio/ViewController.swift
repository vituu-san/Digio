//
//  ViewController.swift
//  Digio
//
//  Created by Vitor Costa on 27/08/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        let service = SandboxService()

        service.fetchSandbox { result in
            switch result {
            case .success(let sandbox):
                print("Success: ", sandbox)
            case .failure(let error):
                print("Failure: ", error.localizedDescription)
            }
        }
    }


}

