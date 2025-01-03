
import sys
import json
import psycopg2
from google.cloud import sql_v1beta4

# --------------------------------------------------------------------------- #
# --------------------------------------------------------------------------- #

def create_tables(gcp_client_email,
                  project_id,
                  instance_id,
                  db_name,
                  table_name,
                  columns):
    """

    """

    # Create a Cloud SQL client
    client = sql_v1beta4.SqlInstancesClient()

    # Get the instance connection name
    instance = client.get_instance({"project": project_id,
                                    "instance": instance_id})
    connection_name = instance.connection_name

    # Connect to the database
    conn = psycopg2.connect(
        host=f'/cloudsql/{connection_name}',
        dbname=db_name,
        user=gcp_client_email,
    )

    # Create a cursor
    cur = conn.cursor()

    # Construct the CREATE TABLE query
    column_definitions = []
    for column in columns:
        definition = f"{column['name']} {column['type']}"
        if column.get('constraints'):
            definition += f" {' '.join(column['constraints'])}"

    create_table_query = f"""
        CREATE TABLE {table_name} ({', '.join(column_definitions)});"""

    # Execute the CREATE TABLE query
    cur.execute(create_table_query)

    # Commit the changes
    conn.commit()

    # Close the cursor and connection
    cur.close()
    conn.close()

if __name__ == "__main__":
   
    gcp_client_email = sys.argv[0]
    project_id = sys.argv[1]
    instance_id = sys.argv[2]
    db_name = sys.argv[3]
    table_name = sys.argv[4]
    columns_json = sys.argv[5]
    columns = json.loads(columns_json)
    
    create_tables(gcp_client_email, project_id, instance_id, db_name, table_name, columns)

