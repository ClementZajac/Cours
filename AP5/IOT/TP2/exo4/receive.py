#receive.py
import paho.mqtt.client as mqtt

message_piece = ""  # Initialisez avec la valeur souhaitée
message_chauff = ""   # Initialisez avec la valeur souhaitée
message_ext = "" # Initialisez avec la valeur souhaitée

def reset():
    global message_piece, message_chauff, message_ext
    message_piece = ""
    message_chauff = ""
    message_ext = ""

def on_pub(client, userdata, result):
    print("Message publié")

def on_mes(client, userdata, mes):
    msg = mes.payload.decode("utf-8")
    print("Reçu :", msg, "sur le sujet :", mes.topic)
    global message_piece, message_chauff, message_ext
    if mes.topic == "/Junia/UserFeur/temp_piece":
      message_piece = float(msg)
    elif mes.topic == "/Junia/UserFeur/temp_chauff":
       message_chauff = float(msg)
    elif mes.topic == "/Junia/UserFeur/temp_ext":
      message_ext = float(msg)

    if isinstance(message_piece, float) and isinstance(message_chauff, float) and isinstance(message_ext, float):
      if message_piece >= 25:
        client.publish("/Junia/UserFeur/comm_chauff", "ferme le chauffage", 2)
      if message_ext >= message_piece:
        client.publish("/Junia/UserFeur/act_fen", "ouvre la fenêtre", 2)
        reset()
    else:
      client.publish("/Junia/UserFeur/feur", "erreur", 2)

client = mqtt.Client()
client.on_message = on_mes
client.on_publish = on_pub
client.connect("127.0.0.1", 1883)
client.subscribe("/Junia/UserFeur/temp_piece", 2)
client.subscribe("/Junia/UserFeur/temp_chauff", 2)
client.subscribe("/Junia/UserFeur/temp_ext", 2)

client.loop_forever()