#!/usr/bin/env python

import time
from grovepi import *

# Connect the Grove LED to digital port D5
led = 4

# Connect the Grove Rotary Angle sensor to analog port A2
potentiometer = 2

pinMode(led, "OUTPUT")
time.sleep(1)

print("This example will adjust the brightness of a Grove LED connected to the GrovePi+ on port D5.")
print("Turn the potentiometer to adjust the LED brightness.")
print("")

while True:
    try:
        # Read the potentiometer value
        pot_value = analogRead(potentiometer)
        
        # Adjust the LED brightness
        analogWrite(led, pot_value)

        # Print the potentiometer value
        print(f"Potentiometer Value: {pot_value}")

    except KeyboardInterrupt:
        analogWrite(led, 0)  # Turn off the LED before stopping
        break
    except IOError:
        print("Error")
