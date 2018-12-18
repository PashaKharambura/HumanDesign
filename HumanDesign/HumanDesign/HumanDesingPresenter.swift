//
//  HumanDesingPresenter.swift
//  HumanDesign
//
//  Created by Pavlo Kharambura on 12/18/18.
//  Copyright © 2018 Pavlo Kharambura. All rights reserved.
//

import Foundation

enum PickerDataType {
    case Day
    case Month
    case Year
    case Time
    case Country
    case City
    case Approximately
}

class HumanDesignPresenter {

    var dataSource = HumanDesignDataSource()
    private var pickerType: PickerDataType = .Day
    
    func getPickerType() -> PickerDataType {
        return pickerType
    }
    func setPickerType(type: PickerDataType) {
        pickerType = type
    }
    func getDataForPicker() -> [String] {
        var data: [String] = []
        
        switch pickerType {
        case .Day:
            data = dataSource.getDays().map {"\($0)"}
        case .Country:
            data = dataSource.getContries()
        case .City:
            if dataSource.getUser().country == "Украина" {
                data = dataSource.getUaPlaces()
            } else {
                data = dataSource.getRuPlaces()
            }
        case .Month:
            data = dataSource.getMonths()
        case .Year:
            data = dataSource.getYears().map {"\($0)"}
        case .Approximately:
            data = dataSource.getApproximately()
        case .Time:
            data = dataSource.getTime()
        }
        return data
    }
    func setDataFromPicker(index: Int) {
        var data = String()
        switch pickerType {
        case .Day:
            data = dataSource.getDays().map {"\($0)"}[index]
            dataSource.setDay(day: Int(data)!)
        case .Country:
            data = dataSource.getContries()[index]
            dataSource.setCountry(country: data)
        case .City:
            if dataSource.getUser().country == "Украина" {
                data = dataSource.getUaPlaces()[index]
            } else {
                data = dataSource.getRuPlaces()[index]
            }
            dataSource.setCity(city: data)
        case .Month:
            dataSource.setMonth(month: index)
        case .Year:
            dataSource.setYear(year: dataSource.getYears()[index])
        case .Approximately:
            data = dataSource.getApproximately()[index]
            let array = data.components(separatedBy: ":")
            dataSource.setHour(hour: Int(array.first ?? "0")!)
            dataSource.setMinute(min: Int(array.last ?? "0")!)
        case .Time:
            data = dataSource.getTime()[index]
            let array = data.components(separatedBy: ":")
            dataSource.setHour(hour: Int(array.first ?? "0")!)
            dataSource.setMinute(min: Int(array.last ?? "0")!)
        }
        
    }
    func getCountForPicker() -> Int {
        
        return getDataForPicker().count
    }
    
}

class HumanDesignDataSource {
    
    private var user = UserModel()
    
    func getUser() -> UserModel {
        return user
    }
    
    func setDay(day: Int) {
        user.birthDay = day
    }
    func setMonth(month: Int) {
        user.birthMonth = month
    }
    func setYear(year: Int) {
        user.birthYear = year
    }
    func setHour(hour: Int) {
        user.birthHour = hour
    }
    func setMinute(min: Int) {
        user.birthMinute = min
    }
    func setCountry(country: String) {
        user.country = country
    }
    func setCity(city: String) {
        user.city = city
    }
    
    func getYears() -> [Int] {
        var years = [Int]()
        for i in 1930...2018 {
            years.append(i)
        }
        return years
    }
    func getDays() -> [Int] {
        var days = [Int]()
        for i in 1...31 {
            days.append(i)
        }
        return days
    }
    func getMonths() -> [String] {
        return ["Январь", "Февраль", "Март", "Апрель", "Май", "Июнь", "Июль", "Август", "Сентябрь", "Октябрь", "Ноябрь", "Декабрь"]
    }
    func getContries() -> [String] {
        return ["Украина", "Россия"]
    }
    func getUaPlaces() -> [String] {
        return CityManager.ukrainianPlaces.map {"(UTC:+2)-\($0)"}
    }
    func getRuPlaces() -> [String] {
        var data = [String]()
        for item in CityManager.russianPlaces {
            let places = item.value.map {"(UTC:+\(item.key)-\($0)"}
            data.append(contentsOf: places)
        }
        return data
    }
    func getApproximately() -> [String] {
        return ["03:00", "09:00", "15:00", "21:00"]
    }
    func getTime() -> [String] {
        var data: [String] = []
        let hours = ["00","01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23"]
        let minutes = ["00","05","10","15","20","25","30","35","40","45","50","55"]
        for hour in hours {
            for minute in minutes {
                data.append(hour+":"+minute)
            }
        }
        return data
    }
    
}

class CityManager {
    
    static let russianPlaces = [
        "2": ["Калининградская область"],
        "3": ["города федерального значения Москва", "Санкт-Петербург", "Севастополь", "Республика Адыгея", "Республика Дагестан", "Республика Ингушетия", "Кабардино-Балкарская Республика", "Республика Калмыкия", "Республика Крым", "Карачаево-Черкесская Республика", "Республика Карелия", "Республика Коми", "Республика Марий Эл", "Республика Мордовия", "Республика Северная Осетия — Алания", "Республика Татарстан", "Чеченская республика", "Чувашская республика", "Краснодарский край", "Ставропольский край", "Архангельская область", "Астраханская область", "Белгородская область", "Брянская область", "Владимирская область", "Волгоградская область", "Вологодская область", "Воронежская область", "Ивановская область", "Калужская область", "Кировская область", "Костромская область", "Курская область", "Ленинградская область", "Липецкая область", "Московская область", "Мурманская область", "Нижегородская область", "Новгородская область", "Орловская область", "Пензенская область", "Псковская область", "Ростовская область", "Рязанская область", "Саратовская область", "Смоленская область", "Тамбовская область", "Тверская область", "Тульская область", "Ульяновская область", "Ярославская область", "Ненецкий автономный округ"],
        "4": ["Самарская область", "Республика Удмуртия"],
        "5": ["Республика Башкортостан", "Пермский край", "Курганская область", "Оренбургская область", "Свердловская область", "Тюменская область", "Челябинская область", "Ямало-Ненецкий автономный округ"],
        "6": ["Республика Алтай", "Алтайский край", "Новосибирская область", "Омская область", "Томская область"],
        "7": ["Республика Тыва", "Республика Хакасия", "Красноярский край", "Кемеровская область"],
        "8": ["Республика Бурятия", "Забайкальский край", "Иркутская область"],
        "9": ["часть Республики Саха (Якутия)", "Амурская область"],
        "10": ["Приморский край", "Хабаровский край", "Магаданская область", "Сахалинская область (кроме Северо-Курильского района)", "Еврейская автономная область"],
        "11": ["Сахалинская область (только Северо-Курильский район)"],
        "12": ["Камчатский край", "Чукотский автономный округ"]
    ]
    static let ukrainianPlaces = ["Винницкая область", "Волынская область", "Днепропетровская область", "Донецкая область", "Житомирская область", "Закарпатская область", "Запорожская область", "Ивано-Франковская область", "Киевская область", "Кировоградская область", "Курорт Буковель", "Луганская область", "Львовская область", "Николаевская область", "Одесская область", "Полтавская область", "Ровенская область", "Сумская область", "Тернопольская область", "Харьковская область", "Херсонская область", "Хмельницкая область", "Черкасская область", "Черниговская область", "Черновицкая область"]
}
