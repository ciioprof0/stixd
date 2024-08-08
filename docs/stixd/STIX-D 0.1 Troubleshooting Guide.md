# ACE 6.7 Troubleshooting Guide
<!-- ToDo List
- Convert to STIX-D.
- Remove line breaks in same
- Replace ACE examples with relevant examples from STIX-D corpus.
-->

<!-- Original ACE 6.7 text, Date: 2013-07-31 -->
ACE supplies the means to express texts in a concise, unambiguous and easily
understandable way. However, effective use of the language ACE needs some
experience. This document shows typical problems in using ACE and gives advice
how to solve them, or how to avoid them.

To indicate the meaning of a phrase we use {...} that should not be confused
with ACE's set notation. A sentence prefixed with `*` is not part of ACE, but
serves as counter example.

## General Hints

### Construction

  * Only use complete sentences. Put a full-stop after declarative sentences, a question-mark after interrogative sentences, and an exclamation mark after imperative sentences.
  * Commas are only possible in front of _and_ and _or_ , in a specific position within imperative sentences, and in lists and sets.
  * Do not use any other punctuation.
  * Stick to the predefined word order of ACE.
  * Every noun needs a determiner.
  * Make sure you comply with the definition, use and interpretation of ACE function words.

Though the ACE parser will unravel every syntactically correct sentence,
however complex, you may have problems to do so. Thus keep your sentences
short and simple. Specifically

  * Avoid unnecessarily complex coordinations.
  * Avoid unnecessarily involved combinations of negation, quantification and coordination.
  * Use several short sentences instead of one complex sentence.
  * Give agents for all actions: use active sentences or passive sentences with the phrase _by ..._.

### Interpretation

  * Be as explicit as possible.
  * Avoid ambiguous or misleading constructions.
  * Check that the paraphrase given by the Attempto system reflects your intended interpretation. If it does not, reformulate your sentence.
  * In doubt, look-up the [ACE interpretation rules](ace_interpretationrules.html).

## Troubleshooting

After you have entered a text, the Attempto system analyses it and returns a
paraphrase. Two things can go wrong: the Attempto system does not accept (part
of) your text, or it accepts your text but the paraphrase does not reflect
your intended interpretation. In both cases the text has to be modified. The
following sections show typical causes for errors and give strategies for
reformulation.

### What if the Attempto system does not accept your input?

Sentences are rejected when they contain unknown or misspelled words, or when
the structure of the sentences does not correspond to the ACE grammar. In each
case, the Attempto system processes your input up to the first incorrect
sentence, and then generates error messages and suggestions for improvement.
Misspelled or unknown words are listed for your convenience. If there are
syntax errors, the first erroneous sentence is displayed.

The ACE parser will generate error and warning messages and also suggestions
how to avoid the errors. However, not all errors are completely identified and
correctly localised. The following checklist helps you to systematically look
for the causes of errors.

#### Do you use words or word forms that are not in the lexicon?

  * You have misspelled a word.
  * You use function words that are not defined.
  * You use content words that you have not defined.
  * You have incorrectly classified a content word, i.e. in the text you use the word not in accordance to your classification, e.g. wrong word class, wrong type, wrong number or category of complements etc.

Correct misspelled words, and use defined words correctly.

#### Do you use constructions that are not available in the ACE grammar?

  * Do not use other tenses than the simple present.
  * Do not put adverbs or prepositional phrases at the beginning of the sentence.
  * Always start implications with the condition (_if_) followed by the consequence (_then_). Do not add a comma in front of the _then_.
  * Do only coordinate phrases of the same syntactic type.
  * Always begin a relative clause with one of the relative pronouns _who_ , _which_ , or _that_.
  * Do not use nouns without a determiner.
  * Do not use prepositional phrases — except _of_ -phrases — as modifiers of nouns _A card in a slot is invalid._. Use a relative clause instead _A card that is in a slot is invalid._
  * Always add an agent to a passive construct _A code is entered by a customer._ or use the active _A customer enters the code._.

### What if sentences do not reflect the intended interpretation?

If a sentence is accepted by the system but the paraphrase does not correspond
to the intended interpretation then you have to reformulate the sentence. Here
are some hints.

