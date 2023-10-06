ArrayList<String> outputQueue = new ArrayList<String>();
ArrayList<String> evaluationStack = new ArrayList<String>();
ArrayList<String> operatorStack = new ArrayList<String>();

// Implementation of the shunting algorithm
float shuntingAlgorithm(ArrayList<String> equationArray) {
  outputQueue = new ArrayList<String>();
  evaluationStack = new ArrayList<String>();
  operatorStack = new ArrayList<String>();

  // Converting the equation to postfix, and evaluating the postfix expression
  convertToPostfix(equationArray);
  evaluatePostfixExpression();
  
  
  // Try returning the value 
  try {
    return float(evaluationStack.get(0));
  } 
  
  // If an error occurs, there is a problem with the inputted equation
  catch (Exception e) {
    equationField.setText("0");
    equation = "0";
    graph = new Graph(equation);
    errorLabel.setText(errorFile[round(random(errorFile.length-1))]);
    return 0;
  }
}


// Convert the equation to postfix
void convertToPostfix(ArrayList<String> equation) {
  
  // Goes through each character in the parsed equation
  for (int i = 0; i < equation.size(); i++) {
    String character = equation.get(i);
    
    // Removes blank spaces 
    if (!character.equals(" ")) {

      // IF THE CHARACTER IS A NUMBER
      if (isNumber(character)) {
        int pos = i;

        // While the next character is still a number or a decimal character, continue to the next character
        while (isNumber(equation.get(pos)) || equation.get(pos).equals(".")) {
          pos++;

          if (pos == equation.size()) {
            break;
          }
        }

        // Add the whole number to the output queue
        String output = "";
        for (int m = i; m < pos; m++) {
          output += equation.get(m);
        }

        outputQueue.add(output);
        i = pos-1;
      }

      // IF THE CHARACTER IS PART OF A FUNCTION
      else if (character.equals("s") || character.equals("c") || character.equals("t")) {
        
        // Sine function
        if(character.equals("s") && equation.get(i+1).equals("i") && equation.get(i+2).equals("n")) {
          operatorStack.add(0, "sin");
          i += 2;
        }
        
        // Tangent function
        else if(character.equals("t") && equation.get(i+1).equals("a") && equation.get(i+2).equals("n")) {
          operatorStack.add(0, "tan");
          i += 2;
        }
        
        // Cosine function
        else if(character.equals("c") && equation.get(i+1).equals("o") && equation.get(i+2).equals("s")) {
          operatorStack.add(0, "cos");
          i += 2;
        }
        
        // Square Root function
        else if(character.equals("s") && equation.get(i+1).equals("q") && equation.get(i+2).equals("r") && equation.get(i+3).equals("t")) {
          operatorStack.add(0, "sqrt");
          i += 3;
        }        
      }


      // IF THE CHARACTER IS NOT A NUMBER OR FUNCTION
      else {
        // The case where a negative symbol does not represent subtraction, but rather a negative number
        if (character == "-") {
        
          if (i == 0 && isNumber(equation.get(i+1))) {
            int pos = i+1;

            // If the next character is still a number or a decimal character, continue to the next character
            while (isNumber(equation.get(pos)) || equation.get(pos) == ".") {
              pos++;

              if (pos == equation.size()) {
                break;
              }
            }

            // Add the whole number to the output queue
            String output = "";
            for (int m = i; m < pos; m++) {
              output += equation.get(m);
            }

            outputQueue.add(output);
            i = pos-1;
          }
          
          // If the negative number is not at the beginning of the string
          if (i > 0) {
            if (isNumber(equation.get(i-1)) == false && character == "-") {
              int pos = i+1;

              // If the next character is still a number or a decimal character, continue to the next character
              while (isNumber(equation.get(pos)) || equation.get(pos) == ".") {
                pos++;

                if (pos == equation.size()) {
                  break;
                }
              }

              // Add the whole number to the output queue
              String output = "";
              for (int m = i; m < pos; m++) {
                output += equation.get(m);
              }

              outputQueue.add(output);
              i = pos-1;
            }
          }
        }


        // If the operator stack is empty, always add the operator
        else if (operatorStack.size() == 0 ) {
          operatorStack.add(0, character);
        }

        // If the character is a left parenthesis, always add it to the operator stack
        else if (priorities.get(character) == 0) {
          operatorStack.add(0, character);
        }

        // If the character is a right bracket, pop all the operators into the output queue up to the left bracket
        else if (priorities.get(character) == priorities.get(")")) {
          while (priorities.get(operatorStack.get(0)) != 0) {

            outputQueue.add(operatorStack.get(0));
            operatorStack.remove(0);

            // Prevents a null pointer exception
            if (operatorStack.size() == 1) {
              break;
            }
          }
          operatorStack.remove(0);
        }

        // If the character operator has a higher priority than the one in stack, add it to the operator stack.
        else if (priorities.get(operatorStack.get(0)) < priorities.get(character)) {
          operatorStack.add(0, character);
        }

        // If the character has equal or lower priority than the one in stack, add it to the output queue
        else {
          while (priorities.get(character) <= priorities.get(operatorStack.get(0))) {
            outputQueue.add(operatorStack.get(0));
            operatorStack.remove(0);

            // Prevents a null pointer exception
            if(operatorStack.size() == 0) {
              break;
            }
          }
          operatorStack.add(0, character);
        }
      }
    }
  }
  
  
  // If there are still characters left in the operatorStack array
  if (operatorStack.size() != 0) {
    int size = operatorStack.size();
    
    // Append them to the output array
    for (int i = 0; i < size; i++) {
      
      // There is sometimes an error when the user tries to do an expression x--8, this try catch statement prevents the program from crashing
      try {
        outputQueue.add(operatorStack.get(0));
        operatorStack.remove(0);
      } 
      
      catch (Exception e) {
        equationField.setText("0");
        graph = new Graph("0");
        errorLabel.setText(errorFile[round(random(errorFile.length-1))]);
        updatingGraph = false;
      }
    }
  }
}


