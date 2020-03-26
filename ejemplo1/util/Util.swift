//
//  Util.swift
//  ejemplo1
//
//  Created by Jeferson Cieza on 3/26/20.
//  Copyright © 2020 Jeferson Cieza. All rights reserved.
//

import Foundation
import UIKit

class Util {
    
    static func showAlert(_ viewController: UIViewController, _ title: String, _ message: String, _ actionTitle: String, _ handler: @escaping(UIAlertAction?) -> ()) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: actionTitle, style: UIAlertAction.Style.default, handler: handler))
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    static func showAlert(_ viewController: UIViewController, _ title: String, _ message: String, _ actionTitle: String, _ handler: @escaping(UIAlertAction?) -> (), _ handler2: @escaping(UIAlertAction?) -> ()) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: actionTitle, style: UIAlertAction.Style.cancel, handler: handler))
        alertController.addAction(UIAlertAction(title: "Eliminar", style: .destructive, handler: handler2))
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    static func showAlertYesNo(_ viewController: UIViewController, _ title: String, _ message: String, _ actionTitle: String, _ handler: @escaping (UIAlertAction?) -> (), _ handler2: @escaping (UIAlertAction?) -> ()) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: actionTitle, style: UIAlertAction.Style.default, handler: handler))
        alertController.addAction(UIAlertAction(title: "No", style: .cancel, handler: handler2))
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    static func showAlert(_ viewController: UIViewController, _ title: String, _ message: String, _ actionTitle: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: actionTitle, style: UIAlertAction.Style.default, handler: nil))
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    static func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    static func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    static func increaseDays(_ date: Date, _ quantity: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: quantity, to: date)!
    }
    
    static func increaseHours(_ date: Date, _ quantity: Int) -> Date {
        return Calendar.current.date(byAdding: .hour, value: quantity, to: date)!
    }
    
    static func isSunday(_ date: Date) -> Bool {
        let day = dayOfWeek(date)
        return day == 1
    }
    
    static func isSaturday(_ date: Date) -> Bool {
        let day = dayOfWeek(date)
        return day == 7
    }
    
    static func getDay(_ date: Date) -> Int {
        return Calendar.current.component(.day, from: date)
    }
    
    static func getDay(_ date: String) -> Int {
        let start = String.Index(encodedOffset: 8)
        let end = String.Index(encodedOffset: 10)
        return Int(String(date[start..<end]))!
    }
    
    static func getMonth(_ date: Date) -> Int {
        return Calendar.current.component(.month, from: date)
    }
    
    static func getDayMonth(_ date: Date) -> Int {
        return Calendar.current.component(.day, from: date)
    }
    
    static func getMonth(_ date: String) -> Int {
        let start = String.Index(encodedOffset: 5)
        let end = String.Index(encodedOffset: 7)
        return Int(String(date[start..<end]))!
    }
    
    static func getYear(_ date: Date) -> Int {
        return Calendar.current.component(.year, from: date)
    }
    
    static func getHour(_ date: Date) -> Int {
        return Calendar.current.component(.hour, from: date)
    }
    
    static func getHour24Format(_ date: Date) -> Int {
        let str = getActualHourAnyFormat(date)
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale?
        
        let d = formatter.date(from: str)
        
        return Calendar.current.component(.hour, from: d!)
    }
    
    static func getMinute(_ date: Date) -> Int {
        return Calendar.current.component(.minute, from: date)
    }
    
    static func dayOfWeek(_ date: Date) -> Int {
        return Calendar.current.dateComponents([.weekday], from: date).weekday!
    }
    
    static func formatDate(_ milliseconds: Int) -> String {
        let date = Date(milliseconds: milliseconds)
        let dayTxt = switchDayText(dayOfWeek(date))
        let dayMonth = getDayMonth(date)
        let monthTxt = switchMonthText(getMonth(date))
        let year = getYear(date)
        
        return "\(dayTxt) \(dayMonth) de \(monthTxt), \(year)"
    }
    
    static func formatDate(_ date: Date) -> String {
        let dayTxt = switchDayText(dayOfWeek(date))
        let dayMonth = getDayMonth(date)
        let monthTxt = switchMonthText(getMonth(date))
        
        let increased = increaseHours(date, 2)

        return "\(dayTxt) \(dayMonth) de \(monthTxt) \(getActualHourAnyFormat(date)) - \(getActualHourAnyFormat(increased))"
    }
    
    private static func getActualHourAnyFormat(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale?
        
        return formatter.string(from: date)
    }
    
    static func getActualDate(_ date: Date) -> String {
        return "\(getMonth(date))/\(getDayMonth(date))/\(getYear(date)) \(getHour(date)):\(getMinute(date))"
    }
    
    static func substring(_ str: String, _ start: Int, _ end: Int) -> String {
        let start = String.Index(encodedOffset: start)
        let end1 = String.Index(encodedOffset: end)
        return String(str[start..<end1])
    }
    
    static func getCode(_ date: Date) -> String {
        let day = dayOfWeek(date)
        return switchDay(day)
    }
    
    static func switchDayText(_ day: Int) -> String {
        switch day {
        case 1:
            return "Domingo"
        case 2:
            return "Lunes"
        case 3:
            return "Martes"
        case 4:
            return "Miércoles"
        case 5:
            return "Jueves"
        case 6:
            return "Viernes"
        case 7:
            return "Sábado"
        default:
            return ""
        }
    }
    
    static func switchMonthText(_ month: Int) -> String {
        switch month {
        case 1:
            return "Enero"
        case 2:
            return "Febrero"
        case 3:
            return "Marzo"
        case 4:
            return "Abril"
        case 5:
            return "Mayo"
        case 6:
            return "Junio"
        case 7:
            return "Julio"
        case 8:
            return "Agosto"
        case 9:
            return "Setiembre"
        case 10:
            return "Octubre"
        case 11:
            return "Noviembre"
        case 12:
            return "Diciembre"
        default:
            return ""
        }
    }
    
    static func switchDay(_ day: Int) -> String {
        switch day {
        case 1:
            return "DO"
        case 2:
            return "LU"
        case 3:
            return "MA"
        case 4:
            return "MI"
        case 5:
            return "JU"
        case 6:
            return "VI"
        case 7:
            return "SA"
        default:
            return ""
        }
    }
}
