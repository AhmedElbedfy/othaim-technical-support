// This script reads the file "scale.txt" and outputs the data in a format that is easier to parse.

const fs = require("fs");

// The `lines` variable stores the contents of the file as an array of strings.
const lines = fs.readFileSync("scale.txt").toString().split("\n");
console.log(lines)

// The `highestLength` variable stores the length of the longest number sequence in the file.
let highestLength = 0;

// The `output` variable stores the output of the script.
let output = "";

// This loop iterates over the lines in the file and calculates the length of the longest number sequence.
for (const line of lines) {
    const length = line.split(" ")[0].length;
    if (length > highestLength) {
        highestLength = length;
    }
}

// This loop iterates over the lines in the file and pads the number sequences with zeros so that they are all the same length.
for (const line of lines) {
    // Check if the line is empty. If it is, break out of the loop.
    if (line === "") break;

    // Split the line into an array of strings, where each string is a string sequence.
    const lineArray = line.split(" ")

    // Get the first number sequence in the line.
    let paddedNumber = lineArray[0];

    // While the length of the number sequence is less than the highest length, pad it with zeros.
    while (paddedNumber.length < highestLength) {
        paddedNumber += "0";
    }

    // Add the padded number sequence to the output.
    output += paddedNumber + " ";

    // Add the rest of the data in the line to the output.
    for (const [seqIndex, sequence] of lineArray.entries()) {
        if (seqIndex !== 0 && seqIndex !== (lineArray.length - 1)) {
            output += sequence + " "
        } else if (seqIndex === (lineArray.length - 1)) {
            output += sequence
            // TEST INCASE OF ERROR EXIT BECAUSE OF THE "\r" 
            // output += sequence.replace(/\r/g, "\n")
        }
    }

    // Save the rest of the data easier way
    // output += line.split(" ")[1] + " " + line.split(" ")[2] + " " + line.split(" ")[3] + " " + line.split(" ")[4];
}

// Create a new file and write the output to the file.
const newFile = fs.createWriteStream("scale.txt");
newFile.write(output);
newFile.close();

// Log a message to the console indicating that the file was created successfully.
console.log("the file Created Successfully (^///^)");