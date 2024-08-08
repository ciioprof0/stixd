# STIX-D 0.1 Interpretation Rules
<!-- ToDo List
- Replace ACE examples with relevant examples from STIX-D corpus.

-->

<!-- Original ACE 6.7 text, Date: 2013-08-01
Each ACE sentence has only one meaning. However, if interpreted in full English, an ACE sentence can have many meanings. The following interpretation rules specify which of the conceivable meanings a sentence has in ACE.

Notes: To clarify the scopes of a sentence we use {...}. This should not be confused with the notation used for sets. To explain anaphoric references we use [...] which should not be confused with the notation for lists. A sentence prefixed with `*` is not part of ACE, but serves as counter example.
-->

Each STIX-D and ACE sentence has only one meaning. However, if interpreted in full English, a STIX-D or ACE sentence can have many meanings. The following interpretation rules specify which of the conceivable meanings a sentence has in STIX-D.

Notes: To clarify the scopes of a sentence we use {...}. This should not be confused with the notation used for sets. To explain anaphoric references we use [...] which should not be confused with the notation for lists. A sentence prefixed with `*` is not part of STIX-D, but serves as counter example.

## Plurals

By default, plural noun phrases have a collective reading; distributive reading is indicated by _each of_.



    collective reading:   A clerk enters two cards.

    distributive reading: A clerk enters each of two cards.


A collective plural, for instance _two girls_ , denotes a group of two girls that is viewed as a whole. A distributive plural, for example _each of two girls_ , denotes a set of two girls that are considered individually.



    Two girls lift a table.

    (Note: There is one act of lifting in which two girls together lift a table. In other words, there is one relation between two girls and one table.)


    Each of two girls lifts a table.

    (Note: There are two acts of lifting in each of which one of the two girls individually lifts a table — not necessarily the same one. That is to say, there are two relations between each of the two girls and a table.)


## _of_ -Constructs

A definite noun phrase followed by an _of_ -construct, as in _the father of John_ , does not introduce a functional relation between _John_ and _father_ , but is interpreted as the relation _a father of John_.

An _of_ -construct followed by a noun phrase conjunction pertains to the complete noun phrase conjunction. Thus the following sentence



    A man sees a dog of Mary and John.


that is ambiguous in English gets in STIX-D and ACE the unique interpretation that a man sees a dog that belongs to both Mary and John, i.e. as _A man sees a dog of {Mary and John}_. To express that the man sees John and a dog of Mary, one can write



    A man sees John and a dog of Mary.


## Adjuncts

### Prepositional Phrases

Prepositional phrases modify the verb not the noun.



    A customer {enters a card with a code}.


### Adverbs

If an adverb can modify the preceding or the following verb then it modifies
the preceding one.



    A customer who {enters a card manually} types a code.


## Coordination

### Relative Clauses

Relative clauses modify the immediately preceding noun. In order to express coordination within the relative clause, the relative pronoun _who/that/which_ must be repeated.



    A customer enters {a card that carries a code} and opens an account.
    A customer inserts {a card that is valid and that has a code}.


### Binding Order

Binding order of coordinators is the following:



    _and_ > _or_ > _,and_ > _,or_


I.e. _and_ binds stronger than _or_ , but this can be reversed by prefixing _and_ with a comma.



    A client {enters a red card or enters a blue card}, and enters a code.


## Scope of Subordinated Sentences

### Sentence Subordination

The scope of simple subordinated sentences, i.e. simple sentences following the word _that_ extends to the end of the simple sentence. To express coordination within the scope of sentences subordination the word _that_ has to be repeated.



    {It is false that a man waits} and a dog barks.
    {It is false that a man waits and that a dog barks}.
    John believes {that Mary is tired} and she sleeps.
    John believes {that Mary is tired and that she sleeps}.


### _if-then_ -Sentences

In _if-then_ -sentences, the scope of the _then_ -part extends to the end of the coordination.



    {If a man waits and a dog barks} {then a woman smiles and a cat sleeps}.


## Quantifiers

### The Determiner _a_ Means Existential Quantification

The determiner _a_ means existential quantification, not universal quantification. To express universal quantification use, for example, _every_. Compare the following two sentences.



    A cat is an animal. (= There is a cat that is an animal.)
    Every cat is an animal. (= If there is a cat then the cat is an animal.)


### Scopes of Local Quantifiers

The textual position of a local quantifier (universal: _every_ , _each_ , ...; existential: _a_ /_an_ , _some_ , ...) opens its scope that extends to the end of the sentence; in sentence coordinations the scope extends to the end of the respective coordinated sentence.



    {A customer types {every code}}.
    {Every customer types {a code}}.
    {Every customer has a card} and {a customer has a code}.


