import paho.mqtt.client as mqtt

def on_mes(client, userdata, mes):
  msg=mes.payload.decode("utf-8")
  print("Received ",msg," on topic ", mes.topic)

def on_pub(client,userdata,result): 
	print("Send message")
	#client.loop_stop()
	#client.disconnect()
	

client = mqtt.Client()

client.on_publish = on_pub
client.connect("127.0.0.1", 1883)
client.publish("/Junia/UserFeur/temp_piece", "25",2)
client.publish("/Junia/UserFeur/temp_chauff", "30",2)
client.publish("/Junia/UserFeur/temp_ext", "10",2)

client.on_message = on_mes
client.subscribe("/Junia/UserFeur/comm_chauff",2)
client.subscribe("/Junia/UserFeur/act_fen",2)

client.subscribe("feur",2)

client.loop_forever()


True


"""
The subscribe() function indicates to which topic we want to 
subscribe, then via loop_forever() we wait and process the MQTT 
events.
In this example, we create a function on_mes() which will be called 
as soon as the message reception event takes place (i.e. 
client.on_message = on_mes). In the function after decoding the 
message and displaying it, we stop the event processing loop and 
disconnect client.loop_stop() and client.disconnect() (like in the 
first example)
"""
import paho.mqtt.client as mqtt
def on_mes(client, userdata, mes):
  msg=mes.payload.decode("utf-8")
  print("Received ",msg," on topic ", mes.topic)
  client.loop_stop()
  client.disconnect()
client = mqtt.Client()
client.on_message = on_mes
client.connect("127.0.0.1", 1883)
client.subscribe("#",2)
client.loop_forever()
