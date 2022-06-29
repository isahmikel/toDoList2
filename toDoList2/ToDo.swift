//
//  ToDo.swift
//  toDoList2
//
//  Created by Scholar on 6/27/22.
//

import UIKit

class ToDo {
    var name : String
    var important : Bool
    
    init ()
    {
        name = "uh oh"
        important = false
    }
    
    init (name : String, important : Bool)
    {
        self.name = name
        self.important = important
    }
}
