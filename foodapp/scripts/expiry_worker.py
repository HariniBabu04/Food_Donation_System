import mysql.connector
from datetime import datetime
import time

# Database configuration
db_config = {
    'host': 'localhost',
    'user': 'test01',
    'password': 'Test@123p',  # Update as per your MySQL setup
    'database': 'foodapp02'
}

def check_expiry():
    try:
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor()

        now = datetime.now().strftime('%H:%M:%S')
        print(f"[{datetime.now()}] Checking for expired donations...")

        # Update donations that are pasted their expiry time and not already ACCEPTED or EXPIRED
        query = """
            UPDATE donations 
            SET status = 'EXPIRED' 
            WHERE expiry_time < %s AND status = 'CREATED'
        """
        cursor.execute(query, (now,))
        
        affected_rows = cursor.rowcount
        if affected_rows > 0:
            print(f"Marked {affected_rows} donations as EXPIRED.")
            conn.commit()
        else:
            print("No expired donations found.")

    except mysql.connector.Error as err:
        print(f"Error: {err}")
    finally:
        if conn.is_connected():
            cursor.close()
            conn.close()

if __name__ == "__main__":
    while True:
        check_expiry()
        time.sleep(60)  # Check every minute
