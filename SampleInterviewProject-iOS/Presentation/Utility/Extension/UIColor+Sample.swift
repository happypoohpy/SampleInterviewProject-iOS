import UIKit

extension SampleExtension where Base: UIColor {

    /// #FAB613
    static var yellow: UIColor {
        return #colorLiteral(red: 0.9803921569, green: 0.7137254902, blue: 0.07450980392, alpha: 1)
    }

    /// #DDDDDD
    static var gray: UIColor {
        return #colorLiteral(red: 0.9428877234, green: 0.9430230856, blue: 0.9428581595, alpha: 1)
    }

    /// #000000
    static var black: UIColor {
        return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    /// #FFFFFF
    static var white: UIColor {
        return #colorLiteral(red: 0.9999126792, green: 1, blue: 0.9998814464, alpha: 1)
    }
}
