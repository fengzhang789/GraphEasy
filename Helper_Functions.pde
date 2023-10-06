// Checks if a string is a number
boolean isNumber(String c) {
  try {
    Float.parseFloat(c);
    return true;
  } 
  
  catch (Exception e) {
    return false;
  }
}


// Updates the adjustmentx and adjustmenty variables which are responsible for shifting the origin point of the coordinate axis
// This makes sure that points are drawn on the right places on screen
void updateAdjustment() {
  
  // Updates adjustmentx
  if(xMin > 0) {
    adjustmentx = xMin * coordinateAxis.spacingXtick / xScale;
  }
  
  else if (xMax < 0) {
    adjustmentx = xMax * coordinateAxis.spacingXtick / xScale;
  }
  
  else {
    adjustmentx = 0;
  }
  
  // Updates adjustmenty
  if(yMin > 0) {
    adjustmenty = yMin * coordinateAxis.spacingYtick / yScale;
  }
  
  else if (yMax < 0) {
    adjustmenty = yMax * coordinateAxis.spacingYtick / yScale;
  }
  
  else {
    adjustmenty = 0;
  }
}

// Updates the values on the GUI
void updateGUIvalues() {
  
  // Makes sure this function is only running once at a time to prevent a g4p error
  if(updatingValues == false) {
    updatingValues = true;
    
    // Prevents a concurrent modification error
    try {
      // Sets the xMin, xMax, yMin, and yMax text fields whenever the user drags the graph
      xMinField.setText(str(xMin));
      xMaxField.setText(str(xMax));
      yMinField.setText(str(yMin));
      yMaxField.setText(str(yMax));
      
      // Sets the xScale and yScale variables
      xScaleField.setText(str(xScale));
      yScaleField.setText(str(yScale));
      
      // Sets the equation
      equationField.setText(equation);
    } 
    
    catch (Exception e) {
    }

    updatingValues = false;
  }
}


// Updates the text size and colors on the GUI
void setSettingsForGUI() {
  
  // SETS THE TEXT SIZE AND COLORS FOR THE TITLE
  titleLabel.setFont(titleFont);
  titleLabel.setLocalColorScheme(2);
  
  // SETS THE TEXT SIZE AND COLORS FOR THE EQUATION
  equationLabel.setFont(labelFont);
  equationLabel.setLocalColorScheme(5);
  equationField.setFont(labelFont);
  
  // SETS THE TEXT SIZE AND COLORS FOR THE BUTTON
  submitButton.setFont(labelFont);
  
  // SETS THE TEXT SIZE AND COLORS FOR THE Y MIN & MAX 
  yMinLabel.setFont(labelFont);
  yMinLabel.setLocalColorScheme(5);
  yMinField.setFont(labelFont);
  
  yMaxLabel.setFont(labelFont);
  yMaxLabel.setLocalColorScheme(5);
  yMaxField.setFont(labelFont);
  
  // SETS THE TEXT SIZE AND COLORS FOR THE X MIN & MAX 
  xMinLabel.setFont(labelFont);
  xMinLabel.setLocalColorScheme(5);
  xMinField.setFont(labelFont);
  
  xMaxLabel.setFont(labelFont);
  xMaxLabel.setLocalColorScheme(5);
  xMaxField.setFont(labelFont);
  
  // SETS THE TEXT SIZE AND COLORS FOR THE XSCALE AND YSCALE 
  xScaleLabel.setFont(labelFont);
  xScaleLabel.setLocalColorScheme(5);
  xScaleField.setFont(labelFont);
  
  yScaleLabel.setFont(labelFont);
  yScaleLabel.setLocalColorScheme(5);
  yScaleField.setFont(labelFont);
  
  // SETS THE TEXT SIZE AND COLORS FOR THE SETTINGS LABEL
  settingsLabel.setFont(titleFont);
  settingsLabel.setLocalColorScheme(6);
  
  // SETS THE TEXT SIZE AND COLORS FOR THE ERRORS LABEL
  errorLabel.setFont(labelFont);
  errorLabel.setLocalColorScheme(5);
}


// Resets the graph to default settings
void resetGraph() {
  xMax = 5;
  xMin = -5;
  yMax = 5;
  yMin = -5;
  xScale = 1;
  yScale = 1;
  
  equation = "";
  graph = new Graph(equation);
  
  updateGUIvalues();
}


void loadFiles() {
  // Reads the priorities from the priorities.txt and puts them into the priorities hashmap for the shunting algorithm
  for (int i = 0 ; i < priorityFile.length; i++) {
    String[] parts = priorityFile[i].split(",");
    
    String operator = parts[0];
    int priority = int(float(parts[1]));    
    priorities.put(operator, priority);
  }
}
