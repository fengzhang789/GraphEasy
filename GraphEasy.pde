// COURSE: ICS 4UI
// PROGRAMMER: Feng Zhang
// DATE: JAN 27, 2023 
// DESCRIPTION: GraphEasy is a graphing calculator that shows the tangent line to the graph.
//              Users are able to graph the function of their choice, as long as it's explicitly defined.
//              Users can click on any point on the graph to lock the tangent in place. 
//              README.txt contains a range of acceptable inputs. 

import g4p_controls.*;
import java.awt.Font;

// INITIALIZING GLOBAL VARIABLES
String equation = "0"; 

String demo_1 = "-2*cos((x^3)/(x^2+10))";
String demo_2 = "e^(cosx + sinx)*sqrt(x/e)";
String demo_3 = "(e*cos(x^2))/((1-tanx)^(cosx))";

float xMax = 5;
float xMin = -5;
float yMax = 5;
float yMin = -5;
float xScale = 1;
float yScale = 1;
float adjustmenty = 0;
float adjustmentx = 0;

Axis coordinateAxis;
Graph graph;

PFont font;
Font titleFont = new Font("Serif", Font.PLAIN, 24);
Font labelFont = new Font("Serif", Font.PLAIN, 16);

PVector initialCoordinates;
PVector finalCoordinates;
PVector displacement;

Boolean mouseDown = false;
Boolean graphClicked = false;
boolean tangentLocked = false; 
Boolean updatingValues = false;
Boolean updatingGraph = false;

String[] priorityFile;
String[] errorFile;
HashMap<String, Integer> priorities = new HashMap<String, Integer>();  // Making a hashmap of operator priorities


// Initializes classes and sets up the program
void setup() {
  size(600, 600);
  frameRate(30);
  priorityFile = loadStrings("priorities.txt");
  errorFile = loadStrings("Error Messages.txt");
  
  // SETS UP THE GUI
  createGUI();
  updateGUIvalues();
  setSettingsForGUI();
  equationField.setText(equation);
  
  // Initialize the coordinate axis and graph
  coordinateAxis = new Axis();
  graph = new Graph(equation);
    
  font = createFont("Times New Roman", 18);
  textFont(font);
  rectMode(CENTER);
  
  loadFiles();
}


void draw() {
  background(255);
  
  // Draws the coordinate axis
  coordinateAxis.drawAxis();
  
  // Draws the graph, its tangent line and the labels on screen
  graph.drawGraph();
  graph.drawTangentLine();
  graph.drawLabels();
  graph.displayMousePosition();
  
  // Updates the adjustment global variables
  // These are used to keep properly update points on the graph when shifting the axis
  updateAdjustment();
}
