import subprocess

def run_sql_script(script_path):
    subprocess.run(["mysql", "-u", "your_username", "-pyour_password", "stixd_corpus", "<", script_path], shell=True)

def main():
    script_path = "../../sql/procedures/17_prc_check_prolog_constraints.sql"
    print(f"Running {script_path}...")
    run_sql_script(script_path)
    print("Procedures created successfully.")

if __name__ == "__main__":
    main()
