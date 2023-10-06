class Axis {
  // FIELDS
  float xAxisLength;
  float yAxisLength;
  float spacingXtick, spacingYtick;
  float xCoordYAxis, yCoordXAxis;
  float textPosition;
  
  
  // CONSTRUCTOR
  Axis() {
    // Initializes all the fields 
    this.xAxisLength = xMax - xMin;
    this.yAxisLength = yMax - yMin;
    this.spacingXtick = width/(this.xAxisLength/xScale);
    this.spacingYtick = height/(this.yAxisLength/yScale);
    this.xCoordYAxis = abs(xMin)*this.spacingXtick/xScale;
    this.yCoordXAxis = abs(yMax)*this.spacingYtick/yScale;
  }
  
  // METHODS
  // Updates the variables used in the class
  void updateValues() {
    this.xAxisLength = xMax - xMin;
    this.yAxisLength = yMax - yMin;
    this.spacingXtick = width/(this.xAxisLength/xScale);   // How long one x tick is in terms of spacing
    this.spacingYtick = height/(this.yAxisLength/yScale);  // How long one y tick is in terms of spacing
    this.xCoordYAxis = abs(xMin)*this.spacingXtick/xScale; // The x-coordinate of where the y axis is
    this.yCoordXAxis = abs(yMax)*this.spacingYtick/yScale; // The y-coordinate of where the x axis is
    
    // If the origin (0,0) is off the screen, adjust the yCoordXAxis and xCoordYAxis variables
    if (yMin > 0) {
      this.yCoordXAxis = height-20;
    }

    if (yMax < 0) {
      this.yCoordXAxis = 5;
    }
    
    if (xMin > 0) {
      this.xCoordYAxis = 7;
    }
    
    if (xMax < 0) {
      this.xCoordYAxis = width-5;
    }
  }
  
  // Draws the coordinate axis 
  void drawAxis() {
    
    // Update the values of the variables used first
    updateValues();
    strokeWeight(2);
    stroke(255, 0, 0);
   
    // Draws the X-axis
    line(0, yCoordXAxis, width, yCoordXAxis); 
    fill(255, 0, 0);
    textAlign(RIGHT);
    text("x", width-10, yCoordXAxis-3);
    
    // Draws the Y-axis
    line(xCoordYAxis, 0, xCoordYAxis, height);
    textAlign(UP);
    text("y", xCoordYAxis+3, 10);
  
    noStroke();
    fill(0);
    
    
    // Draws the ticks
    drawXAxisTicks();
    drawYAxisTicks(); 
  }
  
  
  // DRAWS TICKS ON THE X AXIS
  void drawXAxisTicks() {
    textAlign(CENTER, TOP);
    
    // If the origin is included in the range of xMin to xMax (on the screen)
    if (xMin < 0 && xMax > 0) {
      
      // DRAWS TICKS TO THE RIGHT OF THE ORIGIN
      for(int i = 0; i < (xAxisLength / xScale + 1); i++) {
        rect(xCoordYAxis + spacingXtick * i, yCoordXAxis, 2.3, 5);
        
        // Prevents it from drawing 0.0
        if(i != 0) {
          text(str(xScale*i), xCoordYAxis + spacingXtick * i, yCoordXAxis);
        }
      }
      
      // DRAWS TICKS TO THE LEFT OF THE ORIGIN
      for(int i = 0; i < (xAxisLength / xScale + 1); i++) {
        rect(xCoordYAxis + spacingXtick * -i, yCoordXAxis, 2.3, 5);
        
        // Prevents it from drawing 0.0
        if(i != 0) {
          text(str(xScale * -i), xCoordYAxis + spacingXtick * -i, yCoordXAxis);
        }
      }
    }
    
    
    // If the origin is not included in the range of xMin to xMax
    else {
      
      if(xMin > 0) {
        // DRAWS TICKS TO THE RIGHT OF THE Y AXIS
        for(int i = 0; i < (xAxisLength / xScale) + 1; i++) {
          float xPositionOfTick = xCoordYAxis + (ceil(xMin/xScale) * xScale - xMin)/xScale * spacingXtick + spacingXtick*i;
          rect(xPositionOfTick, yCoordXAxis, 2.3, 5);
          
          // Prevents it from drawing 0.0
          if(ceil(xMin/xScale) != 0) {
            text(str(ceil(xMin/xScale) * xScale + xScale * i), xPositionOfTick, yCoordXAxis);
          }
        }
      }
      
      else if(xMax < 0) {
        // DRAWS TICKS TO THE LEFT OF THE Y AXIS
        for(int i = 0; i < (xAxisLength / xScale) + 1; i++) {   
          float xPositionOfTick = xCoordYAxis - (ceil(abs(xMax)/xScale) * xScale - abs(xMax))/xScale * spacingXtick + spacingXtick*-i;
          rect(xPositionOfTick, yCoordXAxis, 2.3, 5);
          
          // Prevents it from drawing 0.0
          if(floor(xMax/xScale) != 0) {
            text(str(floor(xMax/xScale) * xScale + xScale * -i), xPositionOfTick, yCoordXAxis);
          }
        }
      }
    }
  }
  
  
  // DRAWS THE TICKS ON THE Y-AXIS 
  void drawYAxisTicks() {
    
    // Adjusting the text align based on where the axis is
    if(xMax > 0) {
      this.textPosition = 10;
      textAlign(TOP, CENTER);
    }
    
    else {
      this.textPosition = -5;
      textAlign(RIGHT, CENTER);
    }
    
    // If the origin is included in the range of yMin and yMax (included on screen)
    if (yMin < 0 && yMax > 0) {
      
      // DRAWS TICKS ABOVE THE ORIGIN
      for(int i = 0; i < (yAxisLength / yScale + 1); i++) {
        rect(xCoordYAxis, yCoordXAxis + spacingYtick*-i, 5, 2.3);
        
        // Prevents it from drawing 0.0
        if(i != 0) {
          text(str(yScale * i), xCoordYAxis + textPosition, yCoordXAxis + spacingYtick*-i);
        }
      }
      
      // DRAWS TICKS BELOW THE ORIGIN
      for(int i = 0; i < (yAxisLength / yScale + 1); i++) {
        rect(xCoordYAxis, yCoordXAxis + spacingYtick*i, 5, 2.3);
        
        // Prevents it from drawing 0.0
        if(i != 0) {
          text(str(yScale * -i), xCoordYAxis + textPosition, yCoordXAxis + spacingYtick*i);
        }
      }
    }
    
    // If the origin is not included in the range of yMin to yMax
    else {
      
      // DRAWS TICKS ABOVE THE X AXIS 
      if (yMin > 0) {
        for(int i = 0; i < (yAxisLength / yScale) + 1; i++) {
            
          float yPositionOfTick = yCoordXAxis - (ceil(yMin/yScale) * yScale - yMin)/yScale * spacingYtick - spacingYtick*i;
          rect(xCoordYAxis, yPositionOfTick, 5, 2.3);
          text(str(ceil(yMin/yScale)*yScale + yScale * (i)), xCoordYAxis + textPosition, yPositionOfTick);
        }
      }
      
      // DRAWS TICKS BELOW THE X AXIS 
      else if (yMax < 0) {
        for(int i = 0; i < (yAxisLength / yScale) + 1; i++) {
          
          float yPositionOfTick = yCoordXAxis - (floor(yMax/yScale) * yScale - yMax)/yScale * spacingYtick + spacingYtick*i;
          rect(xCoordYAxis, yPositionOfTick, 5, 2.3);
          text(str(floor(yMax/yScale) * yScale - yScale * (i)), xCoordYAxis + textPosition, yPositionOfTick);
        }
      }
    } 
  }
}
