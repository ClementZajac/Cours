from umqtt.simple import MQTTClient
#import time

# Définir les informations de connexion MQTT
#mqtt_server = "10.224.1.91"  # Adresse IP du broker MQTT
mqtt_server = "127.0.0.1"
client_id = "esp32-client"  # Identifiant du client MQTT
topic = "test"  # Topic MQTT sur lequel envoyer les données

# Créer une instance du client MQTT
client = MQTTClient(client_id, mqtt_server)

# Fonction pour envoyer la donnée
def send_data():
    # Se connecter au broker MQTT
    client.connect()

    # Donnée à envoyer
    data_to_send = "Hello, MQTT!"

    # Publier la donnée sur le topic "test"
    client.publish(topic, data_to_send)
    
    send_data()
    # Se déconnecter du broker MQTT
    client.disconnect()

send_data()
# Boucle pour envoyer la donnée toutes les 10 secondes
#while True:
    #send_data()
    #time.sleep(10)  # Pause de 10 secondes avant le prochain envoi

