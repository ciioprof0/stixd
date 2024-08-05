# STIX Descriptions CNL Repository

For my capstone project in the [HLTMS](https://linguistics.arizona.edu/online-ms-hlt) program, I aim to develop a Controlled Natural Language ([CNL](https://en.wikipedia.org/wiki/Controlled_natural_language)) and necessary tools and databases for Structured Threat Information eXpression  ([STIX](https://docs.oasis-open.org/cti/stix/v2.1/os/stix-v2.1-os.html)) descriptions in Cyber Threat Intelligence ([CTI](https://www.crowdstrike.com/cybersecurity-101/threat-intelligence/)). The project, named ‘STIX-D’, will be a subset of Attempto Controlled English ([ACE](http://attempto.ifi.uzh.ch/)). .

## Phase 1: Build a STIX-D Corpus

Phase 1 of the project started during the Summer 2024 academic session with three components of the corpus with each component corresponding to class project. The components are:

- [LING 508](https://catalog.arizona.edu/courses/0198961). An application to extract descriptions from STIX objects and parse the description texts into documents, sentences, and words, forming a corpus.
- [INFO 579](https://catalog.arizona.edu/courses/0424311). A relational database to hold the STIX-D Corpus.
- [INFO 523](https://catalog.arizona.edu/courses/0399651). A natural language processing ([NLP](https://en.wikipedia.org/wiki/Natural_language_processing)) pipeline for CNL development.



#### Table 1. List of Related Third-Party Repositories

| No. | Repository | Description |
|-----|------------|-------------|
| 1. | [APE](https://github.com/Attempto/APE) | ACE Parser Engine (APE) |
| 2. | [attack-stix-data](https://github.com/mitre-attack/attack-stix-data) | MITRE ATT&CK dataset represented in STIX 2.1 JSON collections. |
| 3. | [Clex](https://github.com/Attempto/Clex) | ACE Common Lexicon |
| 4. | [cti-pattern-validator](https://github.com/oasis-open/cti-pattern-validator) | A software tool for checking the syntax of the Cyber Threat Intelligence (CTI) STIX Pattern expressions |
| 5. | [cti-python-stix2](https://github.com/oasis-open/cti-python-stix2) | Python APIs for serializing and de-serializing STIX2 JSON content, along with higher-level APIs for common tasks, including data markings, versioning, and for resolving STIX IDs across multiple data sources. |
| 6. | [cti-stix2-json-schemas](https://github.com/oasis-open/cti-stix2-json-schemas) | JSON schemas and examples for STIX 2 |
| 7. | [cti-stix-validator](https://github.com/oasis-open/cti-stix-validator) | The STIX Validator checks that STIX JSON content conforms to the requirements specified in the STIX 2.1 specification. |
