// An array of 0s and 1s
let cells;

// We arbitrarily start with just the middle cell having a state of "1"
let generation = 0;

// An array to store the ruleset, for example {0,1,1,0,1,1,0,1}
let ruleset = [0, 1, 1, 0, 1, 0, 0, 1];

let cellSizeX = 20;
let cellSizeY = 10;

function setup() {
	createCanvas(800, 800);

	noStroke();
	background(0);

	cells = Array(floor(width / cellSizeX));
	for (let i = 0;i < cells.length;i++) {
		cells[i] = 0;
	}
	cells[cells.length / 2] = 1;
	generation = 0;


}

function draw() {
	if (!finished()) {
		display(); // Draw the CA
		generate(); // generate next generation
	}
}

function display() {
	for (let i = 0;i < cells.length;i++) {
		// check if cell is dead or alive
		if (cells[i] === 0) {
			// dead cell
			fill(0);
			ellipse(i*cellSizeX, generation*cellSizeY, cellSizeX, cellSizeY);
		} else {
			// alive cell
			let a = int(random(2)); // define the probability (how often a color is chosen)
			if (a == 0) {
				fill(255, 255, 0);
			} else {
				fill(0, 0, 255);
			}
		}
		rect(i * cellSizeX, generation * cellSizeY, cellSizeX, cellSizeY);
	}
}

function randomRule() { // Make a random ruleset
	for (let i = 0;i < ruleset.length;i++) {
		ruleset[i] = int(random(2));
	}
	// print which rule was generated
	console.log("random rule: ", ruleset[0], ruleset[1], ruleset[2], ruleset[3], ruleset[4], ruleset[5], ruleset[6], ruleset[7]);
}

function restartRandom() { // all cells start with a random value of 0 or 1
	for (let i = 0;i < cells.length;i++) {
		cells[i] = int(random(2));
	}
	generation = 0;
}

// The process of creating the new generation
function generate() {
	// First we create an empty array for the new values
	let nextGen = Array(cells.length);
	// For every spot, determine new state by examing current state, and neighbor states
	// Ignore edges that only have one neighor
	for (let i = 1;i < cells.length - 1;i++) {
		let leftNeighboor = cells[i - 1];
		let theCell = cells[i];
		let rightNeighboor = cells[i + 1];
		// check the rule if the next generation cell is 0 or 1
		nextGen[i] = rules(leftNeighboor, theCell, rightNeighboor);
	}
	// The current generation is the new generation
	cells = nextGen;
	generation++;
}


// Implementing the Wolfram rules
// Could be improved and made more concise, but here we can explicitly see what is going on for each case
function rules(a, b, c) {
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

function finished() {
	if (generation > height / cellSizeY) {
		return true;
	} else {
		return false;
	}
}


function mousePressed() {
	background(0);
	randomRule();
	restartRandom();
}