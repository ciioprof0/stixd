# STIX-D 0.1 Construction Rules

<!-- ToDo List
- Replace ACE examples with relevant examples from STIX-D corpus.
- Determine if declarative sentences are the only type of sentences allowed in STIX-D.
- Update 'STIX Descriptions' section according to above findings.
-->

<!-- Original ACE 6.7 text, Date: 2013-07-31
The construction rules define admissible sentence structures for ACE 6.7. Note that every ACE sentence is a syntactically acceptable English sentence, but not every English sentence is an ACE sentence.-->

<!-- [Version: STIX-D 0.1, Change: Added, Date: 2024-07-31] -->
The construction rules define admissible sentence structures for STIX-D. STIX-D construction rules are based on [ACE 6.7 Construction Rules]( http://attempto.ifi.uzh.ch/site/docs/ace_constructionrules.html). This means that every STIX-D sentence is a syntactically acceptable ACE sentence, but not every ACE sentence is a STIX-D sentence. Likewise, every ACE sentence is a syntactically acceptable English sentence, but not every English sentence is an ACE sentence.
<!-- STIX-D Change End -->

Note: A sentence prefixed with `*` is not part of STIX-D, but serves as counter example.

## Summary of Differences between STIX-D and ACE 6.7 Construction Rules
STIX-D Construction Rules are substantially the same as ACE 6.7 Construction Rules. The only difference is that STIX Descriptions are more restrictive than ACE Texts.  STIX Descriptions only allow declarative sentences; they do not allow interrogative and imperative sentences. ACE Texts allow declarative, interrogative and imperative sentences.

## Words

STIX-D function words and some fixed phrases are predefined and cannot be changed by users. Function words are determiners, quantifiers, coordinators, negation words, pronouns, query words, modal auxiliaries, copula _be_ , and Saxon genitive marker _'s_. Fixed phrases are, for instance: _there is ..._ and _it is not possible that ..._.

STIX-D content words are nouns, verbs, adjectives, adverbs and prepositions. Content words can be simple (_code_), or compound with hyphens (_check-code_).

## Phrases

### Noun Phrases

#### Singular Countable Common Noun Phrases



    a card
    the card
    1 card
    one card
    no card
    every card
    each card
    not every card
    not each card

    all cards
    no cards


The following determiners can be used interchangeably: _a_ and _1_ and _one_ , _every_ and _each_ , _not every_ and _not each_.

The noun phrase _all cards_ is syntactic sugar for _every card_ , and the noun phrase _no cards_ is syntactic sugar for _no card_.

#### Plural Countable Common Noun Phrases

Plural countable common noun phrases can be collective:



    the cards
    some cards
    3 cards
    three cards


or distributive:



    each of the cards
    each of some cards
    each of 3 cards
    each of three cards


Integers up to 12 used as determiner as in _12 cats_ can be written in characters, i.e. _twelve cats_. Larger integers must be written in digits.

#### Mass Common Noun Phrases



    some water
    no water
    all water
    not all water


#### Proper Names
<!-- Original ACE 6.7 text, Date: 2013-07-31
Proper names can be singular and plural, and can occur without or with the definite determiner. Multiwords like _United-Nations_ must be hyphenated.
-->
Proper names can be singular and plural, and can occur without or with the definite determiner. Open compound names like _United-Nations_ must be hyphenated.

    John
    Mr-Miller
    the United-Nations


#### Integer and Real Numbers

Integer and real numbers are predefined.

An integer is a non-empty sequence of digits (0-9). A real number consists of a non-empty sequence of digits (0-9) followed by a period followed by a non-empty sequence of digits (0-9). Positive integers and positive real numbers must not be prefixed by a plus sign (_+_). Negative integers and negative real numbers are prefixed by a minus sign (_-_).



    0
    12
    -2
    0.0
    0.2
    2.0
    3.141
    -2.718


#### Arithmetic Expressions

Arithmetic expressions are built from numbers, variables and proper names with the help of the operators +, -, *, /, ^. Standard operator precedence applies. Sub-expressions can be put in parentheses to modify the precedence of the operators. This applies specifically to iterated occurrences of the exponentiation operator ^. The ACE parser APE does not evaluate expressions.



    1 + 2 / X * 4
    (1 + 2) / X * 4
    Pi/2
    2 ^ 3
    2 ^ (3 ^ 4) vs. (2 ^ 3) ^ 4


#### Strings

Strings consist of a sequence of Unicode characters enclosed in double quotes "...". Quotation marks and backslashes within strings have to be escaped by a backslash.

Strings, variables, proper names and bracketed strings can be concatenated by the left-associative operator &. The ACE parser APE does not perform concatenations.



    ""
    "abc"
    "ab\"cd"
    "ab\\cd"
    "abc" & "123"


#### Sets and Lists

Sets consist of a sequence of elements in braces {...}. Lists consist of a sequence of elements in brackets [...]. Elements of sets and lists are numbers, arithmetic expressions, variables, strings, proper names, and sets and lists.



    {}
    {3, 6, [1,2]}

    []
    [3, 4, 5, "ab", John, 1+2]


Operations on sets and lists could be expressed in natural language. Here are possible examples.



    {} is a subset of {3, 6}
    X is an element of [3, 4, 5]


#### Non-Reflexive Pronouns

Non-reflexive pronouns third-person singular and plural are available for all sentences.



    he
    she
    he/she
    it
    they
    him
    her
    him/her
    them


Non-reflexive pronouns second-person singular and plural are available for commands.



    you


#### Reflexive Pronouns

Reflexive pronouns third-person singular and plural are available for all sentences.



    itself
    himself
    herself
    himself/herself
    themselves


Reflexive pronouns second-person singular and plural are available for commands.



    yourself
    yourselves


#### Indefinite Pronouns



    someone
    somebody
    something
    no one
    nobody
    nothing
    everyone
    everybody
    everything
    not everyone
    not everybody
    not everything


The following indefinite pronouns can be used interchangeably: _someone_ and _somebody_ , _no one_ and _nobody_ , _everyone_ and _everybody_ , _not everyone_ and _not everybody_.

#### Generalized Quantifiers

Generalized quantifiers are followed by positive integers.

Noun phrases with generalized quantifiers can be collective:



    at least 2 cards
    at most 2 cards
    more than 10 cards
    less than 3 cards
    exactly 3 cards


or distributive:



    each of at least 2 cards
    each of at most 2 cards
    each of more than 10 cards
    each of less than 3 cards
    each of exactly 3 cards


#### Nobody and Nothing But

The special determiners _nobody but_ , _nothing but_ , and their variant _no ... but_ are used with bare plural noun phrases, bare mass noun phrases or proper names.



    nothing but apples
    nothing but water
    nobody but John
    no man but John


#### Measurement Nouns

Measurement noun phrases are built from numbers followed by measurement nouns and optionally followed by _of_ and a bare mass noun or a bare plural noun.



    2 m
    31.2 °C
    1.4 l of water
    3 kg of apples


Measurement noun phrases can be used in the singular and in the plural.



    3 kg of apples is heavy.
    3 kg of apples are heavy.


#### Variables

Variables can be introduced as noun phrase apposition, and can then be used as noun phrases. Variable names consist of a single upper case letter, optionally followed by an integer.



    A man X sleeps. X is young.
    If somebody D1 is a dog then D1 is an animal.


If a variable is introduced as apposition to _something_ then it is possible to omit _something_. These variables are called "bare".



    X weighs 300 kg. X is heavy. (= Something X weighs 300 kg. X is heavy.)


#### Noun Phrase Conjunction

The conjunction of noun phrases creates a plural entity that can be anaphorically referred to.



    A man and at least 2 women wait. They are tired.


### Modifying Nouns and Noun Phrases

#### Adjectives

A common noun can optionally be preceded by a positive, comparative, or superlative adjective. Adjectives can be conjoined by _and_.



    a rich customer
    a rich and satisfied customer
    a richer customer (= a more rich customer)
    a richer and more satisfied customer
    a richest customer (= a most rich customer)
    a richest and lucky customer


#### Relative Clauses

A relative clause can optionally follow a noun phrase, a proper name, or an indefinite pronoun. Relative clauses can be coordinated by _and_ and by _or_.



    a customer that is rich
    a customer who is rich and who is well-known
    a man who waits or who sleeps
    John who waits
    some men each of who waits
    everything which is important


#### Variables in Apposition

Variables can optionally occur in apposition to a noun phrase. Variable names consist of a single upper case letter, optionally followed by an integer.



    a customer X
    the customer C1


#### Genitives

Various genitive constructs can optionally be attached to a noun phrase: _of_ -prepositional phrases, Saxon genitives and possessive pronouns. Possessive pronouns are non-reflexive (_your_ , _its_ , _his_ , _her_ , _his/her_ , _their_), or reflexive (_your own_ , _its own_ , _his own_ , _her own_ , _his/her own_ , _their own_). Note that the Saxon genitive can only be used with a single noun while the _of_ -prepositional phrase can be followed by a conjunctive noun phrase.



    a customer of John
    a dog of John and Mary (= a dog of {John and Mary})
    John's customer
    John and Mary's dog (= John and {Mary's dog})
    everybody's customer
    every man's dog
    X's dog
    his customer
    his own customer
    your customer


