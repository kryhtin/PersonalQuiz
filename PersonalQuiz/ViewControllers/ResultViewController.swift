//
//  ResultViewController.swift
//  PersonalQuiz
//
//  Created by Dmitriy Kryhtin on 22.12.2021.
//

import UIKit

class ResultViewController: UIViewController {
  @IBOutlet weak var resultAnimalLabel: UILabel!
  @IBOutlet weak var resultAnimalText: UILabel!
  
  var answersChoosen: [Answer] = []
  var countedTypes = [AnimalType: Int]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.hidesBackButton = true
    
    result()
  }
  
  private func result() {
    let typesArray = answersChoosen.map { $0.type }
    countedTypes = [
      .cat: countMatches(array: typesArray, value: .cat),
      .dog: countMatches(array: typesArray, value: .dog),
      .turtle: countMatches(array: typesArray, value: .turtle),
      .rabbit: countMatches(array: typesArray, value: .rabbit)
    ]
    let greatest = countedTypes.max { a, b in a.value < b.value }
    guard let resultAnimal = greatest else { return }
    let animal = AnimalType.withLabel(resultAnimal.key)
    showResult(animal)
  }
  
  private func showResult(_ animal: AnimalType?) {
    guard let res = animal else { return }
    resultAnimalLabel.text = "Вы - \(res.rawValue)"
    resultAnimalText.text = res.definition
  }
  
  private func countMatches(array: [AnimalType], value: AnimalType) -> Int {
    return array.reduce(0) {
      if $1 == value { return $0 + 1 }
      return $0
    }
  }
}