#### Prepositional Phrases

Prepositional phrases used as adjuncts modify the verb, not the noun. If you
want to modify the noun, you have to use a relative clause. In the relative
clause you have to introduce a verb or an adjective that captures the intended
meaning.

Use a relative clause to modify the noun (except for _of_ -constructions).



    Input: A bank accepts every card with a blue sign.
    Interpretation: There is a bank.
    If there is a card then the bank accepts the card with a blue sign.


This interpretation is not intended, since it means that the instrument of
accepting the card is the blue sign.



    Reformulation: A bank accepts every card that has a blue sign.
    Interpretation: There is a bank.
    If a card has a blue sign then the bank accepts the card.


#### Anaphoric Reference

You can use proper nouns or anaphors — personal pronouns, definite noun
phrases and variables — to refer to a previously mentioned noun phrase. To
resolve an anaphoric reference, the system always chooses the most recent and
most specific noun phrase that has the same number and gender, and that is
accessible. Sometimes you may find that this choice does not reflect your
intended interpretation. The following sentences show techniques how you can
manipulate the sentence structure to get the intended connection.

Use a definite noun phrase instead of a pronoun.



    Input: If a credit-card has a signature then it is valid.
    Interpretation: If a credit-card has a signature then the signature is valid.



    Reformulation: If a credit-card has a signature then the credit-card is valid.


Use a relative clause.



    Input: If a customer pushes the key then the automatic-teller prints a receipt. It shows the date of the transaction.


ACE does not accept the second sentence because no noun phrase is accessible
in the first sentence to replace the personal pronoun _it_.



    Reformulation: If a customer pushes the key then the automatic-teller prints a receipt that shows the date of the transaction.


In the sentence



    Every customer has a card and a personal-code. The personal-code is associated with the card.


there are no anaphoric connections between _the card_ and _a card_ , and
between _the personal-code_ and _a personal-code_ , because noun phrases in
the scope of _every_ are not accessible from subsequent sentences.



    Reformulation: Every customer has a card and a personal-code that is associated with the card.


#### _of_ -Constructs

It is possible to refer back to both parts of an _of_ -construction
separately.



    A student gives a demonstration of a program. The program runs on a computer. The demonstration is in a room.


An _of_ -construct followed by a noun phrase conjunction pertains to the
complete noun phrase conjunction. Thus the following sentence



    A man sees a dog of Mary and John.


that is ambiguous in English gets in ACE the unique interpretation that a man
sees a dog that belongs to both Mary and John, i.e. as _A man sees {a dog of
Mary and John}_. To express that the man sees John and a dog of Mary, one can
write



    A man sees John and a dog of Mary.


Similarly the sentence



    John assesses a degree of Toxicity and a degree of Dehydration.


is — probably incorrectly — interpreted as _John assesses {a degree of
{Toxicity and a degree of Dehydration}}._ To get the intended interpretation
you could write



    John assesses a degree of Toxicity and assesses a degree of Dehydration.


#### Binding Hierarchy

If you combine _and_ and _or_ you have to be aware of the binding hierarchy
that controls which parts belong more closely to each other. By default, _and_
binds stronger than _or_. However, you can override the default binding in
various ways.



    The customer enters a red card or enters a blue card and enters a personal-code.


ACE interprets this sentence as expressing two alternatives. The customer
entering a red card is the first alternative. The customer entering a blue
card and a personal code is the second alternative. If this interpretation
does not correspond to your intention there are several possibilities for
reformulation.

Use commas to override the binding hierarchy and explicitly show the intended
structuring.



    The customer enters a red card or enters a blue card, and enters a personal-code.


ACE interprets this as two alternatives. In the first alternative the customer
enters a red card, or a blue card. In the second alternative the customer
enters a personal code. Note that _and_ and _or_ have only a logical, not a
temporal meaning.

Make two simpler sentences.



    The customer enters a red card or enters a blue card.
    The customer enters a personal-code.


Repeat conjuncts.



    The customer enters a red card and enters a personal-code or enters a blue card and enters a personal-code.


#### How to Express Exclusive Disjunction?

