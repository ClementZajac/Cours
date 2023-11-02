# send.py
import paho.mqtt.client as mqtt


def on_mes(client, userdata, mes):
    msg = mes.payload.decode("utf-8")
    print("Received ", msg, " on topic ", mes.topic)


def on_pub(client, userdata, result):
    print("Send message")


client = mqtt.Client()

client.on_publish = on_pub
# client.connect("127.0.0.1", 1883)
client.connect("10.34.161.21", 1883)
client.publish("/Junia/UserFeur/temp_piece", "001", 2)
client.publish("/Junia/UserFeur/temp_chauff", "002", 2)
client.publish("/Junia/UserFeur/temp_ext", "003", 2)

client.on_message = on_mes
client.subscribe("/Junia/UserFeur/comm_chauff", 2)
client.subscribe("/Junia/UserFeur/act_fen", 2)

client.subscribe("feur", 2)

client.loop_forever()