### Scopes of Global Quantifiers

The textual position of a global quantifier (universal: _for every_ , _for each_ , ...; existential: _there is a/an_ , _there is some_ , ...) opens its scope that extends to the end of the sentence, coordinated or not.



    {For every customer the customer has a card and the customer has a code}.


### Equivalence of Universally Quantified and Conditional Sentences

Note that universally quantified sentences and conditional sentences are interpreted equivalently. E.g.



    Every customer enters a card.


is equivalent to



    If there is a customer then the customer enters a card.


## Lexicon

### Overlap of Countable and Mass Nouns

Some nouns, for instance _laundry_ , have both a countable interpretation (_a laundry_) and a mass interpretation (_some laundry_). Their use with _no_ and their combination with Saxon genitives and possessive pronouns can introduce a lexical ambiguity between the countable and the mass interpretation. This ambiguity is resolved in ACE by preferring the countable interpretation. The mass interpretation can be enforced by using the _of_ -prepositional phrase.



    John's laundry (countable interpretation)
    his laundry (countable interpretation)
    no laundry (countable interpretation)
    some laundry of John/him (mass interpretation)
    a laundry of John/him (countable interpretation)
    the laundry of John/him (depends on the resolution of anaphor `the laundry')
    it is false that some laundry ... (mass interpretation)
    some laundry does not ... (mass interpretation)


### Hyphenation of Phrasal and Prepositional Verbs

The same verb can appear in the categories intransitive, transitive, and ditransitive. This can lead to ambiguities. To eliminate these ambiguities, STIX-D and ACE expects that the phrasal particle of a phrasal verb (e.g. _look up_ , _drop out_ , _shut down_) and the direct preposition of a prepositional verb (e.g. _look at_ , _apply for_) are hyphenated to the verb.



    A steward waits-on the table. (compare with: Some hot food waits {on the table}.)
    John looks-up an entry. (compare with: John looks {up the hill}.)
    What does John apply-for? (compare with: John applies {for the second time}.)


Hyphenation does not apply to ditransitive verbs since the prepositional complement is not adjacent to the verb.



    John gives a card to a clerk.
    Who does John give a card to?


### Overlap of Transitive and Ditransitive Verbs

If a verb is defined as a transitive verb and as a ditransitive verb (i.e. _regard something_ / _regard something as something_) then for sentences like



    John regards a woman as a friend.


the ditransitive reading has precedence. Thus, _a friend_ is interpreted as the indirect object of the ditransitive verb _regards_.

## Anaphora Resolution

### Numbers, Expressions, Lists, Sets, Strings

Numbers, expressions, lists, sets and strings cannot be anaphorically referred to.

### All Other Cases

Resolution of anaphoric references is governed by the accessibility, recency, specificity, and reflexivity of an antecedent.

### Accessibility of Antecedents

Proper names are always accessible for anaphoric reference.



    John does not see Mary. Mary waits for him.


A noun phrase antecedent other than a proper name is not accessible if it occurs in a negated sentence, in a sentence with a modal auxiliary, in a subordinated sentence, in an interrogative sentence, or in a command.



    John does not enter a card. *It is correct.
       (use instead: John does not enter a card that is correct.)
    John can enter a card. *It is correct.
       (use instead: John can enter a card that is correct.)
    It is necessary that John enters a card. *It is correct.
       (use instead: It is necessary that John enters a card that is correct.)
    Mary believes that John enters a card. *It is correct.
       (use instead: Mary believes that John enters a card that is correct.)
    Does John see a car? *The car is red.
       (use instead: Does John see a car that is red?)
       (use instead: A car is red. Does John see the car?)
    John, identify a car! *The car is red.
       (use instead: John, identify the car that is red!)
       (use instead: A car is red. John, identify the car!)


A noun phrase antecedent other than a proper name is not accessible if it occurs in a universally quantified or _if-then_ -sentence.



    Every customer has a card. *It is correct.
       (use instead: Every customer has a card that is correct.)
    If there is a customer then he has a card. *It is correct.
       (use instead: If there is a customer then he has a card that is correct.)


However, a noun phrase antecedent in the _if_ -part of a conditional sentence is accessible in the _then_ -part.



    If a customer has a card then he enters it.


A noun phrase antecedent in a disjunction is only accessible in subsequent disjuncts.



    A customer enters a card or drops it. *It is dirty.


### Anaphoric Reference by Proper Names

Each occurrence of a proper name like _John_ denotes the same entity. Thus, anaphoric reference to a proper name is possible using the proper name itself.



    John likes Mary and Mary likes John.


### Anaphoric Reference by Non-Reflexive Pronouns

If the anaphor is a non-reflexive personal pronoun (_he_ , _him_ , ...), or a non-reflexive possessive pronoun (_his_ , ...), then the anaphor is resolved with the most recent accessible noun phrase that agrees in gender and number, and that is not the subject of the verb phrase in which the anaphor occurs.



    John has a card. Bob sees him and takes it.
    John and Mary wait. They are tired.
    *John sees his wife. (use instead: John sees his own wife.)


The non-reflexive personal pronoun _they_ can refer to a noun phrase conjunction.



    John and two friends walk. They are tired.
    (Note: The pronoun _they_ refers to _John and two friends_.)


### Anaphoric Reference by Reflexive Pronouns

If the anaphor is a reflexive personal pronoun (_herself_ , ...) or a reflexive possessive pronoun (_her own_ , ...), then the anaphor is resolved with the subject of the sentence in which the anaphor occurs provided that the subject agrees in gender and number with the anaphor.



    Mary takes her own card and gets some money for herself.
    John and Mary admire themselves.
    John sees a man that sees himself.
    John sees a man that is seen by himself.


### Anaphoric Reference by Definite Noun Phrases

If the anaphor is a definite noun phrase then it is resolved with the most recent and most specific accessible noun phrase antecedent that agrees in gender and number.



    There is a blue ball. There is a red ball. John sees the ball [= the red ball]. Mary sees the blue ball.

    There is a ball of a boy. There is a ball of a girl. John sees the ball [= the ball of a girl]. Mary sees the ball of a boy.

    There is a ball that is blue. There is a ball that is red. John sees the ball [= the ball that is red]. Mary sees the ball that is blue.


Notice that specificity means that a definite noun phrase anaphor can also be resolved if the sentence in which the antecedent noun phrase occurs contains all the constituents of the anaphor.



    There is a man. His dog barks. The man whose dog barks is irritated.
       (use alternatively: There is a man whose dog barks. The man whose dog barks is irritated.)
    A man owns a dog. John sees the man who owns a dog.
       (use alternatively: There is a man who owns a dog. John sees the man who owns a dog.)


If a definite noun phrase cannot be resolved then it is interpreted as an indefinite noun phrase introducing a new entity.



    John goes to the bank.
    (Note: The definite noun phrase _the bank_ does not have an antecedent and introduces a new entity.)


### Anaphoric Reference by Variables

If the anaphor is a variable then it is resolved with an accessible noun phrase that has the variable as apposition, or with the respective "bare" variable.



    John has a card X and a card Y. Mary takes the card. Bob takes the card X. Harry takes Y.

    X is heavy. John lifts X.
       (= Something X is heavy. John lifts X.)


### Undefined Capitalized Words

An undefined word starting with a capital letter and occurring in a noun phrase position is interpreted as a singular proper name with undefined gender. Referring later to the word with a pronoun determines its gender.



    Leonino sleeps.
    (Note: The gender of _Leonino_ is undefined.)

    Leonino sleeps. Her fur is wet.
    (Note: The pronoun _her_ assigns to _Leonino_ the female gender. Later references must respect this.)


## Passives

Passive sentence have the same meaning as their active counterparts.



    A card is entered by John. (= John enters a card.)
    A customer is given a card by John. (= John gives a customer a card.)


Note that a passive sentence always needs an agent denoted by _by ..._ . If the lexicon happens to contain the same word as participle perfect — used in a passive construct — and as intransitive adjective then users could get the mistaken impression that it is possible to build passive sentences without the _by_ -construct. Assuming that _entered_ occurs in the lexicon both as participle perfect and as intransitive adjective then the sentence _A card is entered._ is not a passive sentence, and _entered_ is interpreted as
adjective.

## Arithmetic Expressions

Arithmetic expressions are built from numbers, variables and proper names with the help of the operators +, -, *, /, ^. All operators are left-associative. Standard operator precedence applies: ^ precedes * and / that precede + and -. Sub-expressions can be put in parentheses to modify the precedence of the operators. This applies specifically to iterated occurrences of the exponentiation operator ^. For example, the expression 2^3^4 stands for (2^3)^4. Use brackets to achieve 2^(3^4). Arithmetic operators have types, meaning that all arguments must eventually stand for numbers.

Note: The ACE parser APE does not evaluate arithmetic expressions.

## Strings

Strings consist of a sequence of Unicode characters enclosed in double quotes "...". Quotation marks and backslashes within strings have to be escaped by a backslash. Strings, variables, proper names and bracketed strings can be concatenated by the left-associative operator &. The operator & has a type, meaning that all arguments must eventually stand for strings.

Note: The ACE parser APE does not perform concatenations.

ACE 6.7: 2013-08-01
STIX-D 0.1: 2024-07-31
