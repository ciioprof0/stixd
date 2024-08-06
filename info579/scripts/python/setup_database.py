import subprocess

def run_sql_script(script_path):
    subprocess.run(["mysql", "-u", "your_username", "-pyour_password", "<", script_path], shell=True)

def main():
    script_path = "../../sql/setup/create_database.sql"
    print(f"Running {script_path}...")
    run_sql_script(script_path)
    print("Database created successfully.")

if __name__ == "__main__":
    main()
