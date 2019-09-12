class CA {
  int[] cells; // array for cells
  int generation; // track generations
  //int[] ruleset = {0, 1, 0, 1, 1, 0, 1, 0}; // rule 90 to start
  //int[] ruleset = {0, 0, 1, 1, 1, 1, 1, 0}; // rule 62 to start
  int[] ruleset = {0, 0, 0, 0, 1, 1, 1, 1};
  //int[] ruleset = {0, 1, 0, 0, 1, 1, 1, 1};

  // here you can define variables for size, color etc.
  int cellSizeX = 10;
  int cellSizeY = 10;
  color colorA = color(255, 255, 0);
  color colorB = color(255, 0, 255);


  CA() {
    cells = new int[width/cellSizeX]; // calculate how many cells based on sketch width/cellSize
    restartCenter(); // set all to 0 exept center cell to 1
  }

  // draw the cells here!
  void display() {
    for (int i = 0; i < cells.length; i++) {
      // check if cell is dead or alive
      if (cells[i] == 0) {
        // dead cell
        fill(0);
        arc(i*cellSizeX, generation*cellSizeY, cellSizeX, cellSizeY, PI, TWO_PI);
      } else {
        // alive cell
        int a = int(random(2)); // define the probability (how often a color is chosen)
        if (a == 0) {
          fill(colorA);
        } else {
          fill(colorB);
        }
      }
      rect(i*cellSizeX, generation*cellSizeY, cellSizeX, cellSizeY);
    }
  }

  void randomRule() { // Make a random ruleset
    for (int i = 0; i < ruleset.length; i++) {
      ruleset[i] = int(random(2));
    }
    // print which rule was generated
    println("random rule: ", ruleset[0], ruleset[1], ruleset[2], ruleset[3], ruleset[4], ruleset[5], ruleset[6], ruleset[7]);
  }

  void restartCenter() { // all cells start with 0, exept center cell with 1
    for (int i = 0; i < cells.length; i++) {
      cells[i] = 0;
    }
    cells[cells.length/2] = 1;
    generation = 0;
  }

  void restartRandom() { // all cells start with a random value of 0 or 1
    for (int i = 0; i < cells.length; i++) {
      cells[i] = int(random(2));
    }
    generation = 0;
  }

  void generate() { // create the next generation
    // create an empty array for the next generation of cells
    int[] nextGen = new int[cells.length];
    // look at every current cell and find it's neighboor
    for (int i = 1; i < cells.length-1; i++) {
      int leftNeighboor = cells[i-1];
      int theCell = cells[i];
      int rightNeighboor = cells[i+1];
      // check the rule if the next generation cell is 0 or 1
      nextGen[i] = rules(leftNeighboor, theCell, rightNeighboor);
    }
    cells = nextGen; // The current generation becomes the new generation
    generation++; // new gen = one more row (y of rect is incremented)
  }

  // check how the next generations if computed
  int rules (int a, int b, int c) {
    if (a == 1 && b == 1 && c == 1) return ruleset[0];
    if (a == 1 && b == 1 && c == 0) return ruleset[1];
    if (a == 1 && b == 0 && c == 1) return ruleset[2];
    if (a == 1 && b == 0 && c == 0) return ruleset[3];
    if (a == 0 && b == 1 && c == 1) return ruleset[4];
    if (a == 0 && b == 1 && c == 0) return ruleset[5];
    if (a == 0 && b == 0 && c == 1) return ruleset[6];
    if (a == 0 && b == 0 && c == 0) return ruleset[7];
    return 0;
  }

  // The CA is done if it reaches the bottom of the screen
  boolean finished() {
    if (generation > height/cellSizeY) {
      return true;
    } else {
      return false;
    }
  }
}
