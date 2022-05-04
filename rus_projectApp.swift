//
//  rus_projectApp.swift
//  rus-project
//
//  Created by Evgenii Pakhomov on 14.09.2021.
//

import SwiftUI

func GetAnswers(test: Array<Word>) -> String {
    var res = "";
    for element in test {
        res += element.correct;
        res += " ";
    }
    return res;
}

func FinishTest(InProgress: inout Bool, Perc: Int, hist: inout Array<Int>) -> Void {
    InProgress = false;
    hist += [Perc];
    UserDefaults.standard.set(false, forKey: "InProgress");
    UserDefaults.standard.set(hist, forKey: "History");
}

func CalcPercentage(ok: Array<Int>) -> Int {
    var correct = 0;
    var answered = 0;
    for element in ok {
        if (element != -1) {
            correct += element;
            answered += 1;
        }
    }
    if (answered == 0) {
        return 0;
    }
    return correct * 100 / answered;
}

func restoreDefaults(InProgress: inout Bool, test: inout Array<Word>, ok: inout Array<Int>, hist: inout Array<Int>) {
    hist = UserDefaults.standard.object(forKey: "History") as? Array<Int> ?? [];
    InProgress = UserDefaults.standard.object(forKey: "InProgress") as? Bool ?? false;
    if (InProgress) {
        InProgress = true;
        test.removeAll();
        let test1 = UserDefaults.standard.object(forKey: "TestInfo") as? [Int] ?? [];
        ok = UserDefaults.standard.object(forKey: "ok") as? [Int] ?? [];
        for i in test1 {
            test.append(Words[i]);
        }
    }
}

func UpdateDefaults(InProgress: Bool, ok: Array<Int>) {
    UserDefaults.standard.set(InProgress, forKey: "InProgress");
    UserDefaults.standard.set(ok, forKey: "ok");
}

@main
struct rus_projectApp: App {
    
    @State var ShowingARule = false;
    @State var ruleId = 0;
    @State var testFinished = false;
    @State var test = Array<Word> ();
    @State var InProgress = false;
    @State var ok = Array<Int> ();
    @State var CurrentWord = -1;
    @State var hist = Array<Int> ();
    @State var showHist = false;
    @State var OnStart = true;
    var body: some Scene {
        WindowGroup {
            if (showHist) {
                showHistory(hist: $hist, showHist: $showHist);
            } else if (OnStart) {
                restore(InProgress: $InProgress, test: $test, ok: $ok, hist: $hist, OnStart: $OnStart);
            } else {
                if (!InProgress) {
                    /*  создаем новый тест  */
                    CreateTest(InProgress: $InProgress, test: $test, ok: $ok, hist: $hist, showHist: $showHist);
                } else {
                    /*if (debug) {
                        Button("Сохранить") {
                            UpdateDefaults(InProgress: InProgress, ok: ok)
                        }
                    }*/
                    if (!testFinished) {
                        //   rules and results are here
                        if (!ShowingARule) {
                            if (CurrentWord == -1) {
                                /*  показываем менюшку  */
                                VStack {
                                    Spacer()
                                    Button("Сохранить") {
                                        UpdateDefaults(InProgress: InProgress, ok: ok)
                                    }
                                    .buttonStyle(GreenButton())
                                    Form {
                                        ForEach(0 ..< wordCount) {
                                            if (ok[$0] == -1) { //  если слово не отгадано
                                                UnknownWord(wrd: test[$0], WordId: $0, ok: $ok[$0], CurrentWord: $CurrentWord);
                                            } else if (ok[$0] == 0) { //  иначе результат
                                                WrongWord(wrd: test[$0], ShowingARule: $ShowingARule, ruleId: $ruleId);
                                            } else {
                                                OkWord(wrd: test[$0], ShowingARule: $ShowingARule, ruleId: $ruleId);
                                            }
                                        }
                                    }
                                    .font(.title)
                                    .foregroundColor(Color.white)
                                    Button("Завершить") {
                                        FinishTest(InProgress: &InProgress, Perc: CalcPercentage(ok: ok), hist: &hist);
                                    }
                                    .buttonStyle(GreenButton())
                                    Text("Процент правильных ответов \(CalcPercentage(ok: ok)) %")
                                        .frame(width: 300, height: 50, alignment: .center)
                                    
                                }
                            } else {
                                /*  угадываем слово  */
                                GuessTheWord(wrd: test[CurrentWord], ok: $ok[CurrentWord], CurrentWord: $CurrentWord);
                            }
                        } else {
                            /*  показываем правило  */
                            ShowRule(ruleId: ruleId, ShowingARule: $ShowingARule);
                        }
                    }
                }
            }
        }
    }
}
