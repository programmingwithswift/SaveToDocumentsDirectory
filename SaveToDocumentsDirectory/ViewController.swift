//
//  ViewController.swift
//  SaveToDocumentsDirectory
//
//  Created by Darren Leak on 2019/12/21.
//  Copyright © 2019 ProgrammingWithSwift. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let fileName = "testFile1.txt"

        self.save(text: "Some test content to write to the file",
                  toDirectory: self.documentDirectory(),
                  withFileName: fileName)
        self.read(fromDocumentsWithFileName: fileName)
    }

    private func documentDirectory() -> String {
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                                    .userDomainMask,
                                                                    true)
        return documentDirectory[0]
    }

    private func append(toPath path: String,
                        withPathComponent pathComponent: String) -> String? {
        if var pathURL = URL(string: path) {
            pathURL.appendPathComponent(pathComponent)

            return pathURL.absoluteString
        }

        return nil
    }

    private func read(fromDocumentsWithFileName fileName: String) {
        guard let filePath = self.append(toPath: self.documentDirectory(),
                                         withPathComponent: fileName) else {
            return
        }

        do {
            let savedString = try String(contentsOfFile: filePath)

            print(savedString)
        } catch {
            print("Error reading saved file")
        }
    }

    private func save(text: String,
                      toDirectory directory: String,
                      withFileName fileName: String) {
        guard let filePath = self.append(toPath: directory,
                                         withPathComponent: fileName) else {
            return
        }

        do {
            try text.write(toFile: filePath,
                           atomically: true,
                           encoding: .utf8)
        } catch {
            print("Error", error)
            return
        }

        print("Save successful")
    }
}
