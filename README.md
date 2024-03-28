# Friendly-Err-Lookup

**_PowerShell Script to decode error codes using "Err"_**

### Overview

_This PowerShell script provides a convenient way to decode error codes using the Error Lookup Tool (`err.exe`). It displays detailed descriptions for error codes._

### Usage

1. Place the `err.exe` executable in the same directory as the script.
2. Run the script with an error code as an argument:
   ```bash
   .\Friendly-Err-Lookup.ps1 0x50
   ```
   Replace `0x500` with the desired error code.

### Note

- If `err.exe` is not found, the script will provide instructions to download it.
