import pymysql
from config import get_db_config
import os


# Use this whenever you need to talk to the DB
def get_connection():

    config = get_db_config()
    connection = pymysql.connect(**config)
    return connection

def create_database():
    # NOTE: Commenting this out because for RDS you normally create the database once,
    # and then manage schema changes with migrations (SQL files) from the repo.
    # Keeping it here just in case you ever need it again. - Maria 1/26/26
    """"

    # Get config but remove the database name since we're creating it
    config = get_db_config()
    config.pop('database')  # Can't connect to a DB that doesn't exist yet!
    
    # Connect without specifying a database
    conn = pymysql.connect(**config)
    cursor = conn.cursor()
    
    # Create the database (IF NOT EXISTS means it won't error if it's already there)
    cursor.execute("CREATE DATABASE IF NOT EXISTS printosdatabase")
    conn.commit()
    
    # Clean up
    cursor.close()
    conn.close()
    print("Database created")
    """
    pass

def create_table():
    # NOTE: Commenting this out because we're switching to SQL migration files in db/migrations/.
    #Leaving it here just in case - Maria 1/26/26
    """

    conn = get_connection()
    cursor = conn.cursor()
    
    # Table structure:
    # - id: auto-incrementing primary key
    # - event: text description of what happened
    # - created_at: automatically set to current time when inserted
    query = 
    CREATE TABLE IF NOT EXISTS timestamps (
        id INT AUTO_INCREMENT PRIMARY KEY,
        event VARCHAR(255),
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    )
    
    cursor.execute(query)
    conn.commit()
    
    # Always close your connections!
    cursor.close()
    conn.close()
    """
    pass

def run_migrations(migrations_dir="db/migrations"):
    # 1) Make sure the folder exists
    if not os.path.isdir(migrations_dir):
        print("Missing migrations folder:", migrations_dir)
        return

    # 2) Get all .sql files
    files = os.listdir(migrations_dir)

    # Keep only .sql
    sql_files = []
    for f in files:
        if f.endswith(".sql"):
            sql_files.append(f)

    # Sort so 001_, 002_ run in order
    sql_files.sort()

    if len(sql_files) == 0:
        print("No .sql files found in", migrations_dir)
        return

    # 3) Connect once, run all migrations, then commit once
    conn = get_connection()
    cursor = conn.cursor()

    for filename in sql_files:
        path = os.path.join(migrations_dir, filename)
        print("Running migration:", filename)

        # Read the whole SQL file
        f = open(path, "r", encoding="utf-8")
        sql = f.read()
        f.close()

        # Run each statement separated by ;
        parts = sql.split(";")
        for stmt in parts:
            stmt = stmt.strip()
            if stmt != "":
                cursor.execute(stmt)

    conn.commit()
    cursor.close()
    conn.close()

# Adds a new event to the timestamps table
def insert_timestamp(event):

    conn = get_connection()
    cursor = conn.cursor()
    
    # %s is a placeholder - pymysql safely inserts the value to prevent SQL injection
    query = "INSERT INTO timestamps (event) VALUES (%s)"
    cursor.execute(query, (event,))
    
    # Commit to actually save the changes
    conn.commit()
    cursor.close()
    conn.close()

#all timestamps from the database, newest first
def get_timestamps():

    conn = get_connection()
    cursor = conn.cursor()
    
    # Get everything, sorted by most recent first
    query = "SELECT id, event, created_at FROM timestamps ORDER BY created_at DESC"
    cursor.execute(query)
    
    # Fetch all rows as a list of tuples
    results = cursor.fetchall()
    
    cursor.close()
    conn.close()
    
    return results