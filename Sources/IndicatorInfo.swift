//  IndicatorInfo.swift
//  XLPagerTabStrip ( https://github.com/xmartlabs/XLPagerTabStrip )
//
//  Copyright (c) 2017 Xmartlabs ( http://xmartlabs.com )
//
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation

public struct IndicatorInfo {

    public var title: String?
    public var attributedTitle: NSAttributedString?
    public var image: UIImage?
    public var indicatorAmount: Int?
    public var highlightedImage: UIImage?
    public var accessibilityLabel: String?
    public var userInfo: Any?
    
    public init(title: String?) {
        self.title = title
        self.accessibilityLabel = title
    }
    
    public init(image: UIImage?, highlightedImage: UIImage? = nil, userInfo: Any? = nil) {
        self.image = image
        self.highlightedImage = highlightedImage
        self.userInfo = userInfo
    }
    
    public init(title: String?, image: UIImage?, indicatorAmount: Int?, highlightedImage: UIImage? = nil, userInfo: Any? = nil) {
        self.title = title
        self.accessibilityLabel = title
        self.image = image
        self.indicatorAmount = indicatorAmount
        self.highlightedImage = highlightedImage
        self.userInfo = userInfo
    }
    
    public init(title: NSAttributedString) {
        self.attributedTitle = title
        self.accessibilityLabel = title.string
    }
    
    public init(title: String?, accessibilityLabel:String?, image: UIImage?, highlightedImage: UIImage? = nil, userInfo: Any? = nil) {
        self.title = title
        self.accessibilityLabel = accessibilityLabel
        self.image = image
        self.highlightedImage = highlightedImage
        self.userInfo = userInfo
    }

}

extension IndicatorInfo : ExpressibleByStringLiteral {

    public init(stringLiteral value: String) {
        title = value
        accessibilityLabel = value
    }

    public init(extendedGraphemeClusterLiteral value: String) {
        title = value
        accessibilityLabel = value
    }

    public init(unicodeScalarLiteral value: String) {
        title = value
        accessibilityLabel = value
    }
}

func circleAroundDigit(_ num:Int, circleColor:UIColor,
                       digitColor:UIColor, diameter:CGFloat,
                       font:UIFont) -> UIImage {
    let p = NSMutableParagraphStyle()
    p.alignment = .center
    let s = NSAttributedString(string: String(num), attributes:
        [.font:font, .foregroundColor:digitColor, .paragraphStyle:p])
    let r = UIGraphicsImageRenderer(size: CGSize(width:diameter, height:diameter))
    return r.image {con in
        circleColor.setFill()
        con.cgContext.fillEllipse(in:
            CGRect(x: 0, y: 0, width: diameter, height: diameter))
        s.draw(in: CGRect(x: 0, y: diameter / 2 - font.lineHeight / 2,
                          width: diameter, height: diameter))
    }
}

func indicatorInfoWithNotificationIndicator(notificationIndicatorAmount: Int) -> NSAttributedString {
    let fullString = NSMutableAttributedString()
    let titleFont = UIFont.systemFont(ofSize: 10, weight: .medium)
    let indicatorImage = circleAroundDigit(notificationIndicatorAmount,
                                           circleColor: UIColor(red: 245/255, green: 166/255, blue: 35/255, alpha: 1),
                                           digitColor: .white,
                                           diameter: 20,
                                           font:titleFont)
    
    let padding = NSTextAttachment()
    padding.bounds = CGRect(x: 0, y: 0, width: 5, height: 0)
    let paddingAttributedString = NSAttributedString(attachment: padding)
    
    let indicatorImageAttachment = NSTextAttachment()
    indicatorImageAttachment.image = indicatorImage
    indicatorImageAttachment.bounds = CGRect(x: 0, y: ((titleFont.capHeight - indicatorImage.size.height).rounded() / 2)+1, width: indicatorImage.size.width, height: indicatorImage.size.height)
    let indicatorImageAttributedString = NSAttributedString(attachment: indicatorImageAttachment)
    
    fullString.append(paddingAttributedString)
    fullString.append(indicatorImageAttributedString)

    return fullString
}
