import subprocess

def run_sql_script(script_path):
    subprocess.run(["mysql", "-u", "your_username", "-pyour_password", "stixd_corpus", "<", script_path], shell=True)

def main():
    triggers_scripts = [
        "../../sql/triggers/11_trg_lexicon_preposition_gender.sql",
        "../../sql/triggers/12_trg_lexicon_preposition_check.sql",
        "../../sql/triggers/13_trg_lexicon_word_class_prep.sql",
        "../../sql/triggers/14_trg_lexicon_word_class_gender.sql",
        "../../sql/triggers/15_trg_lexicon_prohibited_words.sql",
        "../../sql/triggers/16_trg_lexicon_prohibited_intersections.sql",
        "../../sql/triggers/18_trg_lexicon_prolog_constraints.sql"
    ]

    for script in triggers_scripts:
        print(f"Running {script}...")
        run_sql_script(script)

    print("Triggers created successfully.")

if __name__ == "__main__":
    main()
