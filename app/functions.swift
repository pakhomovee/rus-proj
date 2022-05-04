//
//  functions.swift
//  rus-project
//
//  Created by Evgenii Pakhomov on 14.09.2021.
//

import Foundation
import SwiftUI

struct RedButton: ButtonStyle {

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
                .foregroundColor(.white)
                .padding(10)
                .padding([.leading, .trailing], 30)
                .background(!configuration.isPressed ? Color.pink : Color(red: 204.0 / 255.0, green: 30.0 / 255.0, blue: 0 / 255.0))
                .cornerRadius(20)
    }
}

struct GreenButton: ButtonStyle {

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
                .foregroundColor(.white)
                .padding(10)
                .padding([.leading, .trailing], 30)
                .background(!configuration.isPressed ? Color.green : Color(red: 0, green: 137.0 / 255.0, blue: 20.0 / 255.0))
                .cornerRadius(20)
    }
}

struct CreateTest: View {
    @Binding var InProgress: Bool;
    @Binding var test: Array<Word>;
    @Binding var ok: Array<Int>;
    @Binding var hist: Array<Int>;
    @Binding var showHist: Bool;
    
    var body: some View {
        VStack {
            Button("Начать") {
                test.removeAll()
                ok.removeAll();
                var test1 = Array<Int> ();
                for _ in 1...wordCount {
                    let j = Int.random(in: 1...Words.count) - 1;
                    test.append(Words[j]);
                    test1.append(j);
                    ok.append(-1);
                }
                InProgress = true;
                UserDefaults.standard.set(test1, forKey: "TestInfo");
                UserDefaults.standard.set(true, forKey: "InProgress");
                UserDefaults.standard.set(ok, forKey: "ok");
            }
            .buttonStyle(RedButton())
            Button("Сбросить") {
                let test1 = Array<Int> ();
                let ok = Array<Int> ();
                UserDefaults.standard.set(test1, forKey: "TestInfo");
                UserDefaults.standard.set(false, forKey: "InProgress");
                UserDefaults.standard.set(ok, forKey: "ok");
            }
            .buttonStyle(RedButton())
            Button("История") {
                showHist = true;
            }
            .buttonStyle(RedButton())
        }
    }
}

struct ShowRule: View {
    @State var ruleId: Int;
    @Binding var ShowingARule: Bool;
    var body: some View {
        VStack {
            Form {
                Text(Rules[ruleId]);
                Button("Назад") {
                    ShowingARule = false;
                }
                .buttonStyle(RedButton())
            }
        }
    }
}