### Verb Phrases

ACE verbs occurring in declarative or interrogative sentences are third person and simple present tense. Passives are built with the past participle and must have a prepositional phrase _... by ..._. ACE verbs occurring in imperative sentences are second person.

Verbs can be intransitive (_wait_), transitive (_enter something_), and ditransitive (_give something to somebody_ / _give someone something_).

Phrasal particles and those prepositions that introduce a complement of a transitive verb, must be hyphenated to the verb. Prepositions for the indirect object of ditransitive verbs are not hyphenated since they do not immediately follow the verb.

The copula _be_ as a special case is treated separately (see further down).

#### Intransitive, Transitive and Ditransitive Verbs

Here are some examples. For sentences with transitive and ditransitive verbs, the active and the semantically equivalent passive are given.



    John waits.
    John enters a card. (= A card is entered by John.)
    John fills-in a form. (= A form is filled-in by John.)
    John gives a card to a customer. (= A card is given to a customer by John.)
    John gives a customer a card. (= A customer is given a card by John.)


#### Copula

The copula _be_ must be followed by a noun phrase, an adjective phrase, a concatenation of prepositional phrases or a query word. For the use of the copula in interrogative sentences see Interrogative Sentences.

Some examples of the use of the copula.



    John is a rich customer.
    John's age is 32.
    John and Mary are two teachers.
    John is rich.
    John is in the garden on the hill.
    John is who?


