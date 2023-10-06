class Graph {
  // FIELDS
  String equation;
  ArrayList<String> equationCopy;
  ArrayList<String> parsedEquation;
  ArrayList<PVector> points;
  float yCoordinateGraph1;
  float yCoordinateGraph2;
  float xCoordinateGraph1;
  float xCoordinateGraph2;
  float mouseCoordinateX1;
  float mouseCoordinateX2;
  float yInterceptOfTangent;
  float yCoordinate1;
  float yCoordinate2;
  float spacingBetweenPoints;
  float slope;

  // Hash map that stores the values of the previously parsed equations to avoid parsing the same x-value multiple times.
  private HashMap<Float, ArrayList<String>> previousParsedEquations;
  // Hash map that stores previously calculated coordinate pairs to avoid parsing the same x-value again
  private HashMap<Float, Float> graphCoordinates;


  // CONSTRUCTOR
  Graph(String e) {
    this.equation = e;
    this.parsedEquation = new ArrayList<String>();
    this.previousParsedEquations = new HashMap<Float, ArrayList<String>>();
    this.graphCoordinates = new HashMap<Float, Float>();
    this.equationCopy = new ArrayList<String>();
    this.points = new ArrayList<PVector>();
  
    this.spacingBetweenPoints = abs(xMax-xMin) / (width/2);

    // Adds all the characters in the equation variable into the parsedEquation ArrayList
    for (int i = 0; i < equation.length(); i++) {
      if (equation.charAt(i) != ' ')
        equationCopy.add(str(equation.charAt(i)));
    }
  }


  // METHODS
  // Draws the graph on screen
  void drawGraph() {
    float xValue;
    
    this.spacingBetweenPoints = abs(xMax-xMin) / (width/2);
    // Finds 300 coordinate pairs across the screen that are equally spaced apart
    for (int j = 0; j < width/2; j++) {

      // The x-coordinate of the current point
      xValue = xMin+spacingBetweenPoints*j;

      // Adds the coordinate pair to the points arrayList
      points.add(new PVector(xValue, parseEquation(xValue)));
    }

    // Draws graph on the screen
    for (int i = 1; i < points.size(); i++) {
      
      // Defining two points that are close to each other and drawing a straight line between them
      float pointX1 = coordinateAxis.xCoordYAxis + this.points.get(i).x * coordinateAxis.spacingXtick / xScale - adjustmentx;
      float pointY1 = coordinateAxis.yCoordXAxis - this.points.get(i).y * coordinateAxis.spacingYtick / yScale + adjustmenty;
      float pointX2 = coordinateAxis.xCoordYAxis + this.points.get(i-1).x * coordinateAxis.spacingXtick / xScale - adjustmentx;
      float pointY2 = coordinateAxis.yCoordXAxis - this.points.get(i-1).y * coordinateAxis.spacingYtick / yScale + adjustmenty;

      stroke(0);
      strokeWeight(5);
      
      // Only draw the line if the line isn't a asymptote
      if (abs(pointY1 - pointY2) < pow(10, 4)) {
        fill(0);
        line(pointX1, pointY1, pointX2, pointY2);
      }
    }
    
    // Clear the points array for the next frame
    points = new ArrayList<PVector>();
  }


  // Parses the equation by replacing the variable "x" with numbers in the range of xMin to xMax
  float parseEquation(float xValue) {
    float yValue;
    parsedEquation = new ArrayList<String>();

    // If the x-value and y-value coordinates already exist in the hashmap don't recalculate since this takes a lot of time
    if (graphCoordinates.containsKey(xValue)) {
      yValue = graphCoordinates.get(xValue);
    }

    else {
      // If the equation has already been parsed before, don't reparse since this takes a lot of time
      if (previousParsedEquations.containsKey(xValue)) {
        parsedEquation = previousParsedEquations.get(xValue);
      }

      // If the x-coordinate of the current point isnt in the hashmaps, parse the equation
      else {
        // Copy the equation into the parsedEquation ArrayList
        parsedEquation.addAll(equationCopy);

        // Loop through the whole equation
        for (int i = 0; i < parsedEquation.size(); i++) {

          // Replace x with the point value
          if (parsedEquation.get(i).equals("x")) {
            parsedEquation.remove(i);
            
            // If x is not at the beginning of the equation, for example 2x
            if (i != 0) {
              
              // If there is a coefficient in front of the x, multiply it by x
              if (isNumber(parsedEquation.get(i-1))) {
                parsedEquation.add(i, "*");
                parsedEquation.add(i+1, str(xValue));
              }

              // If there is a negative sign in front of the x
              else if (parsedEquation.get(i-1).equals("-")) {
                
                // If the negative sign is at the very beginning of the equation, for example -x
                if(i-1 == 0) {
                  
                  // Add a -1 * xValue to the array
                  parsedEquation.remove(i-1);
                  parsedEquation.add(i-1, "-1");
                  parsedEquation.add(i, "*");
                  parsedEquation.add(i+1, str(xValue));
                }
                
                // If the negative sign is not at the very beginning of the equation
                else if(i > 1) {
                  
                  // If the character before it is not a number (ex. 2*(-x))
                  if (isNumber(parsedEquation.get(i-2)) == false) {
                    
                    // Add a -1 * xValue to the array
                    parsedEquation.remove(i-1);
                    parsedEquation.add(i-1, "-1");
                    parsedEquation.add(i, "*");
                    parsedEquation.add(i+1, str(xValue));
                  }
                }
              }
              // If there are no exceptions, add the xValue to the array
              else {
                parsedEquation.add(i, str(xValue));
              }
            }
            // If i is not 0, just add the x value
              else 
                parsedEquation.add(i, str(xValue));
          }


          // If the character being read is NOT x
          else {

            // The case where there is a negative number at the beginning (ex. -5)
            if (i == 0 && parsedEquation.get(i).equals("-") && parsedEquation.size() > 0) {
              
              // If the next character is a number
              if (isNumber(parsedEquation.get(i+1))) {

                int pos = i+1;
                // While the next character is still a number or a decimal character, continue to the next character
                while (isNumber(parsedEquation.get(pos)) || parsedEquation.get(pos).equals(".")) {
                  pos++;
                  
                  // If we've reached the end of the equation
                  if (pos == parsedEquation.size()) {
                    break;
                  }
                }

                // Add the entire number to the parsed equation arrayList
                String output = "";
                for (int m = i; m < pos; m++) {
                  output += parsedEquation.get(m);
                }
                
                // Remove the numbers we just parsed
                for (int l = 0; l < pos - i; l++) {
                  parsedEquation.remove(0);
                }
                
                // Add the whole number we parsed into the arrayList
                parsedEquation.add(0, output);
                i = pos-1;
              }

              // If the next character is x, for example -x
              else if (parsedEquation.get(i+1).equals("x")) {
                
                // Adds -1 * xValue to the arrayList
                parsedEquation.remove(i);
                parsedEquation.remove(i);
                parsedEquation.add(i, "-1");
                parsedEquation.add(i+1, "*");
                parsedEquation.add(i+2, str(xValue));
                i = i + 2;
              }
            }

            // If the constant "e" exists in the equation
            else if (parsedEquation.get(i).equals("e")) {
              parsedEquation.remove(i);
              parsedEquation.add(i, "2.7182818");
            }
          }
          // Put the parsed equation into the hashmap so we don't recalculate it
          previousParsedEquations.put(xValue, parsedEquation);
        }
      }
      
      // Get the y-value 
      yValue = shuntingAlgorithm(parsedEquation);
      
      // Put the coordinate pair into the hashmap so we don't recalculate it
      graphCoordinates.put(xValue, yValue);
    }
    return yValue;
  }


  // Draws the labels on screen
  void drawLabels() {
    
    // Draws the equation of the graph
    fill(255, 0, 0);
    textAlign(TOP, CENTER);
    text("y = " + equation, 20, 20);
    
    // Operation is used for formatting, to avoid a case such as y = 5x*+-4.
    String operation;
    if(yInterceptOfTangent >= 0) {
      operation = "x+";
    }

    else {
      operation = "x";
    }
    
    // Formats the output equation nicely and draws it on screen
    String outputEquation = "Tangent: y = " + nf(slope, 0, 2) + operation + nf(yInterceptOfTangent, 0, 2);
    text(outputEquation,  20, 40);
    
    // Draws the slope below the equation
    text("Slope: m = " + nf(slope, 0, 2), 20, 60); 
  }


  // Draws the tangent line at the xCoordinate of the mouse
  void drawTangentLine() {    
    stroke(255, 0, 0);

    // If the tangent is not locked, update the values of the graph
    if (tangentLocked == false) {
      slope = (yCoordinate2 - yCoordinate1) / (mouseCoordinateX2 - mouseCoordinateX1);
      
      // Gets the xCoordinate of wherever your mouse is
      mouseCoordinateX1 = mouseX * xScale / coordinateAxis.spacingXtick + xMin;
      mouseCoordinateX2 = (mouseX + 1) * xScale / coordinateAxis.spacingXtick + xMin;

      yCoordinate1 = parseEquation(mouseCoordinateX1);
      yCoordinate2 = parseEquation(mouseCoordinateX2);
    }

    // The y intercept of the line
    this.yInterceptOfTangent = yCoordinate1 - slope*mouseCoordinateX1;
    
    // Gets the graph coordinates for the tangent line
    yCoordinateGraph1 = coordinateAxis.yCoordXAxis - (slope*xMin + yInterceptOfTangent) * coordinateAxis.spacingYtick / yScale + adjustmenty;
    yCoordinateGraph2 = coordinateAxis.yCoordXAxis - (slope*xMax + yInterceptOfTangent) * coordinateAxis.spacingYtick / yScale + adjustmenty;
    xCoordinateGraph1 = coordinateAxis.xCoordYAxis + xMin * coordinateAxis.spacingXtick / xScale - adjustmentx;
    xCoordinateGraph2 = coordinateAxis.xCoordYAxis + xMax * coordinateAxis.spacingXtick / xScale - adjustmentx;
    
    // Draws the tangent line
    strokeWeight(3);
    line(xCoordinateGraph1, yCoordinateGraph1, xCoordinateGraph2, yCoordinateGraph2);

    // Draws a small red circle at the point of the graph the tangent line is on
    fill(255, 0, 0);
    circle((mouseCoordinateX1 - xMin) / xScale * coordinateAxis.spacingXtick, coordinateAxis.yCoordXAxis - yCoordinate1 * coordinateAxis.spacingYtick / yScale + adjustmenty, 5);
  }

  
  // Displays the coordinates of the mouse position at the bottom left corner of the screen
  void displayMousePosition() {
    textAlign(TOP, CENTER);
    fill(0);
    String output = "(" + str(mouseCoordinateX1) + ", " + str(yCoordinate1) + ")";
    text(output, 15, height-15);
  }
}
