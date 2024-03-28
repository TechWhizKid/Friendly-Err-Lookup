<#
# =====================================
#        Script Author: TechWhizKid
#        Github.com/TechWhizKid
# =====================================
#            Version: 1.0.0
# =====================================

# The script uses the Error Lookup Tool (err.exe) to decode error codes
# and provide detailed descriptions. It saves the output to a temporary
# file and formats the output to a more clean and readable format.
#>

# Set the path to the Error Lookup Tool (err.exe)
$ErrorTool = ".\err.exe"  # Provide the correct path to err.exe

# Check if the Error Lookup Tool exists
if (-not (Test-Path $ErrorTool)) {
    Write-Host ""
    Write-Host "### Error ### : $ErrorTool not found. Either rename the .exe file to match or change the name in this script file."
    Write-Host "You can get the Error Lookup Tool from here: https://www.microsoft.com/en-us/download/details.aspx?id=100432"
    Write-Host ""
    exit
}

# Execute the Error Lookup Tool with the provided argument and save the output to a temporary file
& $ErrorTool $args[0] | Out-File -FilePath temp.txt
Write-Host ""

# Initialize variables for skipping lines and tracking the previous line
$skipNext = $false
$previousLine = "--start--"

# Read the content of the temporary file and process each line
Get-Content -Path temp.txt | ForEach-Object {
    $line = $_

    # Check if the line indicates no results found
    if ($line -match "# No results found for") {
        Write-Host "* $($line.Substring(2)) (as base error lookup)"
    }
    # Check if we need to skip the next line
    elseif ($skipNext) {
        $skipNext = $false
    }
    # Check if the line indicates an error code description
    elseif ($line -match "# for ") {
        # Add extra spacing if the previous line was not an HRES description
        if ($previousLine -notmatch "# as an HRES") {
            Write-Host ""
        }
        Write-Host "======================================= $($line.Substring(2)) ======================================="
    }
    # Check if the line indicates an HRES description
    elseif ($line -match "# as an HRES") {
        Write-Host ""
        Write-Host ""
        Write-Host "================== $($line.Substring(2)) =================="
    }
    # Check if the line starts with a hash (#) and provide additional details
    elseif ($line -match "^# ") {
        Write-Host "      --> $($line.Substring(2))"
    }
    # Display other non-empty lines
    elseif ($line -ne "") {
        Write-Host $line
    }

    # Update the previous line
    $previousLine = $line
}

# Display a separator at the end
Write-Host ""
Write-Host "-------------------------------------------------------------------------"

# Clean up: Remove the temporary file
Remove-Item -Path temp.txt
