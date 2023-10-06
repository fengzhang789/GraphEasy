/* =========================================================
 * ====                   WARNING                        ===
 * =========================================================
 * The code in this tab has been generated from the GUI form
 * designer and care should be taken when editing this file.
 * Only add/edit code inside the event handlers i.e. only
 * use lines between the matching comment tags. e.g.

 void myBtnEvents(GButton button) { //_CODE_:button1:12356:
     // It is safe to enter your event code here  
 } //_CODE_:button1:12356:
 
 * Do not rename this tab!
 * =========================================================
 */

synchronized public void win_draw1(PApplet appc, GWinData data) { //_CODE_:window1:214566:
  appc.background(230);
} //_CODE_:window1:214566:

public void equationFieldChanged(GTextField source, GEvent event) { //_CODE_:equationField:202076:
  println("equationField - GTextField >> GEvent." + event + " @ " + millis());
} //_CODE_:equationField:202076:

public void xMinFieldChanged(GTextField source, GEvent event) { //_CODE_:xMinField:825895:
  println("textfield1 - GTextField >> GEvent." + event + " @ " + millis());
  
  // Makes sure the input is a valid number and value for xMin
  if (isNumber(xMinField.getText())) {
    if(float(xMinField.getText()) < xMax) {
      xMin = float(xMinField.getText());
    }
  }
} //_CODE_:xMinField:825895:

public void xMaxFieldChanged(GTextField source, GEvent event) { //_CODE_:xMaxField:867678:
  println("textfield2 - GTextField >> GEvent." + event + " @ " + millis());
  
  // Makes sure the input is a valid number and value for xMax
  if (isNumber(xMaxField.getText())) {
    if(float(xMaxField.getText()) > xMin) {
      xMax = float(xMaxField.getText());
    }
  }
} //_CODE_:xMaxField:867678:

public void yMinFieldChanged(GTextField source, GEvent event) { //_CODE_:yMinField:729765:
  println("textfield3 - GTextField >> GEvent." + event + " @ " + millis());
  
  // Makes sure the input is a valid number and value for yMin
  if (isNumber(yMinField.getText())) {
    if(float(yMinField.getText()) < yMax) {
      yMin = float(yMinField.getText());
    }
  }
} //_CODE_:yMinField:729765:

public void yMaxFieldChanged(GTextField source, GEvent event) { //_CODE_:yMaxField:569604:
  println("textfield4 - GTextField >> GEvent." + event + " @ " + millis());
  
  // Makes sure the input is a valid number and value for yMax
  if (isNumber(yMaxField.getText())) {
    if(float(yMaxField.getText()) > yMin) {
      yMax = float(yMaxField.getText());
    }
  }
} //_CODE_:yMaxField:569604:

public void xScaleFieldChanged(GTextField source, GEvent event) { //_CODE_:xScaleField:578600:
  println("textfield5 - GTextField >> GEvent." + event + " @ " + millis());
  
  // Makes sure the input is a valid number and value for xScale
  if (isNumber(xScaleField.getText())) {
    if (float(xScaleField.getText()) > 0) {
      xScale = float(xScaleField.getText());    
    }
  }
} //_CODE_:xScaleField:578600:

public void yScaleFieldChanged(GTextField source, GEvent event) { //_CODE_:yScaleField:359421:
  println("textfield6 - GTextField >> GEvent." + event + " @ " + millis());
  
  // Makes sure the input is a valid number and value for xScale
  if (isNumber(yScaleField.getText())) {
    if (float(yScaleField.getText()) > 0) {
      yScale = float(yScaleField.getText());    
    }
  }
} //_CODE_:yScaleField:359421:

public void submitButtonClicked(GButton source, GEvent event) { //_CODE_:submitButton:933242:
  println("submitButton - GButton >> GEvent." + event + " @ " + millis());
  
  // Makes sure the function is not already running
  if(updatingGraph == false) {
    updatingGraph = true;
    
    String newEquation = equationField.getText();
    Graph temporaryGraph = new Graph(newEquation);  
    
    // Try graphing the equation to catch any formatting errors
    try {
      temporaryGraph.drawGraph();
      equation = newEquation;
      graph = new Graph(equation);
      errorLabel.setText("Version 1.0");
      updatingGraph = false;
    } 
    
    // If there is an error, don't update the actual graph in our program
    catch (Exception e) {
      equationField.setText("0");
      equation = "0";
      graph = new Graph(equation);
      errorLabel.setText(errorFile[round(random(errorFile.length-1))]);
      updatingGraph = false;
    }
  }
  
} //_CODE_:submitButton:933242:

