# STIX-D 0.1 in a Nutshell
<!-- ToDo List
- Convert to STIX-D.
- Remove line breaks in same 
- Replace ACE examples with relevant examples from STIX-D corpus.
-->

<!-- Original ACE 6.7 text, Date: 2013-07-31 -->
This document presents ACE 6.7 in a nutshell. Section 1 briefly describes the
vocabulary, section 2 gives an account of the syntax, section 3 summarizes the
handling of ambiguity, and section 4 explains anaphoric references.

Note that this document describes only selected features of ACE 6.7. For more
information refer to the [ACE Construction Rules](ace_constructionrules.html)
and to the [ACE Interpretation Rules](ace_interpretationrules.html).




## Vocabulary

The vocabulary of ACE comprises

  * predefined function words (e.g. determiners, conjunctions, query words)
  * some predefined fixed phrases (_there is_ , _it is false that_ , ... )
  * content words (nouns, proper names, verbs, adjectives, adverbs)

The Attempto Parsing Engine (APE) comes with a basic lexicon of content words.
Users can also import their own lexicons of content words into APE (cf. [ACE
Lexicon Specification](ace_lexicon.html)). User-defined words take precedence
over words found in the basic lexicon. Alternatively, users can let APE guess
unknown words, or users can prefix unknown words by their word-class, for
instance _n:kitkat_ , _p:Thomas_ , _v:google_ , _a:trusted_ ,
_a:undeviatingly_.

## Grammar

The grammar of ACE defines the syntax of ACE texts. ACE's syntax is expressed
as a set of construction rules (cf. [ACE Construction
Rules](ace_constructionrules.html)). The meaning of syntactically correct
sentences is described as a set of interpretation rules (cf. [ACE
Interpretation Rules](ace_interpretationrules.html)).

### ACE Texts

An ACE text is a sequence of anaphorically interrelated declarative,
interrogative and imperative sentences.

Declarative sentences include simple sentences, _there is/are_ -sentences, and
composite sentences.

### Simple Sentences

Simple ACE sentences have the following structure:

subject + verb + complements + adjuncts

Every sentence built according to this structure has at least a subject and a
verb. Complements (direct and indirect objects) are necessary for transitive
verbs (_insert something_) and ditransitive verbs (_give something to
somebody_), whereas adjuncts (adverbs, prepositional phrases) modifying verbs
are optional. Adjuncts can precede the verb or follow the verb, respectively
its complements.



    A customer waits.
    The temperature is -2Â°C.
    A customer owns a card.
    A customer gives a card to a clerk.


### _there is/are_ -Sentences

It is possible to create well-formed sentences without a verb, by using the
_there is/are_ construct.



    there is + noun phrase
    there are + noun phrase


Every sentence of this structure introduces only the object, respectively
objects, described by the noun phrase.



    There is a customer.
    There are at least 3 apples.


### Adding Detail

Elements of a simple sentence and _there is/are_ -sentences can be fleshed out
to describe the situation in more detail. To further specify nouns, we can add
adjectives



    A trusted customer inserts two valid cards.
    There are two valid cards.


possessive nouns and of-prepositional phrases



    John's customer inserts a card of Mary.


or variables as appositions



    John inserts a card A.


Other modifications of nouns are possible through relative clauses



    A customer who is trusted inserts a card that he owns.
    There are at least 2 cards that are valid.


We can also detail the verb, e.g. by adding an adverb



    A customer inserts some cards manually.


or, by adding prepositional phrases



    A customer inserts some cards into an ATM.


We can combine all of this to arrive at



    John's customer who is trusted inserts a valid card of Mary manually into an ATM A.


### Composite Sentences

Composite sentences are recursively built from simpler sentences through
coordination, subordination, quantification, and negation.

#### Coordination

Coordination by _and_ is possible between sentences and between phrases of the
same syntactic type.



    A customer inserts a card and the machine checks the code.
    A customer inserts a card and enters a code.
    An old and trusted customer enters a card and a code.


Note that the coordination of the noun phrases _a card and a code_ represents
a plural object.

Coordination by _or_ is possible between sentences, verb phrases, and relative
clauses.



    A customer inserts a card or the machine checks the code.
    A customer inserts a card or enters a code.
    A customer owns a card that is invalid or that is damaged.


Coordination by _and_ and _or_ is governed by the standard binding order of
logic, i.e. _and_ binds stronger than _or_. Commas can be used to override the
standard binding order. Thus the sentence



    A customer inserts a VisaCard or inserts a MasterCard, and inserts a code.


means that the customer inserts a VisaCard and a code or, alternatively a
MasterCard and a code.

#### Subordination

There are three constructs of subordination: if-then sentences, modality, and
sentence subordination.

With the help of _if-then_ sentences we can specify conditional or
hypothetical situations, e.g.



    If a card is valid then a customer inserts it.


Note the anaphoric reference via the pronoun _it_ in the _then_ -part to the
noun phrase _a card_ in the _if_ -part.

Modality allows us to express — among other things — possibility and
necessity.



    A trusted customer can insert a card.
    It is necessary that a trusted customer inserts a card.


Sentence subordination — sentences are used as objects of transitive verbs —
comes in various forms.



    It is false that a customer inserts a card.
    It is not provable that a customer inserts a card.
    A clerk believes that a customer inserts a card.
    A clerk intends to enter a card. (= A clerk intends that the clerk enters a card.)


#### Quantification

Quantification allows us to speak about all objects of a class (universal
quantification), or to denote explicitly the existence of at least one object
of a class (existential quantification). The textual occurrence of a universal
or existential quantifier opens its scope that extends to the end of the
sentence, or in coordinations to the end of the respective coordinated
sentence.

To express that all customers insert cards we can write



    Every customer inserts a card.


