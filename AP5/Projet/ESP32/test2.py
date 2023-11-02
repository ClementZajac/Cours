import time
from machine import Timer
from umqttsimple import MQTTClient  # Remplacez "your_mqtt_module" par le nom réel du module où vous avez défini MQTTClient

def on_mes(topic, msg):
    print("Received", msg, "on topic", topic)

def on_pub(topic, msg):
    print("Send message")

def send():
    print('send')
    client.publish("/Junia/UserFeur/temp_piece", "00", qos=2)
    client.publish("/Junia/UserFeur/temp_chauff", "01", qos=2)
    client.publish("/Junia/UserFeur/temp_ext", "02", qos=2)

print("Start of program...")

client = MQTTClient("client", "10.224.1.91")
# client = MQTTClient("client", "127.0.0.1")
client.set_callback(on_mes)
client.connect(clean_session=True)
send()

# timer = Timer(-1)
# timer.init(period=10000, mode=Timer.PERIODIC, callback=send)

# client.subscribe("/Junia/UserFeur/comm_chauff", qos=2)
# client.subscribe("/Junia/UserFeur/act_fen", qos=2)

# while True:
#   #client.check_msg()  # Attend et traite les messages MQTT
print("End of the program.")

# from machine import Pin, ADC
# import utime

# try:
#     adc = ADC(Pin(35))  # Utilisez le numéro de broche 3 pour GPIO0 (G0)
#     for counter in range(20):
#         value = adc.read()
#         if value is not None:
#             print("A0.read()=", value)
#         else:
#             print("Failed to read ADC value")
#         utime.sleep_ms(100)
# except Exception as e:
#     print("An error occurred:", e)

# print("Program End")