public void demo1Clicked(GButton source, GEvent event) { //_CODE_:demo1:219283:
  println("demo1 - GButton >> GEvent." + event + " @ " + millis());
  
  // Sets the graph to the equation for demo1
  resetGraph();
  equation = demo_1;
  graph = new Graph(equation);
  errorLabel.setText("Version 1.0");
  updateGUIvalues();
} //_CODE_:demo1:219283:

public void demo2Clicked(GButton source, GEvent event) { //_CODE_:demo2:483934:
  println("demo2 - GButton >> GEvent." + event + " @ " + millis());
  
  // Sets the graph to the equation for demo2
  resetGraph();
  equation = demo_2;
  graph = new Graph(equation);
  errorLabel.setText("Version 1.0");
  updateGUIvalues();
} //_CODE_:demo2:483934:

public void demo3Clicked(GButton source, GEvent event) { //_CODE_:demo3:474741:
  println("demo3 - GButton >> GEvent." + event + " @ " + millis());
  
  // Sets the graph to the equation for demo3
  resetGraph();
  equation = demo_3;
  graph = new Graph(equation);
  errorLabel.setText("Version 1.0");
  updateGUIvalues();
} //_CODE_:demo3:474741:

public void zoomInButtonClicked(GButton source, GEvent event) { //_CODE_:zoomInButton:426427:
  println("zoomInButton - GButton >> GEvent." + event + " @ " + millis());
  zoomIn();
} //_CODE_:zoomInButton:426427:

public void zoomOutButtonClicked(GButton source, GEvent event) { //_CODE_:zoomOutButton:350300:
  println("zoomOutButton - GButton >> GEvent." + event + " @ " + millis());
  zoomOut();
} //_CODE_:zoomOutButton:350300:

public void resetButtonClicked(GButton source, GEvent event) { //_CODE_:resetButton:681550:
  println("resetButton - GButton >> GEvent." + event + " @ " + millis());
  resetGraph();
} //_CODE_:resetButton:681550:



// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setMouseOverEnabled(false);
  surface.setTitle("Sketch Window");
  window1 = GWindow.getWindow(this, "Window title", 0, 0, 400, 430, JAVA2D);
  window1.noLoop();
  window1.setActionOnClose(G4P.KEEP_OPEN);
  window1.addDrawHandler(this, "win_draw1");
  equationField = new GTextField(window1, 210, 40, 170, 30, G4P.SCROLLBARS_NONE);
  equationField.setPromptText("Equation");
  equationField.setOpaque(false);
  equationField.addEventHandler(this, "equationFieldChanged");
  equationLabel = new GLabel(window1, 210, 20, 170, 20);
  equationLabel.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  equationLabel.setText("Equation");
  equationLabel.setOpaque(true);
  xMinField = new GTextField(window1, 20, 260, 120, 30, G4P.SCROLLBARS_NONE);
  xMinField.setPromptText("xMin");
  xMinField.setOpaque(true);
  xMinField.addEventHandler(this, "xMinFieldChanged");
  xMinLabel = new GLabel(window1, 20, 240, 120, 20);
  xMinLabel.setText("xMin");
  xMinLabel.setOpaque(true);
  xMaxLabel = new GLabel(window1, 160, 240, 120, 20);
  xMaxLabel.setText("xMax");
  xMaxLabel.setOpaque(true);
  xMaxField = new GTextField(window1, 160, 260, 120, 30, G4P.SCROLLBARS_NONE);
  xMaxField.setPromptText("xMax");
  xMaxField.setOpaque(true);
  xMaxField.addEventHandler(this, "xMaxFieldChanged");
  yMinLabel = new GLabel(window1, 20, 170, 120, 20);
  yMinLabel.setText("yMin");
  yMinLabel.setOpaque(true);
  yMinField = new GTextField(window1, 20, 190, 120, 30, G4P.SCROLLBARS_NONE);
  yMinField.setPromptText("yMin");
  yMinField.setOpaque(true);
  yMinField.addEventHandler(this, "yMinFieldChanged");
  yMaxLabel = new GLabel(window1, 160, 170, 120, 20);
  yMaxLabel.setText("yMax");
  yMaxLabel.setOpaque(true);
  yMaxField = new GTextField(window1, 160, 190, 120, 30, G4P.SCROLLBARS_NONE);
  yMaxField.setOpaque(true);
  yMaxField.addEventHandler(this, "yMaxFieldChanged");
  xScaleLabel = new GLabel(window1, 20, 310, 120, 20);
  xScaleLabel.setText("xScale");
  xScaleLabel.setOpaque(true);
  yScaleLabel = new GLabel(window1, 160, 310, 120, 20);
  yScaleLabel.setText("yScale");
  yScaleLabel.setOpaque(true);
  xScaleField = new GTextField(window1, 20, 330, 120, 30, G4P.SCROLLBARS_NONE);
  xScaleField.setOpaque(true);
  xScaleField.addEventHandler(this, "xScaleFieldChanged");
  yScaleField = new GTextField(window1, 160, 330, 120, 30, G4P.SCROLLBARS_NONE);
  yScaleField.setOpaque(true);
  yScaleField.addEventHandler(this, "yScaleFieldChanged");
  submitButton = new GButton(window1, 210, 80, 170, 30);
  submitButton.setText("Graph");
  submitButton.setLocalColorScheme(GCScheme.RED_SCHEME);
  submitButton.addEventHandler(this, "submitButtonClicked");
  titleLabel = new GLabel(window1, 20, 20, 170, 90);
  titleLabel.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  titleLabel.setText("GraphEasy");
  titleLabel.setOpaque(true);
  settingsLabel = new GLabel(window1, 20, 130, 260, 30);
  settingsLabel.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  settingsLabel.setText("Graph Settings");
  settingsLabel.setOpaque(true);
  demo1 = new GButton(window1, 300, 130, 80, 30);
  demo1.setText("Demo 1");
  demo1.setLocalColorScheme(GCScheme.CYAN_SCHEME);
  demo1.addEventHandler(this, "demo1Clicked");
  demo2 = new GButton(window1, 300, 170, 80, 30);
  demo2.setText("Demo 2");
  demo2.setLocalColorScheme(GCScheme.CYAN_SCHEME);
  demo2.addEventHandler(this, "demo2Clicked");
  demo3 = new GButton(window1, 300, 210, 80, 30);
  demo3.setText("Demo 3");
  demo3.setLocalColorScheme(GCScheme.CYAN_SCHEME);
  demo3.addEventHandler(this, "demo3Clicked");
  zoomInButton = new GButton(window1, 300, 250, 80, 30);
  zoomInButton.setText("Zoom In");
  zoomInButton.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
  zoomInButton.addEventHandler(this, "zoomInButtonClicked");
  zoomOutButton = new GButton(window1, 300, 290, 80, 30);
  zoomOutButton.setText("Zoom Out");
  zoomOutButton.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
  zoomOutButton.addEventHandler(this, "zoomOutButtonClicked");
  resetButton = new GButton(window1, 300, 330, 80, 30);
  resetButton.setText("Reset ");
  resetButton.setLocalColorScheme(GCScheme.RED_SCHEME);
  resetButton.addEventHandler(this, "resetButtonClicked");
  errorLabel = new GLabel(window1, 20, 370, 360, 40);
  errorLabel.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  errorLabel.setText("Version 1.0");
  errorLabel.setOpaque(true);
  window1.loop();
}

// Variable declarations 
// autogenerated do not edit
GWindow window1;
GTextField equationField; 
GLabel equationLabel; 
GTextField xMinField; 
GLabel xMinLabel; 
GLabel xMaxLabel; 
GTextField xMaxField; 
GLabel yMinLabel; 
GTextField yMinField; 
GLabel yMaxLabel; 
GTextField yMaxField; 
GLabel xScaleLabel; 
GLabel yScaleLabel; 
GTextField xScaleField; 
GTextField yScaleField; 
GButton submitButton; 
GLabel titleLabel; 
GLabel settingsLabel; 
GButton demo1; 
GButton demo2; 
GButton demo3; 
GButton zoomInButton; 
GButton zoomOutButton; 
GButton resetButton; 
GLabel errorLabel; 
