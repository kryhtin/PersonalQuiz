//
//  QuestionViewController.swift
//  PersonalQuiz
//
//  Created by Dmitriy Kryhtin on 22.12.2021.
//

import UIKit

class QuestionViewController: UIViewController {
  @IBOutlet weak var questionLabel: UILabel!
  
  @IBOutlet weak var singleStackView: UIStackView!
  @IBOutlet var singleButtons: [UIButton]!
  
  @IBOutlet weak var multipleStackView: UIStackView!
  @IBOutlet var multipleLabels: [UILabel]!
  @IBOutlet var multipleSwitches: [UISwitch]!
  
  @IBOutlet weak var rangedStackView: UIStackView!
  @IBOutlet var rangedLabels: [UILabel]!
  
  @IBOutlet weak var rangedSlider: UISlider! {
    didSet {
      let answerCount = Float(currentAnswers.count - 1)
      rangedSlider.maximumValue = answerCount
      rangedSlider.value = answerCount / 2
    }
  }
  @IBOutlet weak var questionProgressView: UIProgressView!
  
  private let questions = Question.getQuestions()
  private var questionIndex = 0
  private var answersChoosen: [Answer] = []
  private var currentAnswers: [Answer] {
    questions[questionIndex].answers
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupUI()
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let resultVC = segue.destination as? ResultViewController else { return }
    resultVC.answersChoosen = answersChoosen
  }
  
  @IBAction func sigleAnswerButtonPressed(_ sender: UIButton) {
    guard let buttonIndex = singleButtons.firstIndex(of: sender) else { return }
    
    let currentAnswer = currentAnswers[buttonIndex]
    answersChoosen.append(currentAnswer)
    
    nextQuestion()
  }
  
  @IBAction func multipleAnswerButtonPressed() {
    for (multipleSwitch, answer) in zip(multipleSwitches, currentAnswers) {
      if multipleSwitch.isOn {
        answersChoosen.append(answer)
      }
    }
    
    nextQuestion()
  }
  
  @IBAction func rangedAnswerButtonPressed() {
    let index = lrintf(rangedSlider.value)
    
    let currentAnswer = currentAnswers[index]
    answersChoosen.append(currentAnswer)
    
    nextQuestion()
  }
}

// MARK: - Private methods
extension QuestionViewController {
  private func setupUI() {
    for stackView in [singleStackView, multipleStackView, rangedStackView] {
      stackView?.isHidden = true
    }
    
    let currentQuestion = questions[questionIndex]
    questionLabel.text = currentQuestion.title
    
    let totalProgress = Float(questionIndex) / Float(questions.count)
    questionProgressView.setProgress(totalProgress, animated: true)
    
    title = "Вопрос №\(questionIndex + 1) из \(questions.count)"
    
    showCurrentAnswer(for: currentQuestion.type)
  }
  
  private func showCurrentAnswer(for type: ResponseType) {
    switch type {
      case .single:
        showSingleStackView(with: currentAnswers)
      case .multiple:
        showMultipleStackView(with: currentAnswers)
      case .ranged:
        showRangedStackView(with: currentAnswers)
    }
  }
  
  private func showSingleStackView(with answers: [Answer]) {
    singleStackView.isHidden = false
    
    for (button, answer) in zip(singleButtons, answers) {
      button.setTitle(answer.title, for: .normal)
    }
  }
  
  private func showMultipleStackView(with answers: [Answer]) {
    multipleStackView.isHidden = false
    
    for (label, answer) in zip(multipleLabels, answers) {
      label.text = answer.title
    }
  }
  
  private func showRangedStackView(with answers: [Answer]) {
    rangedStackView.isHidden = false
    
    rangedLabels.first?.text = answers.first?.title
    rangedLabels.last?.text = answers.last?.title
  }
  
  private func nextQuestion() {
    questionIndex += 1
    
    if questionIndex < questions.count {
      setupUI()
      return
    } else {
      performSegue(withIdentifier: "showResult", sender: nil)
    }
  }
}
