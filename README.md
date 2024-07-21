# STIX Descriptions CNL Main Repository

My long-term goal for the [HLTMS](https://linguistics.arizona.edu/online-ms-hlt) program is to create a specialized controlled natural language ([CNL](https://en.wikipedia.org/wiki/Controlled_natural_language)) and related tools for the free-text `description` properties in certain Structured Threat Information eXpression ([STIX](https://docs.oasis-open.org/cti/stix/v2.1/os/stix-v2.1-os.html)) objects. STIX Descriptions (STIX-D) related to adversary activities are instances of behavioral indicators of compromise (IOC). 

## Project Scope and Phases

In the initial proof-of-concept phase, we will focus on the `indicator` object ([SDO 4.7](https://docs.oasis-open.org/cti/stix/v2.1/os/stix-v2.1-os.html#_muftrcpnf89v)) for describing MITRE ATT&CK Technique [T1204.003](https://attack.mitre.org/techniques/T1204/003/) - User Execution: Malicious Image. The deliverables for this phase are:
1. A relevant subset of the STIXD CNL.
2. An application to validate if a given text string conforms to the CNL.


#### Table 1. List of Project Repositories

| No. | Repository | Description |
|-----|------------|-------------|
| 1-1. | [stixd](https://github.com/ciioprof0/stixd) | Main repository for the project. | 
| 1-2. | [stixd-cnl](https://github.com/ciioprof0/stixd-cnl) | Definitions for the Controlled Natural Language (CNL). To be developed.|
| 1-3. | [stixd-validator](https://github.com/ciioprof0/stixd-validator) | Application to verify if a string is a member of the CNL. To be developed.|


#### Table 2. List of Related Third-Party Repositories

| No. | Repository | Description |
|-----|------------|-------------|
| 2-1. | [attack-stix-data](https://github.com/mitre-attack/attack-stix-data) | MITRE ATT&CK dataset represented in STIX 2.1 JSON collections. | 
| 2-2. | [cti-pattern-validator](https://github.com/oasis-open/cti-pattern-validator) | A software tool for checking the syntax of the Cyber Threat Intelligence (CTI) STIX Pattern expressions |
| 2-3. | [cti-python-stix2](https://github.com/oasis-open/cti-python-stix2) | Python APIs for serializing and de-serializing STIX2 JSON content, along with higher-level APIs for common tasks, including data markings, versioning, and for resolving STIX IDs across multiple data sources. |
| 2-4. | [cti-stix2-json-schemas](https://github.com/oasis-open/cti-stix2-json-schemas) | JSON schemas and examples for STIX 2 |
| 2-5. | [cti-stix-validator](https://github.com/oasis-open/cti-stix-validator) | The STIX Validator checks that STIX JSON content conforms to the requirements specified in the STIX 2.1 specification. |
