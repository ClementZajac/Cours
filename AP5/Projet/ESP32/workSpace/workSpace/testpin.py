from machine import Pin, ADC
import utime

try:
    adc = ADC(Pin(35))  # Remplacez le numéro de broche par le numéro de la broche sur laquelle vous avez connecté le capteur
    for counter in range(20):
        value = adc.read()
        if value is not None:
            print("A0.read()=", value)
        else:
            print("Failed to read ADC value")
        utime.sleep_ms(100)
except Exception as e:
    print("An error occurred:", e)

print("Program End")

