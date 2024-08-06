DELIMITER //

CREATE PROCEDURE stixd_corpus.run_seed_scripts()
BEGIN
    -- Seed Genders
    SET @sql = 'SOURCE ../seeds/seed_genders.sql';
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;

    -- Seed Prohibited Words
    SET @sql = 'SOURCE ../seeds/seed_prohib_words.sql';
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;

    -- Seed Prohibited Intersections
    SET @sql = 'SOURCE ../seeds/seed_prohib_intersections.sql';
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;

    -- Seed Prolog Constraints
    SET @sql = 'SOURCE ../seeds/seed_prolog_constraints.sql';
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;

    -- Seed Word Tags
    SET @sql = 'SOURCE ../seeds/seed_word_tags.sql';
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;

    -- Seed Special Characters
    SET @sql = 'SOURCE ../seeds/seed_spec_chars.sql';
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END //

DELIMITER ;