In ACE, _or_ expresses inclusive disjunction, i.e. the sentence



    If the customer works in a bank then he gets a red card or gets a blue card.


means that the customer can get a red card or a blue card, or both. If you
want to exclude that both cards are handed out, i.e. if you want to express
exclusive disjunction, you can reformulate the sentence:



    If the customer works in a bank then he gets a red card and gets no blue card, or he gets a blue card and gets no red card.


#### Relative Sentences

Relative sentences always relate to the immediately preceding noun phrase.
This principle of right association eliminates ambiguities but may in some
cases conflict with the intended interpretation. To achieve the intended
interpretation you have to reformulate your input. We recommend the following
techniques. ({...} indicate what the relative clause is intended to relate to,
respectively actually relates to.)

Split the sentence into two sentences and repeat the intended noun phrase.



    Input: John returns {a copy of a book that is damaged}.

    Interpretation: John returns a copy of {a book that is damaged}.

    Reformulations:

    John returns a copy of a book. The copy of the book is damaged.
    John returns a copy of a book. The copy is damaged.
    John returns a copy of a book and the copy is damaged.


Move the relative clause to a different position.



    Input: The customer enters {a card into the slot which is invalid}.

    Interpretation: The customer enters a card into {the slot which is invalid}.

    Reformulations:

    The customer enters a card which is invalid into the slot.
    The customer enters a card into the slot. The card is invalid.
    The customer enters a card into the slot and the card is invalid.


Avoid the relative clause and use an adjective instead.



    Input: The customer enters {a card into the slot which is invalid}.

    Interpretation: The customer enters a card into {the slot which is invalid}.

    Reformulation: The customer enters an invalid card into the slot.


Note that ACE will translate _a valid card_ and _a card that is valid_
differently.

Replace the constructor _every_ and use an implication instead.



    Input: {Every copy of a book that has a yellow point} is not available.

    Interpretation: Every copy of {a book that has a yellow point} is not available.

    Reformulation: If a copy of a book has a yellow point then the copy is not available.


#### Relative Sentences and Coordination

Verb phrases preceded by a coordinator after a relative clause belong to the
main sentences not the relative clause.

To make the coordinated verb phrase belong to the relative clause repeat the
relative pronoun _that_.



    Input: The customer enters a card that is valid and has a code.

    Interpretation: The customer enters {a card that is valid} and has a code.

    Reformulation: The customer enters {a card that is valid and that has a code}.


The following sentence



    John knows Bill who knows Mary and Sue.


is interpreted as _John knows {Bill who knows {Mary and Sue}}._ To get the
interpretation _John knows {{Bill who knows Mary} and Sue}._ you could use one
of the following alternatives



    John knows Sue and Bill who knows Mary.
    John knows Bill who knows Mary. John knows Sue.



#### Quantification

Make sure you express the intended scoping when you use quantifiers. Remember
that the textual order of the quantifiers corresponds to their relative scope.
That means you have to change the position of the quantifiers in the sentence
to change their scope. This restructuring can be done by using the passive, or
the constructors _there is a_ and _for every_ — even though this may lead to
sentences that sound less natural than the original ones. Scoping problems
often occur when you use a universally quantified noun phrase within a
prepositional phrase, e.g. _a copy of every book_.



    Input: John assigns a personal-code to every customer.
    Interpretation: There is a personal-code. If there is a customer then John assigns the customer the personal-code.


Thus every customer gets the same personal code. In order to express that
every customer gets an individual personal code, reformulate:



    Every customer is assigned a personal-code by John.
    For every customer John assigns a personal-code to the customer.
    For every customer there is a personal-code that John assigns to the customer.
    If there is a customer then John assigns the customer a personal-code.



    Input: Every employee gets an extra holiday.
    Interpretation: If there is an employee then the employee gets a extra holiday.


Thus every employee gets an individual extra holiday. In order to express that
the extra holiday is the same for every employee, reformulate:



    There is an extra holiday that every employee gets.


#### Quantification and Coordination

Note that in ACE a sentence like



    Every tourist has a red card or has a blue card.