An adjective phrase following the copula can use a transitive or an intransitive adjective. In both cases, the adjective can be positive, comparative, or superlative. Transitive adjectives always take a prepositional phrase as a complement and the preposition must be hyphenated to the adjective. Intransitive adjectives following a copula can be conjoined, but transitive adjectives cannot.



    John is rich.
    John is richer. (= John is more rich.)
    John is richest. (= John is most rich.)
    A customer is rich and more important and most successful.
    John is fond-of Mary.
    John is more fond-of Mary. (= John is fonder-of Mary.)
    John is most fond-of Mary. (= John is fondest-of Mary.)
    *A customer is rich and interested-in a bank.


For the positive and comparative forms, a comparison target can be defined using _as ... as_ or _more ... than_ , respectively. In this case conjunction of the adjectives is not possible.



    John is as rich as Mary.
    John is richer than Mary.
    John is as fond-of Mary as Bill.
    John is more fond-of Mary than Bill.
    *A customer is as rich as John and important.
    *A customer is richer than John and important.


In the case of transitive adjectives, one can repeat the preposition in order to make the object be the target of the comparison. (In the examples above, the subject was the target of the comparison.)



    John is as fond-of Mary as of Sue.
    John is more fond-of Mary than of Sue.


#### Negating Verb Phrases

