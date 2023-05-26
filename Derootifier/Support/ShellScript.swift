//
//  ShellScript.swift
//  Derootifier
//
//  Created by Анохин Юрий on 15.04.2023.
//

import AuxiliaryExecute
import UIKit

func repackDeb(scriptPath: String, debURL: URL) -> String {
    var output = ""
    let command = "/var/jb/usr/bin/dash"
    let env = ["PATH": "/var/jb/usr/bin:$PATH"]
    let args = [scriptPath, debURL.path]

    let receipt = AuxiliaryExecute.spawn(command: command, args: args, environment: env, output: { output += $0 })

    if receipt.exitCode != 0 {
        UIApplication.shared.alert(title: "Error", body: "Failed to start the script. This is a common issue because you might have installed the app without entitlements, please re-install the app with TrollStore and try again. \(command) \(args)")
    }

    return output
}

func folderCheck() {
    do {
        if FileManager.default.fileExists(atPath: "/var/mobile/.Derootifier") {
            print("We're good! :)")
        } else {
            try FileManager.default.createDirectory(atPath: "/var/mobile/.Derootifier", withIntermediateDirectories: true)
        }
    } catch {
        UIApplication.shared.alert(title: "Error!", body: "There was a problem with making the folder for the deb. Maybe you are using palera1n which doesn't have /var/jb folder.", withButton: false)
    }
}

func checkFileMngrs() {
    if UIApplication.shared.canOpenURL(URL(string: "filza://")!) {
        UIApplication.shared.open(URL(string: "filza:///var/mobile/.Derootifier")!)
    } else {
        if UIApplication.shared.canOpenURL(URL(string: "santander://")!) {
            UIApplication.shared.open(URL(string: "santander:///var/mobile/.Derootifier")!)
        } else {
            UIApplication.shared.alert(title: "Aw... :(", body: "We didn't find any file managers which we can use to open the directory with the converted .deb file!", withButton: true)
        }
    }
}
