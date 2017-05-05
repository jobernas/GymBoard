//
//  EntrySectionHeader.swift
//  GymBoard
//
//  Created by João Luís on 04/05/17.
//  Copyright © 2017 JoBernas. All rights reserved.
//

import UIKit

protocol HandleEntries {
    func editEntries(_ date:String, index:Int)
    func deleteEntries(_ date:String, index:Int)
}

class EntrySectionHeader: UIView {
    
    @IBOutlet weak var txtTitleSection: UILabel!
    @IBOutlet weak var imgEdit: UIImageView!
    @IBOutlet weak var imgDelete: UIImageView!
    
    var handler: HandleEntries?
    var index: Int?
    
    var title: String = "" {
        didSet{
            self.txtTitleSection?.text = self.title
        }
    }

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    // MARK: - Private Helper Methods
    
    // Performs the initial setup.
    private func setupView() {
        let view = viewFromNibForClass()
        view.frame = bounds
        
        // Auto-layout stuff.
        view.autoresizingMask = [
            UIViewAutoresizing.flexibleWidth,
            UIViewAutoresizing.flexibleHeight
        ]
        
        //Add Listners
        let tapEditGesture = UITapGestureRecognizer(target: self, action: #selector(self.editEntries(gestureRecognizer:)))
        tapEditGesture.numberOfTouchesRequired = 1
        tapEditGesture.numberOfTapsRequired = 1
        self.imgEdit.addGestureRecognizer(tapEditGesture)
        
        let tapDeleteGesture = UITapGestureRecognizer(target: self, action: #selector(self.deleteEntries(gestureRecognizer:)))
        tapDeleteGesture.numberOfTouchesRequired = 1
        tapDeleteGesture.numberOfTapsRequired = 1
        self.imgDelete.addGestureRecognizer(tapDeleteGesture)
        
        // Show the view.
        addSubview(view)
    }
    
    private func viewFromNibForClass() -> UIView {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return view
    }
    
    public func editEntries(gestureRecognizer: UIGestureRecognizer) {
        print("Edit Entries")
        self.handler!.editEntries(self.title, index: self.index!)
    }
    
    public func deleteEntries(gestureRecognizer: UIGestureRecognizer) {
        print("Delete Entries")
        EntryCRUD.deleteEntriesForDate(self.title)
        self.handler!.deleteEntries(self.title, index: self.index!)
    }

}
