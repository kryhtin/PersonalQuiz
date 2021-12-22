//
//  Question.swift
//  PersonalQuiz
//
//  Created by brubru on 16.12.2021.
//

struct Question {
  let title: String
  let type: ResponseType
  let answers: [Answer]
  
  static func getQuestions() -> [Question] {
    [
      Question(
        title: "Какую пищу предпочитаете?",
        type: .single,
        answers: [
          Answer(title: "Стейк", type: .dog),
          Answer(title: "Рыба", type: .cat),
          Answer(title: "Морковь", type: .rabbit),
          Answer(title: "Кукуруза", type: .turtle)
        ]
      ),
      Question(
        title: "Что вам нравиться больше?",
        type: .multiple,
        answers: [
          Answer(title: "Плавать", type: .dog),
          Answer(title: "Спать", type: .cat),
          Answer(title: "Обниматься", type: .rabbit),
          Answer(title: "Есть", type: .turtle)
        ]
      ),
      Question(
        title: "Любите ли вы поездки на машине?",
        type: .ranged,
        answers: [
          Answer(title: "Ненавижу", type: .cat),
          Answer(title: "Нервничаю", type: .rabbit),
          Answer(title: "Не замечаю", type: .turtle),
          Answer(title: "Обожаю", type: .dog)
        ]
      )
    ]
  }
}

enum ResponseType {
  case single
  case multiple
  case ranged
}

struct Answer {
  let title: String
  let type: AnimalType
}

enum AnimalType: Character, CaseIterable {
  case dog = "🐶"
  case cat = "🐱"
  case rabbit = "🐰"
  case turtle = "🐢"
  
  var definition: String {
    switch self {
      case .dog:
        return "Вам нравится быть с друзьями. Вы окружаете себя людьми, которые вам нравяться и всегда готовы помочь."
      case .cat:
        return "Вы себе на уме. Любите гулять сами по себе. Вы цените одиночество."
      case .rabbit:
        return "Вам нравится все мягкое. Вы здоровы и полны энергии."
      case .turtle:
        return "Ваша сила - в мудрости. Медленный и вдумчивый выигрывает на больших дистанциях."
    }
  }
  
  static func withLabel(_ label: AnimalType) -> AnimalType? {
    return self.allCases.first{ $0 == label }
  }
}

