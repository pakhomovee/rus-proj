//
//  ContentView.swift
//  rus-project
//
//  Created by Evgenii Pakhomov on 14.09.2021.
//

import SwiftUI

struct GuessTheWord: View {
    @State var wrd: Word;
    @Binding var ok: Int;
    @Binding var CurrentWord: Int;
    
    var body: some View {
        VStack {
            ForEach(0..<wrd.options.count) { id in
                let option = wrd.options[id];
                if (option == wrd.correct) {
                    Button(option) {
                        ok = 1;
                        CurrentWord = -1;
                    }
                    .buttonStyle(RedButton())
                } else {
                    Button(option) {
                        ok = 0;
                        CurrentWord = -1;
                    }
                    .buttonStyle(RedButton())
                }
            }
        }
    }
}

struct UnknownWord: View {
    @State var wrd: Word;
    @State var WordId: Int;
    @Binding var ok: Int;
    @Binding var CurrentWord: Int;
    
    var body: some View {
        Button(wrd.label) {
            CurrentWord = WordId;
        }
        .frame(maxWidth: .infinity)
        .background(Color.blue)
    }
}

struct OkWord: View {
    @State var wrd: Word;
    @Binding var ShowingARule: Bool;
    @Binding var ruleId: Int;
    var body: some View {
        Button(wrd.label) {
            ShowingARule = true;
            ruleId = wrd.rule;
        }
        .frame(maxWidth: .infinity)
        .background(Color.green)
    }
}

struct WrongWord: View {
    @State var wrd: Word;
    @Binding var ShowingARule: Bool;
    @Binding var ruleId: Int;
    var body: some View {
        Button(wrd.label) {
            ShowingARule = true;
            ruleId = wrd.rule;
        }
        .frame(maxWidth: .infinity)
        .background(Color.pink)
    }
}

func getText(hist: Array<Int>) -> String {
    var res = "";
    for i in 1...hist.count - 1 {
        res += String(i) + " - " + String(hist[i]) + "%\n";
    }
    return res;
}

struct showHistory: View {
    @Binding var hist: Array<Int>;
    @Binding var showHist: Bool;
    
    var body: some View {
        Text(getText(hist: hist));
        Button("Назад") {
            showHist = false;
        }
        .buttonStyle(RedButton())
    }
}

struct restore: View {
    @Binding var InProgress: Bool;
    @Binding var test: Array<Word>;
    @Binding var ok: Array<Int>;
    @Binding var hist: Array<Int>;
    @Binding var OnStart: Bool;
    
    var body: some View {
        Button("Start") {
            restoreDefaults(InProgress: &InProgress, test: &test, ok: &ok, hist: &hist);
            OnStart = false;
        }
        .buttonStyle(RedButton())
    }
}
