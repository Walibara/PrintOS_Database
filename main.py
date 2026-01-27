# Import all our database functions from database.py
# NOTE: create_database + create_table are no longer needed once you use migrations files.
# from database import create_database, create_table, insert_timestamp, get_timestamps

# UPDATED imports: we run migrations instead of create_table/create_database
from database import run_migrations, insert_timestamp, get_timestamps


def main():
    try:
        # Step 1: Make sure the database exists
        # NOTE: Commented out because your RDS database (printosdb) already exists.
        # We manage schema (tables) using SQL files in db/migrations instead.
        # print("Creating database...")
        # create_database()

        # Step 2: Create tables using migrations
        print("Running migrations...")
        run_migrations()   # looks in db/migrations/*.sql and runs them in order
        print("Migrations complete")

        # Step 3: Add some test timestamps
        # These will create new entries each time you run this (heads up!)
        print("\nInserting timestamp...")
        insert_timestamp("database setup")
        insert_timestamp("github actions test")
        insert_timestamp("production deploy")
        print("Timestamps inserted")

        # Step 4: Fetch and display all timestamps
        print("\nGetting timestamps...")
        timestamps = get_timestamps()

        # Pretty print the results in a table format
        print("\n" + "=" * 70)
        print("TIMESTAMP LOG")
        print("=" * 70)

        # Loop through each row and format it nicely
        # row[0] = id, row[1] = event, row[2] = created_at
        for row in timestamps:
            print(f"ID: {row[0]:3} | Event: {row[1]:30} | Time: {row[2]}")

        print("=" * 70)
        print(f"Total records: {len(timestamps)}\n")

    except Exception as e:
        # If anything breaks, show us what went wrong
        print(f"ERROR: {e}")
        import traceback
        traceback.print_exc()  # Full error details for debugging


if __name__ == "__main__":
    main()