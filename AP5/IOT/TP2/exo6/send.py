#send.py
import threading
import time
import paho.mqtt.client as mqtt


def on_mes(client, userdata, mes):
  msg=mes.payload.decode("utf-8")
  print("Received ",msg," on topic ", mes.topic)

def on_pub(client,userdata,result): 
	print("Send message")
     
def send():
	while True:
		print('send')
		global client
		client.on_publish = on_pub
		client.publish("/Junia/UserFeur/temp_piece", "25",2)
		client.publish("/Junia/UserFeur/temp_chauff", "3",2)
		client.publish("/Junia/UserFeur/temp_ext", "26",2)
		time.sleep(10)

client = mqtt.Client()
client.connect("127.0.0.1", 1883)
client.on_message = on_mes
      
sendTread = threading.Thread(target=send)
sendTread.start()

client.subscribe("/Junia/UserFeur/comm_chauff",2)
client.subscribe("/Junia/UserFeur/act_fen",2)

client.loop_forever()