//
//  ContentView.swift
//  To-Do List
//
//  Created by StudentAM on 2/27/24.
//

import SwiftUI

struct ContentView: View {
    @State private var task: String = "" // to store what user types
    @State private var numTasks: Int = 0 // to display number of tasks added
    @State private var data: [String] = [] // to display and store tasks
    @State private var isTextFieldEmpty: Bool = true // to change color of button "add task" if text in textfield
    @State private var noTasks: Bool = true // to change color of button "remove all tasks" if there are tasks
    @State private var showAlert: Bool = false // to figure out whether or not to show warning of adding something empty
    var body: some View {
        NavigationView{ // to have nested pages (hstack inside of vstack)
            VStack { // to display title, num of tasks, textfield, and buttons in a column
                HStack{ // for changing position of text displaying number of tasks
                    Text("Number of tasks: \(numTasks)") // to show number of tasks added
                        .padding() // changing position a bit to the right and down
                    Spacer() // to shift text to the left
                } // end of vstack
                
                TextField("Enter a new task", text: $task) // for user to enter task
                    .textFieldStyle(RoundedBorderTextFieldStyle()) // for textfield to have rounded corners
                    .padding() // to change position
                    .onChange(of: task){ newValue in // to check for change in textfield (etc: something typed)
                        isTextFieldEmpty = newValue.isEmpty // checks for if new value is empty and assigns appropriate boolean
                    } // end of onChange
                
                HStack{ // to display buttons side by side
                    Button("Add Task"){ // button to add task
                        addTask(activity: task) // to add task
                    } // end of button
                    
                    .alert("You cannot add something empty!", isPresented: $showAlert){ // to alert user that they cannot add something empty
                        Button("OK", role: .cancel){} // give choice to move forward with warning
                    } // end of alert
                        .padding() // to change position and size of button
                        .background(isTextFieldEmpty ? Color.gray : Color.blue) // change color of "add task" button if something in textfield or not
                        .foregroundColor(.white) // for text of button to be white
                        .cornerRadius(8) // for rounded corners of button
                    
                    Button("Remove All Tasks", action: deleteTaskAll) // button to remove all tasks
                        .padding() // to change position and size of button
                        .background(noTasks ? Color.gray : Color.blue) // change color of "remove all tasks" button if there are tasks or not
                        .foregroundColor(.white) // for text of button to be white
                        .cornerRadius(8) // for rounded corners of button
                } // end of hstack
                .padding() // to bring position of buttons a bit down
                
                List{ // to display and delete task
                    ForEach(data, id: \.self){ task in // iterate through task in data
                        Text("\(task)") // to diplay task
                    } // end of foreach
                    .onDelete(perform: deleteItem) // to delete task
                } // end of list
            } // end of vstack
            .navigationTitle("To-Do List") // to display title
        } // end of navigationview
    }
    
    func addTask(activity: String){ // to add task
        if (task != ""){ // check if textfield is not empty and if not does the following:
            data.append(activity) // add task to data list for displaying
            numTasks += 1 // increment number of task for displaying
            isTextFieldEmpty = false // sets isTextFieldEmpty to false to change color of button "add task" when textfield is not empty
            noTasks = false // sets noTasks to false to change color of button "remove all tasks" when there are tasks
            task = "" // sets task to "" to reset textfield
        }else{ // end of if | else textfield empty
            showAlert = true // show alert to user warning that they cannot add something empty
        } // end of else
    } // end of addTask
    
    func deleteTaskAll(){ // to delete all tasks
        data = [] // to display nothing
        numTasks = 0 // to display number of tasks to 0
        isTextFieldEmpty = true // to change color of button "add task" when textfield is empty
        noTasks = true // to change color of button "remove all tasks" when there are no tasks
        task = "" //to reset textfield
    } // end of deleteTaskAll
    
    func deleteItem(offset: IndexSet){ // for deleting task
        data.remove(atOffsets: offset) // deletes task
        numTasks -= 1 // to subtract 1 from text display number of tasks
        if (numTasks == 0){ // to change button "add task" color when there are no tasks
            noTasks = true // // to change button "add task" color when there are no tasks
        } // end of if
    } // end of deleteItem
}

#Preview {
    ContentView()
}
