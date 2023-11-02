from machine import Pin, ADC

def detect_connected_pin():
    for pin_number in range(40):  # Balayez les broches GPIO de 0 à 39
        try:
            adc = ADC(Pin(pin_number))
            value = adc.read()
            if value > 100:  # Ajustez cette valeur en fonction de votre capteur
                print("Capteur détecté sur la broche GPIO", pin_number)
                return
        except Exception as e:
            pass

    print("Aucun capteur détecté sur les broches GPIO 0-39")

detect_connected_pin()

