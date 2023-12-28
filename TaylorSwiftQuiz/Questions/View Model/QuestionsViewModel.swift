//
//  QuestionsViewModel.swift
//  TaylorSwiftQuiz
//
//  Created by Guilherme Viana on 28/12/2023.
//

import UIKit

class QuestionsViewModel {
    public var easyquestions = Questions(questions: ["do you know this is the first easy question?",
                                              "do you know this is the second easy question",
                                              "do you know this is the third easy question?",
                                              "do you know this is the fourth easy question",
                                              "do you know this is the fifth easy question?",
                                              "do you know this is the sixth easy question",
                                              "do you know this is the seventh easy question?",
                                              "do you know this is the eighty easy question",
                                              "do you know this is the ninety easy question?",
                                              "do you know this is the tenth easy question"],
                                  option1: ["1 - this is the first easy answer",
                                            "1 - this is the second easy answer",
                                            "1 - this is the third easy answer",
                                            "1 - this is the fourth easy answer",
                                            "1 - this is the fifth easy answer",
                                            "1 - this is the sixty easy answer",
                                            "1 - this is the seventh easy answer",
                                            "1 - this is the eighty easy answer",
                                            "1 - this is the ninety easy answer",
                                            "1 - this is the tenth easy answer"],
                                  option2: ["2 - this is the first easy answer",
                                            "2 - this is the second easy answer",
                                            "2 - this is the third easy answer",
                                            "2 - this is the fourth easy answer",
                                            "2 - this is the fifth easy answer",
                                            "2 - this is the sixty easy answer",
                                            "2 - this is the seventh easy answer",
                                            "2 - this is the eighty easy answer",
                                            "2 - this is the ninety easy answer",
                                            "2 - this is the tenth easy answer"],
                                  option3: ["3 - this is the first easy answer",
                                            "3 - this is the second easy answer",
                                            "3 - this is the third easy answer",
                                            "3 - this is the fourth easy answer",
                                            "3 - this is the fifth easy answer",
                                            "3 - this is the sixty easy answer",
                                            "3 - this is the seventh easy answer",
                                            "3 - this is the eighty easy answer",
                                            "3 - this is the ninety easy answer",
                                            "3 - this is the tenth easy answer"],
                                  correct: ["1 - this is the first easy answer",
                                            "2 - this is the second easy answer",
                                            "3 - this is the third easy answer",
                                            "2 - this is the fourth easy answer",
                                            "3 - this is the fifth easy answer",
                                            "1 - this is the sixty easy answer",
                                            "1 - this is the seventh easy answer",
                                            "3 - this is the eighty easy answer",
                                            "2 - this is the ninety easy answer",
                                            "1 - this is the tenth easy answer"])
    
    public func getQuestions(index: Int) -> String {
        return easyquestions.questions[index]
    }
    
    public func getAnswer1(index: Int) -> String {
        return easyquestions.option1[index]
    }
    
    public func getAnswer2(index: Int) -> String {
        return easyquestions.option2[index]
    }
    
    public func getAnswer3(index: Int) -> String {
        return easyquestions.option3[index]
    }
    
    public func checkAnswer(index: Int) -> Bool {
        if TemporaryDataStorage.shared.currentOption == easyquestions.correct[index] {
            return true
        } else {
            return false
        }
    }
}
