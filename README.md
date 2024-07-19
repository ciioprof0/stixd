# STIX Descriptions Main Repository

The goal of this project is to develop a specialized Controlled Natural Language ([CNL](https://en.wikipedia.org/wiki/Controlled_natural_language)) and associated tools for the free-text description properties in STIX Domain Objects ([SDO](https://docs.oasis-open.org/cti/stix/v2.1/os/stix-v2.1-os.html#_nrhq5e9nylke)) and STIX Relationship Objects ([SRO](https://docs.oasis-open.org/cti/stix/v2.1/os/stix-v2.1-os.html#_cqhkqvhnlgfh)). The Structured Threat Information eXpression ([STIX](https://docs.oasis-open.org/cti/stix/v2.1/os/stix-v2.1-os.html)) version 2.1, released on June 10, 2021, includes 15 SDOs and two SROs with optional description properties.

## Project Scope and Phases

In the initial proof-of-concept phase, we will focus on the `indicator` object ([SDO 4.7](https://docs.oasis-open.org/cti/stix/v2.1/os/stix-v2.1-os.html#_muftrcpnf89v)) for describing {TBD: technique name} (MITRE ATT&CK Technique {T####}). The deliverables for this phase are:
1. A relevant subset of the CNL.
2. An application to validate if a given text string conforms to the CNL.

#### Table 1. List of Project Repositories

| Repository | Description | URL |
|------------|-------------|-----|
| stixd | Main repository for the project. | [stixd](https://github.com/ciioprof0/stixd) |
| stixd-cnl | Definitions for the Controlled Natural Language (CNL). | [stixd-cnl](https://github.com/ciioprof0/stixd-cnl) |
| stixd-validator | Application to verify if a string is a member of the CNL. | [stixd-validator](https://github.com/ciioprof0/stixd-validator) |
