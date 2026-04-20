import mysql.connector

db_config = {
    'host': 'localhost',
    'user': 'test01',
    'password': 'Test@123p',
    'database': 'foodapp02'
}

def check_users():
    try:
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor()
        cursor.execute("SELECT user_id, name, email, role, status FROM users")
        rows = cursor.fetchall()
        print("Users in DB:")
        for row in rows:
            print(row)
    except mysql.connector.Error as err:
        print(f"Error: {err}")
    finally:
        if 'conn' in locals() and conn.is_connected():
            cursor.close()
            conn.close()

if __name__ == "__main__":
    check_users()
