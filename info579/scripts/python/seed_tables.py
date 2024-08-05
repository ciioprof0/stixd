import subprocess

def run_sql_script(script_path):
    subprocess.run(["mysql", "-u", "your_username", "-pyour_password", "stixd_corpus", "<", script_path], shell=True)

def main():
    seeds_scripts = [
        "../../sql/seeds/31_seed_genders.sql",
        "../../sql/seeds/32_seed_special_chars.sql",
        "../../sql/seeds/33_seed_prohib_words.sql",
        "../../sql/seeds/34_seed_prohib_intersections.sql",
        "../../sql/seeds/35_seed_prolog_constraints.sql"
    ]

    for script in seeds_scripts:
        print(f"Running {script}...")
        run_sql_script(script)

    print("Tables seeded successfully.")

if __name__ == "__main__":
    main()

