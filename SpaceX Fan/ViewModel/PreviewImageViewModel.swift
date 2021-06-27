//
//  PreviewImageViewModel.swift
//  SpaceX Fan
//
//  Created by iOS Dev on 27/06/21.
//

import UIKit

class PreviewImageViewModel: NSObject {

    ///Images strings list, this is to download and show the images in a list
    public var imagesList : [String]?
    
    ///SelectedIndex is to move to the perticular index to show the exact image what we selected ti see in full screen
    public var selectedIndex : Int?
    
}
