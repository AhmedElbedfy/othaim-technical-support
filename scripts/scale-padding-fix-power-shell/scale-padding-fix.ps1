# This script reads the file "scale.txt" and outputs the data in a format that is easier to parse.

# Create an array to store the contents of the file.
# The `@()` symbol creates an empty array.
$lines = @()

# This loop iterates over the lines in the file and adds them to the array.
# The `Get-Content` cmdlet reads the contents of a file and returns them as an array.
try {
    foreach ($line in Get-Content "scale.txt") {
        # Add the line to the array.
        $lines += $line
    }
}
catch {
    # If an error occurs, display a message to the user and exit the script.
    Write-Host "An error occurred while reading the file."
    exit
}

# Calculate the length of the longest number sequence in the file.
# The `Split()` method splits a string into an array of strings based on a delimiter.
# The `Length` property returns the length of a string.
$highestLength = 0
foreach ($line in $lines) {
    # Get the length of the first number sequence in the line.
    $length = $line.Split(" ")[0].Length

    # If the length is greater than the current highest length, update the highest length.
    if ($length -gt $highestLength) {
        $highestLength = $length
    }
}

# This loop iterates over the lines in the file and pads the number sequences with zeros so that they are all the same length.
# The `Split()` method splits a string into an array of strings based on a delimiter.
# The `PadRight()` method pads a string with a specified number of characters on the right side.
foreach ($line in $lines) {
    # If the line is empty, break out of the loop.
    if ($line -eq "") {
        break
    }

    # Get the array of number sequences in the line.
    $lineArray = $line.Split(" ")

    # Get the first number sequence in the array.
    $paddedNumber = $lineArray[0]

    # Pad the number sequence with zeros so that it is the same length as the highest length.
    $paddedNumber = $paddedNumber.PadRight($highestLength, "0")

    # Iterate over the number sequences in the array.
    foreach ($sequence in $lineArray) {
        # If the current sequence is the same as the first sequence, add it to the output string.
        if ($sequence -eq $lineArray[0]) {

            $output += $paddedNumber + " "
        }
        else {
            # Otherwise, add the current sequence to the output string.
            $output += $sequence + " "
        }
    }
    # Add a newline character to the output string.
    $output += [Environment]::NewLine
}

# Write the output to a file.
# The `outputFile` variable specifies the name of the output file.
$outputFile = "output.txt"
if ($outputFile) {
    # Create a new `StreamWriter` object.
    $newFile = New-Object -TypeName System.IO.StreamWriter $outputFile
    # Write the output string to the file.
    $newFile.WriteLine($output)
    # Close the file.
    $newFile.Close()
}

# Log the output of the script.
# The `Write-Host` cmdlet displays a message to the user.
Write-Host "The output of the script has been written to the file $outputFile."
