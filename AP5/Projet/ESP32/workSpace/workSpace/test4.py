from machine import Pin, ADC
import utime

adc = ADC(0)
for counter in range(0, 10):
  print("A0.read()=", add.read())
  time.sleep_ms(0.1)

print("Program End")

