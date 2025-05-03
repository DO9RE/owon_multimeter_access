# Owon Multimeter Access

This script utilizes the repository [Owon-Multimeters](https://github.com/sercona/Owon-Multimeters) to provide easy access to digital multimeters from the company Owon. The focus during development was on ensuring ease of use for blind or severely visually impaired users who rely on screen readers in Linux.

## Features

The script offers the following functionality when started with `./start.sh`:

1. **Retrieve a measurement**:
   - Press any key to fetch a value from the multimeter, which is displayed in the console.
   - If a screen reader is running, it will automatically read the value aloud.
   - The script is designed to accept almost any key press, enabling the use of an optional foot pedal that can send key inputs. This allows you to keep your hands free for working with the object being measured.

2. **Select a device (Press 'S')**:
   - Press the `S` key to select a multimeter via its Bluetooth LE address.
   - The Bluetooth environment is scanned for 10 seconds. Turn your device into Bluetooth mode and select your multimeter from the menu using the corresponding number.
   - The selected address is directly written into the script (self-modifying code).

3. **Exit the script (Press 'Q')**:
   - Press the `Q` key to exit the script.

## Automatic Setup

When started, the script checks if the repository [Sercona/Owon-Multimeters](https://github.com/sercona/Owon-Multimeters) has already been downloaded. If not:
- It automatically clones the repository.
- It compiles the required C file to ensure proper operation.

## Usage

1. Ensure all dependencies like `git`, `make`, and `awk` are installed.
2. Download the script and make it executable:
   ```bash
   chmod +x start.sh

### Feedback

Feedback and ideas go to do9re@hotmail.com

