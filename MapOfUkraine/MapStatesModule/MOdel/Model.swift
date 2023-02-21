//
//  Model.swift
//  MapOfUkraine
//
//  Created by Volodymyr D on 21.02.2023.
//

import UIKit

typealias States = (ukr: [UkrStates], eng: [UkrStates])

enum Choice: Equatable { case selected(Int), deselected(Int) }

struct UkrStates: Equatable {
    let id: Int
    let state: String
}

struct MockData {
    static let shared = MockData()
    
    public let states: States = ([
        .init(id: 0  , state: "Автономна Республіка Крим"),
        .init(id: 1  , state: "Автономна Республіка Крим"),
        .init(id: 2  , state: "Черкаська"),
        .init(id: 3  , state: "Чернігівська"),
        .init(id: 4  , state: "Чернівецька"),
        .init(id: 5  , state: "Дніпропетровська"),
        .init(id: 6  , state: "Донецька"),
        .init(id: 7  , state: "Івано-Франківська"),
        .init(id: 8  , state: "Харківська"),
        .init(id: 9  , state: "Херсонська"),
        .init(id: 10 , state: "Хмельницька"),
        .init(id: 11 , state: "Київ"),
        .init(id: 12 , state: "Київська"),
        .init(id: 13 , state: "Кіровоградська"),
        .init(id: 14 , state: "Луганська"),
        .init(id: 15 , state: "Львівська"),
        .init(id: 16 , state: "Миколаївська"),
        .init(id: 17 , state: "Одеська"),
        .init(id: 18 , state: "Полтавська"),
        .init(id: 19 , state: "Рівненська"),
        .init(id: 20 , state: "Сумська"),
        .init(id: 21 , state: "Тернопільська"),
        .init(id: 22 , state: "Закарпатська"),
        .init(id: 23 , state: "Вінницька"),
        .init(id: 24 , state: "Волинська"),
        .init(id: 25 , state: "Запорізька"),
        .init(id: 26 , state: "Житомирська"),
    ],[
        .init(id: 0  , state: "Autonomous Republic of Crimea"),
        .init(id: 1  , state: "Autonomous Republic of Crimea"),
        .init(id: 2  , state: "Cherkaska"),
        .init(id: 3  , state: "Chernihivska"),
        .init(id: 4  , state: "Chernivetska"),
        .init(id: 5  , state: "Dnipropetrovsk"),
        .init(id: 6  , state: "Donetsk"),
        .init(id: 7  , state: "Ivano-Frankivsk"),
        .init(id: 8  , state: "Kharkivska"),
        .init(id: 9  , state: "Khersonska"),
        .init(id: 10 , state: "Khmelnytska"),
        .init(id: 11 , state: "Kyiv"),
        .init(id: 12 , state: "Kyivska"),
        .init(id: 13 , state: "Kirovohradska"),
        .init(id: 14 , state: "Luhansk"),
        .init(id: 15 , state: "Lvivska"),
        .init(id: 16 , state: "Mykolaivska"),
        .init(id: 17 , state: "Odesa"),
        .init(id: 18 , state: "Poltavska"),
        .init(id: 19 , state: "Rivnenska"),
        .init(id: 20 , state: "Sumska"),
        .init(id: 21 , state: "Ternopilska"),
        .init(id: 22 , state: "Zakarpatska"),
        .init(id: 23 , state: "Vinnytsia"),
        .init(id: 24 , state: "Volynska"),
        .init(id: 25 , state: "Zaporizka"),
        .init(id: 26 , state: "Zhytomyrska"),
    ])
}
  
