import os
import json
from google.cloud.sql.connector import Connector
import pg8000

def connect_with_connector(credentials_info):
    """  
    credentials_json = os.environ.get('TF_VAR_gcp_credentials')
    if not credentials_json:
        raise ValueError("TF_VAR_gcp_credentials environment variable is not set")
    credentials_info = json.loads(credentials_json)
    """

    instance_connection_name = "dev-datalake-instance"
    db_user = "dev-astronomer@astronomer-88.iam.gserviceaccount.com"
    db_name = "dev-datalake-db"

    gcp_credentials = json.loads(os.environ['gcp_credentials'])
    private_key = gcp_credentials['private_key']

    connector = Connector()

    def getconn():
        conn = connector.connect(
            instance_connection_name,
            "pg8000",
            user=db_user,
            db=db_name,
            enable_iam_auth=True,
            credentials=private_key
        )
        return conn

    return getconn

def modify_user(target_user, credentials_user):
    conn = connect_with_connector(credentials_user)()
    with conn.cursor() as cur:
        cur.execute(f"ALTER ROLE {target_user} WITH CREATEDB CREATEROLE;")
        cur.execute(f"GRANT SELECT, CONNECT, EXECUTE ON ALL TABLES IN SCHEMA public TO {target_user};")
    conn.commit()
    conn.close()

if __name__ == "__main__":
    import sys
    modify_user(sys.argv[0], sys.argv[1])