This sentence means that each customer inserts a card that may, or may not, be
the same as the one inserted by another customer. To specify that all
customers insert the same card — however unrealistic that situation seems — we
can write



    A card is inserted by every customer.


or, equivalently



    There is a card that every customer inserts.


To state that every card is inserted by a customer we write



    Every card is inserted by a customer.


#### Negation

Negation allows us to express that something is not the case, e.g.



    A customer does not insert a card.
    A card is not valid.


To negate something for all objects of a class one uses _no_



    No customer inserts more than 2 cards.


or, _there is no_



    There is no customer who inserts a card.


To negate a complete statement one uses sentence negation



    It is false that a customer inserts a card.


These forms of negation are logical negations, i.e. they state that something
is provably not the case. Negation as failure states that a state of affairs
cannot be proved, i.e. there is no information whether the state of affairs is
the case or not.



    It is not provable that a customer inserts a card.


### Interrogative Sentences

ACE supports three forms of interrogative sentences: _yes/no_ queries, _wh_
-queries and _how much/many_ -queries. Note that interrogative sentences need
always a question mark at the end.

_Yes/no_ -queries ask for the existence or non-existence of a specified
situation.



    Does a customer insert a card?
    Is John a customer?


With the help of _wh_ -queries, i.e. queries with query words, we can
interrogate a text for details of the specified situation. If we specified



    A trusted customer inserts a valid card manually.


we can ask for each element of the sentence with the exception of the verb.



    Who inserts a card?
    Which customer inserts a card?
    What does a customer insert?
    How does a customer insert a card?


With the help of _how much/many_ -queries we can ask for the amount of a mass
or measurement noun, or for the number of countable nouns. If we specified



    A customer owns 2 kg of gold.


we can ask both for the number of customers and for the amount of gold.



    How many customers own how much gold?


### Imperative Sentences

ACE also supports imperative sentences, called commands. A command consists of
a noun phrase (the addressee), followed by a comma, followed by an
uncoordinated verb phrase. A command has to end with an exclamation mark.



    John, go to the bank!
    John and Mary, wait!
    Every dog, bark!
    John's brother, give the book to Mary!


## Constraining Ambiguity

To constrain the ambiguity of full English ACE employs three simple means

  * some ambiguous constructs are not part of the language; unambiguous alternatives are available in their place
  * all remaining ambiguous constructs are interpreted deterministically on the basis of a small number of interpretation rules
  * users can either accept the assigned interpretation, or they must rephrase the input to obtain another one

### Avoidance of Ambiguity

Here is an example how ACE replaces ambiguous constructs by unambiguous
constructs. In full natural language relative clauses combined with
coordinations can introduce ambiguity. Who opens the account in the following
case?



    A customer inserts a card that is valid and opens an account.


In ACE the sentence has the unequivocal meaning that the customer opens the
account. This is reflected by the paraphrase generated by the ACE parser



    There is a customer X1. There is a card X2. The card X2 is valid.
    The customer X1 inserts the card X2. The customer X1 opens an account.


To express the alternative meaning that the card opens the account the
relative pronoun _that_ must be repeated, thus yielding a coordination of
relative clauses.



    A customer inserts a card that is valid and that opens an account.


with the paraphrase



    There is a customer X1. There is a card X2. The card X2 is valid.
    The customer X1 inserts the card X2. The card X2 opens an account.



### Interpretation Rules

However, not all ambiguities can be safely removed from ACE without rendering
it stilted and artificial. To deterministically interpret otherwise
syntactically correct ACE sentences we use a small set of [interpretation
rules](ace_interpretationrules.html). For example, if we write



    A customer inserts a card with a code.


then _with a code_ attaches to the verb _inserts_ , but not to _a card_.
However, this may not be what we meant to say. To express that the code is
associated with the card we can employ the interpretation rule that a relative
clause always modifies the immediately preceding noun phrase, and rephrase the
input as



    A customer inserts a card that carries a code.


yielding the paraphrase



    There is a card X1. There is a customer X2.
    The customer X2 inserts the card X1. The card X1 carries a code.


or — to specify that the customer inserts a card and a code — as



    A customer inserts a card and a code.


## Anaphoric References

Usually an ACE text consist of more than one sentence, e.g.



    A customer enters a card and a code.
    If a code is valid then the ATM accepts a card.


To express that all occurrences of card and code should mean the same card and
the same code, ACE provides anaphoric references for instance via the definite
article, i.e.



    A customer enters a card and a code.
    If the code is valid then the ATM accepts the card.


During the processing of the ACE text, all anaphoric references are replaced
by the most recent and most specific accessible noun phrase that agrees in
gender and number. What does "most recent and most specific" mean?

Given the sentence



    A customer enters a red card and a blue card.


then



    The card is correct.


refers to the second card, while



    The red card is correct.


refers to the first card.

What does "accessible" mean? Like in English noun phrases introduced in _if-
then_ sentences, universally quantified sentences, negations, modality, and
subordinated sentences cannot be used anaphorically in subsequent sentences.
Thus for each of the sentences



    If a customer owns a card then he enters it.
    Every customer enters a card.
    A customer does not enter a card.
    A customer can enter a card.
    A clerk believes that a customer enters a card.


we **cannot** refer to _a card_ with



    The card is correct.


Anaphoric references are also possible via personal pronouns



    A customer enters a card and a code.
    If it is valid then the ATM accepts the card.


or via variables



    A customer enters a card X and a code Y.
    If Y is valid then the ATM accepts X.


Anaphoric references via definite articles and variables can be combined.



    A customer enters a card X and a code Y.
    If the code Y is valid then the ATM accepts the card X.


Note that proper names like _John_ always refer to the same entity.

2013-07-31

