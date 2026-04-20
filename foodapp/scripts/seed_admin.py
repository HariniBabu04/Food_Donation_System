import mysql.connector
from datetime import datetime

# Database configuration from application.properties
db_config = {
    'host': 'localhost',
    'user': 'test01',
    'password': 'Test@123p',
    'database': 'foodapp02'
}

def insert_admin():
    try:
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor()

        # Check if users table exists, otherwise wait (Spring Boot should create it)
        cursor.execute("SHOW TABLES LIKE 'users'")
        if not cursor.fetchone():
            print("Table 'users' does not exist yet. Please start the Spring Boot app first.")
            return

        # Check if admin already exists
        cursor.execute("SELECT * FROM users WHERE email = 'admin@example.com'")
        if cursor.fetchone():
            print("Admin user already exists.")
            return

        # Admin password 'admin123' hashed with bcrypt
        password_hash = '$2a$10$8.UnVuG9HHgffUDAlk8qfOuVGkqRzgVymGe07xd00DMxs.TVuHOn2'
        
        query = """
            INSERT INTO users (name, email, phone, password, role, status, created_at, otp_verified)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
        """
        values = ('Admin User', 'admin@example.com', '1234567890', password_hash, 'admin', 'Active', datetime.now(), 1)
        
        cursor.execute(query, values)
        conn.commit()
        print("Admin user 'admin@example.com' inserted successfully.")

    except mysql.connector.Error as err:
        print(f"Error: {err}")
    finally:
        if 'conn' in locals() and conn.is_connected():
            cursor.close()
            conn.close()

if __name__ == "__main__":
    insert_admin()
