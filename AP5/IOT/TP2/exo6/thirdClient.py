#receive.py
import paho.mqtt.client as mqtt
import threading
import time

message_piece = ""  # Initialisez avec la valeur souhaitée
message_chauff = ""   # Initialisez avec la valeur souhaitée
message_ext = "" # Initialisez avec la valeur souhaitée

manual_heating = "OFF"
window_state = "CLOSE"
automatic_control_state = "OFF"

room_temp_from_last_minute = list()

def reset():
    global message_piece, message_chauff, message_ext
    message_piece = ""
    message_chauff = ""
    message_ext = ""


def on_pub(client, userdata, result):
    print("Message publié")

def on_mes(client, userdata, mes):
    msg = mes.payload.decode("utf-8")
    #print("Reçu :", msg, "sur le sujet :", mes.topic)
    global message_piece, message_chauff, message_ext
    if mes.topic == "/Junia/UserFeur/temp_piece":
      message_piece = float(msg)
    elif mes.topic == "/Junia/UserFeur/temp_chauff":
       message_chauff = float(msg)
    elif mes.topic == "/Junia/UserFeur/temp_ext":
      message_ext = float(msg)

def menu():
  while True:

    time.sleep(1)
    global manual_heating, window_state
    print()
    print("Temperature in the room: ", message_piece)
    print("Temperature outside: ", message_ext)
    print("Temperature of the heating: ", message_chauff)
    print()
    print("Type a number to choose an option:")
    print()
    print(" 0 - Refresh")
    print(" 1 - Turn ON/OFF the manual heating")
    print("     Manual heating is currently: ", manual_heating)
    print(" 2 - OPEN/CLOSE the window")
    print("     Window is currently: ", window_state)
    print(" 3 - Set the desired temperature")
    print("     Desired temperature is currently: ", message_chauff)
    print(" 4 - Turn ON/OFF the automatic control")
    print("     Automatic control is currently: ", automatic_control_state)
    
    print()
    #print surent state

    choice = input("Your choice: ")
    match choice:
      case "0":
        print("Refresh...")
      case "1":
        if manual_heating == "OFF":
          manual_heating = "ON"
        else:
          manual_heating = "OFF"

        print("Manual heating set to: ", manual_heating)
        client.publish("/Junia/UserFeur/com_heating", manual_heating, 2)
      case "2":
        if window_state == "CLOSE":
          window_state = "OPEN"
        else:
          window_state = "CLOSE"

        print("Window is now: ", window_state)
        client.publish("/Junia/UserFeur/act_window", window_state, 2)
      case "3":
        desired_temp = input("Enter the desired temperature: ")
        print("Desired temperature set to: ", desired_temp)
        client.publish("/Junia/UserFeur/temp_chauff", desired_temp, 2)
      case "4":
        if automatic_control_state == "OFF":
          automatic_control_state = "ON"
        else:
          automatic_control_state = "OFF"

        print("Automatic control set to: ", automatic_control_state)



client = mqtt.Client()
client.on_message = on_mes
client.on_publish = on_pub
client.connect("127.0.0.1", 1883)
client.subscribe("/Junia/UserFeur/temp_piece", 2)
client.subscribe("/Junia/UserFeur/temp_chauff", 2)
client.subscribe("/Junia/UserFeur/temp_ext", 2)

      
sendTread = threading.Thread(target=menu)
sendTread.start()

client.loop_forever()


# MQTT LAB
# Exercise 6:
# Extend the existing system to allow for remote and manual control. 
# Specifically, add a third client that can publish to the /Junia/Userxx/com_heating and 
# /Junia/Userxx/act_window topics. This third client should allow the user to set the desired 
# temperature for the room and allow the user to manually turn on or off the heating and window.
# We should have a temperature reading every 10 seconds.
# 1. The third client should be able to publish to the /Junia/Userxx/com_heating topic to turn on 
# or off the heating manually. The payload for this topic should be either "ON" or "OFF". 
# 2. The third client should be able to publish to the /Junia/Userxx/act_window topic to manually 
# open or close the window manually. The payload for this topic should be either "OPEN" or 
# "CLOSE". 
# 3. The third client should be able to set a desired temperature for the room. The payload 
# should be a float representing the desired temperature in degrees Celsius. 
# 4. The third client should be able to subscribe to the necessary topics to receive updates on the 
# current temperatures. 
# 5. The third client should implement a simple function while calling an external python module
# to automatically turn on or off the heating based on the difference between the current room 
# temperature and the desired room temperature. Specifically, if the average room temperature 
# for the last 60 seconds is more than 1 degree Celsius below the desired temperature, the heating 
# should be turned on. If the current room temperature is more than 1 degree Celsius above the 
# desired temperature, the heating should be turned off. If the difference is within 1 degree 
# Celsius, the heating should be left in its current state. 
# 6. You should write the necessary code in the client 3 to ask the user if he wants to manually 
# command the heater and/or window or activate the automatic control. You should also allow the 
# client 3 to set his desired temperature and change it whenever he wants. 