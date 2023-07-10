import Cocoa

class DragAndDropView: NSView {
    
    private var fileTypeIsOk = false
    private var droppedFilePath: String?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.wantsLayer = true
        self.layer?.backgroundColor = NSColor.gray.cgColor
        
        registerForDraggedTypes([NSPasteboard.PasteboardType.fileURL])
    }
    
    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        if checkExtension(sender) == true {
            self.layer?.backgroundColor = NSColor.blue.cgColor
            fileTypeIsOk = true
            return .copy
        } else {
            self.layer?.backgroundColor = NSColor.red.cgColor
            fileTypeIsOk = false
            return NSDragOperation()
        }
    }
    
    override func draggingExited(_ sender: NSDraggingInfo?) {
        self.layer?.backgroundColor = NSColor.gray.cgColor
    }
    
    override func prepareForDragOperation(_ sender: NSDraggingInfo) -> Bool {
        return fileTypeIsOk
    }
    
    override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
        self.layer?.backgroundColor = NSColor.gray.cgColor
        if let board = sender.draggingPasteboard.propertyList(forType: NSPasteboard.PasteboardType.fileURL) as? NSArray,
           let filePath = board[0] as? String {
            droppedFilePath = filePath
            
            // Handle the dropped file
            handleFileDropped(filePath)
            return true
        }
        return false
    }
    
    fileprivate func checkExtension(_ drag: NSDraggingInfo) -> Bool {
        if let board = drag.draggingPasteboard.propertyList(forType: NSPasteboard.PasteboardType.fileURL) as? NSArray,
           let path = board[0] as? String {
            let url = URL(fileURLWithPath: path)
            return url.pathExtension == "csv"
        }
        return false
    }
    
    fileprivate func handleFileDropped(_ filePath: String) {
        // Handle the dropped CSV file
        // Parse the CSV and calculate the "result" column, then display the result
    }
}