// Evaluating the postfix expression in the outputQueue Array
void evaluatePostfixExpression() {
  for (int i = 0; i < outputQueue.size(); i++) {    
    String output = outputQueue.get(i);

    // If the output is a number or a function
    if (isNumber(output)) {
      evaluationStack.add(0, output);
    }

    // If the output is an operator
    else {
      
      // If theres only one item in the evaluationStack array, there must be a function evaluating the number
      if (evaluationStack.size() == 1) {
        float number = float(evaluationStack.get(0));
        evaluationStack.remove(0);
        
        if (output.equals("sin")) {
          evaluationStack.add(0, str(sin(number)));
        }
        
        else if (output.equals("cos")) {
          evaluationStack.add(0, str(cos(number)));
        }
        
        else if (output.equals("tan")) {
          evaluationStack.add(0, str(tan(number)));
        }
        
        else if (output.equals("sqrt")) {
          evaluationStack.add(0, str(sqrt(number)));
        }
      }
      
      // If the evaluationStack size is less than 2, the reverse polish expression must be invalid
      if (evaluationStack.size() >= 2) {

        float rightNumber = float(evaluationStack.get(0));
        evaluationStack.remove(0);
        float leftNumber = float(evaluationStack.get(0));
        evaluationStack.remove(0);
        
        // Check what type of operation is being performed, and add the number back to the evaluation stack
        if (output.equals("+")) {
          evaluationStack.add(0, str(leftNumber + rightNumber));
        } 
        
        else if (output.equals("-")) {
          evaluationStack.add(0, str(leftNumber - rightNumber));
        } 
        
        else if (output.equals("*")) {
          evaluationStack.add(0, str(leftNumber * rightNumber));
        } 
        
        else if (output.equals("/")) {
          evaluationStack.add(0, str(leftNumber / rightNumber));
        } 
        
        else if (output.equals("^")) {
          evaluationStack.add(0, str(pow(leftNumber, rightNumber)));
        } 
        
        else if (output.equals("sin")) {
          evaluationStack.add(0, str(leftNumber));
          evaluationStack.add(0, str(sin(rightNumber)));
        } 
        
        else if (output.equals("cos")) {
          evaluationStack.add(0, str(leftNumber));
          evaluationStack.add(0, str(cos(rightNumber)));
        } 
        
        else if (output.equals("tan")) {
          evaluationStack.add(0, str(leftNumber));
          evaluationStack.add(0, str(tan(rightNumber)));
        } 
        
        else if (output.equals("sqrt")) {
          evaluationStack.add(0, str(leftNumber));
          evaluationStack.add(0, str(sqrt(rightNumber)));
        } 
      }
    }
  }
}
