import subprocess

def run_script(script):
    subprocess.run(["python3", script])

def main():
    scripts = [
        "setup_database.py",
        "create_tables.py",
        "create_procedures.py",
        "create_triggers.py",
        "seed_tables.py"
    ]

    for script in scripts:
        print(f"Running {script}...")
        run_script(script)

    print("Database setup complete.")

if __name__ == "__main__":
    main()
