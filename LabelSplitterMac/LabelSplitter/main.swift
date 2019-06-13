//
//  main.swift
//  LabelSplitter
//
//  Created by Umetzu on 7/26/17.
//  Copyright © 2017 Umetzu. All rights reserved.
//

import Foundation
import Quartz

//var fileNames = ["mosaic", "gifted", "holocradle", "holoflux"]
//var fileNames = ["bell", "ball", "pet", "cradle"]
var fileNames = ["1", "2"]

let newDoc = PDFDocument()

for fileName in fileNames {
    let urlPDF = URL(string: "file:///Users/Umetzu/Downloads/" + fileName + ".pdf")!
    
    let doc = PDFDocument(url: urlPDF)!
    
    for index in 0..<doc.pageCount {
        let page = doc.page(at: index)!
        
        page.setBounds(NSRect(x:10, y:40, width:550, height:360), for: .cropBox)
        //page.setBounds(NSRect(x:10, y:50, width:565, height:370), for: .cropBox)
        
        let newPage = (page.copy() as! PDFPage)
        newPage.rotation = 90
        
        newDoc.insert(newPage, at: index * 2)
        
        page.setBounds(NSRect(x:10, y:395, width:260, height:390), for: .cropBox)
        //page.setBounds(NSRect(x:10, y:415, width:260, height:390), for: .cropBox)
        
        newDoc.insert(page.copy() as! PDFPage, at: (index * 2) + 1)
    }
}

newDoc.write(to: URL(string: "file:///Users/Umetzu/Downloads/toPrint.pdf")!)

//let operation = newDoc.printOperation(for: .shared, scalingMode: .pageScaleToFit, autoRotate: true)!
//operation.printInfo.printer = NSPrinter(name: "Zebra LP2844")!


//operation.run()

print("Done!")

//
//func write(url: URL) {
//    var infoDict = [String: AnyObject]()
//    infoDict[kCGPDFContextTitle as String] = self.title as NSString?
//    infoDict[kCGPDFContextAuthor as String] = self.author as NSString?
//    infoDict[kCGPDFContextCreator as String] = self.creator as NSString?
//    infoDict[kCGPDFContextSubject as String] = self.subject as NSString?
//
//    let anyPage = pages.last
//    var rect = anyPage?.frame ?? CGRect.zero
//    guard let pdfContext = CGContext(url as CFURL, mediaBox: &rect, infoDict as CFDictionary?) else {
//        return
//    }
//
//    for page in self.pages {
//        page.draw(pdfContext: pdfContext)
//    }
//}


//
//init? (images: [UIImage]) {
//    let pdfData = NSMutableData()
//    guard let pdfConsumer = CGDataConsumer(data: pdfData), let pdfContext = CGContext(consumer: pdfConsumer, mediaBox: nil, nil) else {
//        return nil
//    }
//
//    for image in images where image.cgImage != nil {
//        let pageWidth = image.size.width
//        let pageHeight = image.size.height
//
//        var pageRect = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight);
//        pdfContext.beginPage(mediaBox: &pageRect);
//        pdfContext.draw(image.cgImage!, in: pageRect)
//        pdfContext.endPage();
//    }
//
//    pdfContext.closePDF()
//
//    if pdfData.length == 0 {
//        return nil
//    }
//
//    self.data = pdfData as Data
//    if let provider = CGDataProvider(data: pdfData), let reference = CGPDFDocument(provider) {
//        self.reference = reference
//        updateFields()
//        return
//    }
//    return nil
//}

