//
//  FormFieldInputView.swift
//  TaskManager
//
//  Created by Sanjay Raskar on 20/01/25.
//

import SwiftUI

struct FormFieldInputView: View {
    @Binding private var text: String
    private let fieldTitle: String
    private let placeHolder: String
    @Binding private var fieldError: String
    private var fieldType: FieldType
    private var pickerInput: [String]
    @Binding private var date: Date
    private var validationRules = ""
    @State var textCounter: String = ""
    let descriptionCharLimit = 500
    let titleMinCount = 3
    
    init(text: Binding<String> = .constant(""), fieldTitle: String, placeHolder: String = "", fieldError: Binding<String> = .constant(""), fieldType: FieldType = .textInput, pickerInput: [String] = [], date: Binding<Date> = .constant(Date()), validationRules: String = "") {
        _text = text
        self.fieldTitle = fieldTitle
        self.placeHolder = placeHolder
        _fieldError = fieldError
        self.fieldType = fieldType
        self.pickerInput = pickerInput
        _date = date
        self.validationRules = validationRules
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            if fieldType != .picker && fieldType != .datePicker {
                Text(fieldTitle)
                    .font(.footnote)
                    .foregroundStyle(!fieldError.isEmpty ? Color.red : Color.black)
            }
            ZStack {
                switch fieldType {
                case .textInput:
                    TextField(placeHolder, text: $text)
                case .text:
                    Text(text)
                case .textDescription:
                    TextField(placeHolder, text: $text, axis: .vertical)
                case .picker:
                    Picker(fieldTitle, selection: $text) {
                        ForEach(pickerInput, id: \.self) { input in
                            Text(input)
                        }
                    }
                case .datePicker:
                    DatePicker(fieldTitle, selection: $date, in: Date()..., displayedComponents: .date)
                }
            }
            .onChange(of: text) { oldValue, newValue in
                // if !validationRules.isEmpty {
                switch fieldType {
                case .textInput:
                    if newValue.count < titleMinCount {
                        fieldError = "Enter a valid title"
                    } else {
                        fieldError = ""
                    }
                case .textDescription:
                    textCounter = "\(newValue.count) /\(descriptionCharLimit)"
                    if newValue.count > descriptionCharLimit {
                        fieldError = textCounter
                    } else {
                        fieldError = ""
                    }
                default:
                    return
                }
                // }
            }
            Divider()
                .overlay(!fieldError.isEmpty ? Color.red : Color.gray)
                .padding(.bottom, 12)
            
            if fieldType == .textDescription {
                HStack {
                    Spacer()
                    Text(textCounter)
                        .font(.footnote)
                        .foregroundStyle(text.count > descriptionCharLimit ? Color.red : Color.gray)
                }
            } else {
                if !fieldError.isEmpty {
                    HStack {
                        Spacer()
                        Text(fieldError)
                            .font(.footnote)
                            .foregroundStyle(Color.red)
                    }
                }
            }
        }
    }
}

#Preview {
    FormFieldInputView(text: .constant("hello"), fieldTitle: "Task Title", fieldError: .constant("Enter a valid title"), date: .constant(Date()))
}

enum FieldType {
    case textInput
    case text
    case textDescription
    case datePicker
    case picker
}

class FormField {
    @Published var fieldValue: String = ""
    var fieldTitle: String = ""
    var placeHolder: String = ""
    var fieldError: String = ""
    var fieldType: FieldType = .textInput
    var pickerInput: [String] = []
    
    init(fieldValue: String = "", fieldTitle: String, placeHolder: String = "", fieldError: String = "", fieldType: FieldType, pickerInput: [String] = []) {
        self.fieldValue = fieldValue
        self.fieldTitle = fieldTitle
        self.placeHolder = placeHolder
        self.fieldError = fieldError
        self.fieldType = fieldType
        self.pickerInput = pickerInput
    }
}
