
import os
from google.cloud import pubsub_v1
from google.protobuf.timestamp_pb2 import Timestamp
import message_pb2
import time
import argparse

# -- --------------------------------------------------------------------- -- #
# -- --------------------------------------------------------------------- -- #

def handshake_pubsub(in_project_id, in_topic_id):
    """

    """
    
    # GCP project and topic details
    # project_id = "your-project-id"
    # topic_id = "your-topic-id"

    # Initialize the Pub/Sub publisher client
    publisher = pubsub_v1.PublisherClient()
    topic_path = publisher.topic_path(in_project_id, in_topic_id)

    return {'pub': publisher, 'topic': topic_path}


# -- --------------------------------------------------------------------- -- #
# -- --------------------------------------------------------------------- -- #

def publish_proto_message(ps_data, ms_data):
    """

    """
      
    # Create a new SensorData message
    sensor_data = message_pb2.SensorData()
    sensor_data.device_id = ms_data['device_id']
    sensor_data.temperature = ms_data['temperature']
    sensor_data.humidity = ms_data['humidity']
    sensor_data.timestamp = int(time.time())

    # Serialize the message to a binary string
    serialized_message = sensor_data.SerializeToString()

    # Publish the message
    future = ps_data['publisher'].publish(
        ps_data['topic'], 
        serialized_message, 
        encoding='PROTOCOL_BUFFER'
    )
    
    print(f"Published message ID: {future.result()}")

# -- --------------------------------------------------------------------- -- #
# -- --------------------------------------------------------------------- -- #

if __name__ == "__main__(args)":

    parser = argparse.ArgumentParser(description="Parse input args:")
    parser.add_argument("project_id", help="GCP project ID")
    parser.add_argument("topic_id", help="Pub/Sub topic ID")
    args = parser.parse_args()

    in_project_id = args.project_id
    in_topic_id = args.topic_id

    ps_data = handshake_pubsub(in_project_id, in_topic_id)
    ms_data = {'device_id': 1, 'temperature': 2, 'humidity': 3}
    publish_proto_message(ps_data, ms_data)