means that some tourists have a red card, others have a blue card, some have
possibly both, i.e. all tourists do have at least one of the two types of
credit cards. The sentence does not mean that every tourist has the same type
of credit card. This meaning would have to be expressed by using two
universally quantified statements:



    Every tourist has a red card or every tourist has a blue card.


#### Negation

Combinations of negators (_no_ , _does not_ , _is not_) with coordinators or
quantifiers must be used carefully. We recommend to be as explicit as possible
when combining these constructors.

##### Negation and Coordination



    Input: The ATM does not accept a red card or does not accept a blue card.

    Interpretation: It is false that the ATM accepts a red card or it is false that the ATM accepts a blue card.


In ACE the sentence does not mean that the ATM accepts neither a red card nor
a blue card. If you want to express this meaning you have several
possibilities.

Use a plural object.



    The ATM does not accept a red card and a blue card.


Coordinate the negation, possibly by making two separate sentences.



    The ATM does not accept a red card and does not accept a blue card.

    The ATM does not accept a red card. The ATM does not accept a blue card.


##### Negation and Quantification

When you combine negation with quantifiers, take into account that first the
negation (_is not_ or _does not_) is distributed, then surface order
determines the scope of the quantifier. Users familiar with predicate logic
may notice that reformulations are possible on the basis of predicate logical
identities, e.g. _(there is) no_ is the same as _(for) every ... not_ , etc.



    Input: Every card is not valid.

    Interpretation: If there is a card then it is false that the card is valid.

    Input: There is a card that is not valid.

    Interpretation: There is a card. It is false that the card is valid.

    Input: Every card is not valid or is not green.

    Interpretation: If there is a card then it is false that the card is valid or it is false that the card is green.


## Examples of common mistakes

The following lists some sentences which sound natural in English, but which
are not covered by ACE.

You want to express that all cats are animals and write



    A cat is an animal.


The determiner _a_ means existential quantification, that is the sentence is
interpreted as _There is a cat. The cat is an animal_. To express that all
cats are animals use, for instance



    Every cat is an animal. (= If there is a cat then the cat is an animal.)


When John sees his wife then it is tempting to write



    John sees his wife.


However, the personal pronoun _his_ is interpreted as referring to a masculine
noun phrase introduced in the previous sentence (e.g. "There is a man. John
sees his wife."). In this case, there is no such preceding sentence and
therefore the anaphora resolution fails. Use instead



    John sees his own wife.


Disjunction of noun phrases is not supported in ACE.



    John enters a card or a code.


Use instead:



    John enters a card or enters a code.


_There-is_ -sentences cannot be modified by prepositional phrases in ACE.



    *There is a card in a slot.


Use instead:



    A card is in a slot.


Adverbs that modify other adverbs are not supported in ACE.



    *John drives extremely carefully.


In order to modify a verb with two or more adverbs, you must coordinate them,
e.g.



    John drives extremely and carefully.


Adverbs that modify complete sentences are not supported in ACE.



    *John only works.


ACE always prefers an intransitive reading of verbs and thus analyses this
sentence as containing an intransitive verb (_comes_) modified by a
prepositional phrase (_across an interesting story_).



    John comes across an interesting story.


Use instead:



    John comes-across an interesting story.


The movement of phrasal particles is not supported in ACE. Also, the phrasal
verbs must be hyphenated.



    John looks up a word. He looks it up.


Use instead:



    John looks-up a word. He looks-up it.


Though the second sentence is acceptable in ACE, it is not pragmatically
acceptable in standard English, and should be replaced by



    He looks-up the word.


## Lexicon Issues

All content words (nouns, verbs, adjectives, adverbs) must be defined in the
built-in lexicon, or in a user-supplied lexicon. If present, user lexicons are
searched first.

Words that fall into more than one word class must occur in the lexicon for
each of the word classes. One example is the word _surface_ that can be a
noun, an adjective, or a verb.



    The surface of the lens is clean.
    Some surface impurities are removed.
    The diver surfaces.


Other examples are chemical elements and compositions that can occur as proper
nouns or as mass nouns.



    Helium is an element.
    The balloon contains 20 kg of helium.


2013-07-31