Verb phrases are negated by _does/do not_ and _is/are not_. For sentence negation see Subordination.



    John does not enter a code.
    The men do not wait.
    Some water is not drinkable.
    The men are not tired.


#### Negation as Failure of Verb Phrases

In addition to logical negation, ACE provides negation as failure (_... does/do/is/are not provably ..._). For negation as failure of sentences see Subordination.



    John does not provably wait.
    The men do not provably work.
    John is not provably a teacher.
    The men are not provably admitted.


#### Modal Verb Phrases

ACE provides modality with modal auxiliaries for possibility (_can/cannot/can not/can't_), necessity (_must/have to/does not have to_), recommendation (_should/should not/shouldn't_), and admissibility (_may/may not_). For modal sentences see also Subordination.



    John can wait.
    John cannot wait. (= John can not wait., = John can't wait.)
    John must wait. (= John has to wait.)
    John does not have to wait.
    John should wait.
    John should not wait. (= John shouldn't wait.)
    John may wait.
    John may not wait.


#### Coordinating Verb Phrases

Verb phrases can be coordinated by _and_ and by _or_.



    John waits and eats a burger.
    John is rich or earns his own income.


### Modifying Verb Phrases

All verb phrases can be modified by adverbs and by prepositional phrases. Modifiers can precede the verb phrase or — with the exception of sentence subordination (see further down) — follow it.

As the following examples show, not each choice of positioning an adverb or a prepositional phrase is felicitous, but being able to put adverbs and prepositional phrases in different positions allows you to respect English pragmatics.

Adverbs and prepositional phrases can precede the verb phrase.



    A customer manually inserts a card.
    A customer into a slot inserts a card.
    Every customer usually is curious.
    Every customer in the beginning is inexperienced.


Adverbs and prepositional phrases can follow the verb phrase.



    A customer inserts a card manually.
    A customer inserts a card into a slot.
    Every customer is curious usually.
    Every customer is inexperienced  in the beginning.


Both positions can be combined.



    A customer manually inserts a card into a slot.


In sentence subordination (Subordination) modifiers of the verb of the main phrase must occur immediately before the verb. No modifiers are allowed between the verb of the main phrase and _that_ , respectively _to_.



    John seriously in the morning believes that Mary fills-in a form.
    John seriously in the morning wants to fill-in a form.


Adverbs can be used in their positive, comparative, or superlative forms.



    A customer waits patiently.
    A customer waits more patiently.
    A customer most patiently waits.


Observe the difference between:



    A student is interested-in a course.
    A student is interested in a classroom.


If several modifiers are used, two or more adverbs must be conjoined by _and_ , two or more prepositional phrases must be concatenated, and a sequence of adverbs and prepositional phrases must be concatenated.



    A customer inserts a card carefully and manually.
    A customer waits in a bank in the morning.
    A customer carefully and manually inserts a card into the slot in the bank.
    John usually in the current year is a rich customer in England.


## Declarative Sentences

Declarative sentences are simple sentences, _there is/are_ -sentences, boolean formulas, and composite sentences.

### Simple Sentences

Simple sentences have the structure

noun phrase + verb phrase



    A customer waits.
    A customer inserts a card.
    A customer gives a card to a clerk.
    A customer gives a clerk a card.
    A customer inserts a card manually into a slot.
    A customer manually inserts a card into a slot.


### _there is/are_ -Sentences

It is possible to create well-formed sentences without a verb, by using the _there is/are_ construction.

_there is_ \+ noun phrase

_there are_ \+ noun phrase

This construct just introduces the entities described by the noun phrase into the discourse, or — if negated — denies their existence. For this reason noun phrases following _there is/are_ cannot be and cannot contain definite noun phrases, universally quantified noun phrases, proper names, numbers, arithmetic expressions, strings, sets, or lists.



    There is a customer.
    There is some water.
    There are more than 6 clerks.
    There are a cat and 2 dogs.
    There is X.
    There is no man who sleeps.
    *There is a cat in a garden.
    There is a cat that sleeps.


### Boolean Formulas

Boolean formulas also count as sentences. They are built from numbers, arithmetic expressions, proper names and variables with the help of the comparison operators =, \=, >, >=, < and =<. As other sentences boolean formulas can be coordinated by _and_ , _or_ , _,and_ and _,or_. The ACE parser APE does not evaluate boolean formulas.



    10 = 4 + 6.
    X \= 2.
    5 > 3.
    X >= 13.4 and X < 20.
    2 ^ (2 ^ 2) = (2 ^ 2) ^ 2.


### Composite Sentences

Composite sentences are recursively built from simple sentences, _there is/are_ -sentences, boolean formulas, and other composite sentences with the help of the predefined constructors:

  * coordination
  * quantification
  * global quantification
  * subordination

#### Coordinated Sentences

Sentences can be coordinated by _and_ , _or_ , _,and_ and _,or_.

Coordination by _and_ and _or_ is governed by the standard binding order of logic, i.e. _and_ binds stronger than _or_. The coordinators _,and_ and _,or_ can be used to override the standard binding order.



    The screen blinks and John waits.
    The screen blinks or John waits.
    The screen blinks or John waits, and Mary enters a card.


#### Locally Quantified Sentences

There are existential and universal local quantification. For the treatment of the semantics of quantifiers in ACE, see the [ACE interpretation
rules](ace_interpretationrules.html).

Local existential quantification is expressed by indefinite determiners like _a_ , or explicitly by _there is/are_.



    There is a card.
    There is some water.
    There are at least 2 cards.
    John enters a card.
    John drinks some water.


Local universal quantification is expressed by the determiner _every_ , and its variants. Note that universal quantification can also be expressed by an _if ... then_ construct.



    Every man waits. (= If there is a man X then the man X waits.)
    John enters every card. (= If there is a card X then John enters the card X.)


#### Globally Quantified Sentences

There are existential and universal global quantification in which the quantifiers are moved to sentence initial position.

Global existential quantification is expressed by:



    there is ... that ...
    there are ... that ...


Global universal quantification is expressed by:



    for every
    for each
    for each of
    for all


Here are some examples.



    There is a code that every clerk enters.

    For every code a clerk enters it.
    For each of 3 men there is a bed.
    For all water there is a container.


#### Subordination

ACE knows five forms of sentence subordination:

  * conditional sentences (_if-then_ sentences)
  * logical negation
  * negation as failure
  * modality
  * sentence subordination

##### Conditional Sentences

Conditional sentences are built with the help of the _if-then_ construct that subordinates two simple or composite sentences.



    If John enters a card then the automated-teller accepts it.
    If John enters a card and he waits then the automated-teller accepts the card or rejects it.


##### Logical Negation

Complete sentences can be negated. For the negation of nouns phrases see Noun Phrases, and for the negation of verb phrases see Verb Phrases

Negation of sentences is expressed by the fixed phrases _it is false that ..._ , or by _it is not true that ..._. For coordinated sentences the word _that_ has to repeated. Note that for backwards compatibility ACE offers also the phrase _it is true that ..._.



    It is false that a screen blinks.
    It is false that a screen blinks and that John enters a code.


##### Negation as Failure

Negation as failure can be applied to complete sentences. For negation as failure of verb phrases see Verb Phrases.

Negation as failure of sentences is expressed by the fixed phrase _it is not provable that ..._. For coordinated sentences the word _that_ has to repeated.



    It is not provable that a screen blinks.
    It is not provable that a screen blinks and that John enters a code.


##### Modality

Modality can be used with complete sentences. For the modality of verb phrases see Verb Phrases

Modality of sentences is expressed by the fixed phrases _it is possible that ..._ , _it is not possible that ..._ , _it is necessary that ..._ , _it is not necessary that ..._ , _it is recommended that ..._ , _it is not recommended that ..._ , _it is admissible that ..._ , _it is not admissible that ..._. For coordinated sentences the word _that_ has to repeated.



    It is possible that John waits.
    It is not necessary that John enters a card and that he types a code.
    It is recommended that the surgeon operates the patient.
    It is not admissible that the patient takes his/her own medicine.


##### Sentence Subordination

In sentence subordination a transitive verb takes a complete sentence as an object.



    A clerk believes that a customer inserts a card.


If and only if the main sentence and the subordinated sentence have the same subject as in



    John wants that John inserts a card.


then sentence subordination can be more concisely expressed as



    John wants to insert a card.


Notice that adverbs and prepositional phrases modifying the verb of the main sentence can only occur before the verb of the main sentence as in the example
below, but are not allowed between the verb of the main sentence and _that_ , respectively _to_.



    John eagerly in the morning wants to insert a card.


### Interrogative Sentences
<!-- [TDB based on corpus: STIX-D may not require/allow interrogative sentences, Date: 2024-07-31] -->
ACE allows three forms of interrogative sentences: _yes/no_ queries, _wh_ -queries and _how much/many_ -queries. Interrogative sentences must end with a question mark.

_Yes/No_ queries can be answered by yes/no.



    Does John enter a card?
    Does John not wait?
    Do John and Mary wait in a garden?
    Is the card valid?
    Is the card not valid?
    Is it true that a man waits?
    Is it false that a man waits?


The _wh_ -queries _who_ , _whose_ , _what_ , and _which_ ask for the subject or an object of a sentence, while _how_ , _where_ , and _when_ ask for modifiers of the verb.

Since the query words can often be placed before the verb and after the verb most questions have alternative equivalent formulations.



    Who waits?
    Who wait? (= Who waits?)
    Each of who waits?
    Whose dog barks?
    A card of who is valid?
    Who does John not see? (alternatively: John does not see who?)
    Who is John? (alternatively: John is who?)
    What does a man not eat? (alternatively: A man does not eat what?)
    Which customer enters a card and types a code?
    How does John enter a card? (alternatively: John enters a card how?)
    Where does John wait? (alternatively: John waits where?)
    When does John wait? (alternatively: John waits when?)
    There is who? (alternatively: Who is there?)
    There is which man? (alternatively: Which man is there?)
    Where is John? (alternatively: John is who?)


The _how much/many_ -queries ask for the amount of a mass or measurement noun, or for the number of countable nouns. The queries can be used as subjects or objects of a sentence.



    How much water boils?
    How many men wait?
    How many men have how many apples?
    John gives how much food to how many children?


### Imperative Sentences
<!-- [TDB based on corpus: STIX-D may not require/allow imperative sentences, Date: 2024-07-31] -->
ACE supports simple imperative sentences, briefly called commands. A command consists of a noun phrase (the addressee), followed by a comma, followed by a — possibly negated — uncoordinated verb phrase. A command must end with an exclamation mark.



    John, go to your own bank!
    John and Mary, clean yourselves!
    Every dog, do not bark!
    John's brother, return the book to Mary!


## ACE Texts

An ACE text is a sequence of declarative, interrogative and imperative sentences. All sentences can anaphorically refer to preceding declarative sentences, but not to interrogative and imperative sentences.



    Mary enters a card into a machine. Its screen blinks or Mary waits.

    A man has a car. Does he see the car? John, identify the car!


## STIX Descriptions

A STIX description is a subset of ACE Texts. A STIX description is a sequence of one or more declarative sentences. All sentences can anaphorically refer to preceding declarative sentences within the same description. Interrogative and imperative sentences are not allowed in STIX descriptions.

    ToDo: Add examples of STIX descriptions


ACE 6.7: 2013-07-31
STIX-D 0.1: 2024-07-31
