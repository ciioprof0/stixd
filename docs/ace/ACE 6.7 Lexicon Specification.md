# ACE 6.7 Lexicon Specification

## General notes

This document describes the lexicon format for ACE 6.7.

Lexicons can be used in two ways. They can be used as a _Clex_ ("common
lexicon" or "compiled lexicon") which is compiled into the APE executable.
Alternatively, they can be used as a _Ulex_ ("user lexicon" or "uncompiled
lexicon") that is loaded at run-time using the command line, the web
interface, the web service, or any other interface to the parser.

User lexicons _Ulex_ can be used independently, or can complement _Clex_ in
which case entries of _Ulex_ take precedence over those of _Clex_.

The ACE lexicon describes English adverbs, adjectives, nouns, verbs, and
prepositions. It does not describe function words like pronouns or
quantifiers. There are 11 different word classes: adverbs, intransitive
adjectives, transitive adjectives, countable nouns, mass nouns, measurement
nouns, proper names, intransitive verbs, transitive verbs, ditransitive verbs,
and prepositions.

The different forms of the words are represented by different Prolog facts.
Each fact minimally contains one entry that defines the word form which will
appear in the ACE text, and one entry that defines the symbol how it will
appear in the logical representation. All entries must be Prolog atoms.
Furthermore, the entry for the word form (that will appear in the ACE text)
must contain nothing but lower and upper case letters (`a-z`, `A-Z`), digits
(`0-9`), hyphens (`-`), underscores (`_`), dollar signs (`$`), and degree
signs (`°`). The first character must not be a digit or a hyphen. Blank
spaces are not allowed. You should use hyphens in places where blank spaces
would be used in natural English. E.g. write 'credit-card' instead of 'credit
card'.

Because the lexicon is written in Prolog, symbols special for Prolog (e.g.
apostrophe) must be escaped. Capitalized words (e.g. proper names) must be in
quotes, otherwise they would be considered variables by Prolog.

## Word classes

### Adverbs

Adverbs (e.g. "fast", "quickly", "intensively") are represented by three
different kinds of entries, defining the positive form, the comparative form,
and the superlative form respectively:



    adv(PositiveForm, LogicalSymbol).
    adv_comp(ComparativeForm, LogicalSymbol).
    adv_sup(SuperlativeForm, LogicalSymbol).


For regular comparative and superlative forms (starting with "more" or
"most"), only the positive form needs to be defined. In order to use "more
quickly", for example, it is sufficient to define the positive form "quickly".
Some concrete examples:



    adv(fast, fast).
    adv_comp(faster, fast).
    adv_sup(fastest, fast).

    adv(quickly, quickly).

    adv(intensively, intensively).


It is recommended to use the positive form also as the logical symbol.
Furthermore, it is recommended to define a positive form for each comparative
or superlative form.

### Intransitive adjectives

Intransitive adjectives (e.g. "important", "large", "expensive") are
represented by three different kinds of entries, defining the positive form,
the comparative form, and the superlative form respectively:



    adj_itr(PositiveForm, LogicalSymbol).
    adj_itr_comp(ComparativeForm, LogicalSymbol).
    adj_itr_sup(SuperlativeForm, LogicalSymbol).


Again, for regular comparative and superlative forms (starting with "more" or
"most"), only the positive form needs to be defined. Some concrete examples:



    adj_itr(important, important).

    adj_itr(large, large).
    adj_itr_comp(larger, large).
    adj_itr_sup(largest, large).

    adj_itr(expensive, expensive).


It is recommended to use the positive form also as the logical symbol.
Furthermore, it is recommended to define a positive form for each comparative
or superlative form.

### Transitive adjectives

Transitive adjectives (e.g. "valid-for", "fond-of", "pessimistic-about") are
represented by three different kinds of entries, defining the positive form,
the comparative form, and the superlative form respectively:



    adj_tr(PositiveForm, LogicalSymbol, Preposition).
    adj_tr_comp(ComparativeForm, LogicalSymbol, Preposition).
    adj_tr_sup(SuperlativeForm, LogicalSymbol, Preposition).


Transitive adjectives should consist of an adjective and a preposition that is
hyphenated to the adjective. Again, for regular comparative and superlative
forms (starting with "more" or "most"), only the positive form needs to be
defined. `Preposition` is the preposition part of the word, e.g. "for" in the
case of "valid-for", "of" in the case of "fond-of", and "about" in the case of
"pessimistic-about". It is only used for the comparative form in sentences
where the preposition can occur on its own, like in "Mary is more fond-of Bill
than **of** John". Some concrete examples:



    adj_tr('valid-for', 'valid-for', for).

    adj_tr('fond-of', 'fond-of', of).
    adj_tr_comp('fonder-of', 'fond-of', of).
    adj_tr_sup('fondest-of', 'fond-of', of).

    adj_tr('pessimistic-about', 'pessimistic-about', about).


It is recommended to use the positive form also as the logical symbol.
Furthermore, it is recommended to define a positive form for each comparative
or superlative form.

### Countable nouns

Countable nouns (e.g. "woman", "credit-card", "month") are represented by two
different kinds of entries, defining the singular form and the plural form
respectively:



    noun_sg(SingularForm, LogicalSymbol, Gender).
    noun_pl(PluralForm, LogicalSymbol, Gender).


Defining a countable noun "credit-card", for example, you can say "a credit-
card", "every credit-card", or "at most 5 credit-cards". The plural form
should usually be the singular form with an 's' at the end like "credit-cards"
or "months". Some concrete examples:



    noun_sg(woman, woman, fem).
    noun_pl(women, woman, fem).

    noun_sg('credit-card', 'credit-card', neutr).
    noun_pl('credit-cards', 'credit-card', neutr).

    noun_sg(month, month, neutr).
    noun_pl(months, month, neutr).


`Gender` has to be one of {`undef`, `neutr`, `human`, `masc`, `fem`} and
specifies the linguistic gender of the noun. `undef` is the top category
having two direct subcategories `neutr` and `human` where `human` has again
two subcategories `masc` and `fem`. Depending on the gender, different forms
of pronouns are supported. The table below shows the concrete pronouns. Note
that not only the pronouns listed for a particular gender but also all
pronouns of all super- and subcategories can be used.

Gender | Anaphoric Pronouns | Possessive Pronouns | Relative Pronouns
---|---|---|---
undef | they, them, themselves | their, their own | that, whose
neutr | it, itself | its, its own | which
human | he/she, she/he, him/her, her/him, himself/herself, herself/himself | his/her, her/his, his/her own, her/his own | who
masc | he, him, himself | his, his own |
fem | she, her, herself | her, her own |

It is recommended to use the singular form also as the logical symbol.
Furthermore, it is recommended to define a singular form for each plural form,
and vice versa.

### Mass nouns

Countable nouns (e.g. "water", "fear", "money") are represented by only one
kind of entry:



    noun_mass(WordForm, LogicalSymbol, Gender).


Mass nouns have only one word form. Defining a mass noun "water", for example,
you can say "some water", "all water", or "5 kg of water". The gender of mass
nouns is defined in the same way as for countable nouns (see previous
section). Some concrete examples:



    noun_mass(water, water, neutr).

    noun_mass(fear, fear, neutr).

    noun_mass(money, money, neutr).


It is recommended to use the word form also as the logical symbol.

### Measurement nouns

Measurement nouns (e.g. "kg", "m", "Â°C") are represented by only one kind of
entry:



    mn_sg(SingularForm, LogicalSymbol).
    mn_pl(PluralForm, LogicalSymbol).


It is recommended to define measurement nouns in the form of measurement
symbols (i.e. "m" instead of "meter"). In this case, the singular and plural
forms should usually be the same. Some concrete examples:



    mn_sg(kg, kg).
    mn_pl(kg, kg).

    mn_sg(m, m).
    mn_pl(m, m).

    mn_sg('Â°C', 'Â°C').
    mn_pl('Â°C', 'Â°C').


It is recommended to use the singular form also as the logical symbol.
Furthermore, it is recommended to define a singular form for each plural form,
and vice versa.

### Proper names

Proper names come in two versions: one for those that require a preceeding
definite article (e.g. "the Nile", "the United-Nations") and one for those
that stand by itself (e.g. "John", "Nokia"). Proper names can also be declared
in both of those categories (e.g. "(the) Mona-Lisa").



    pn_sg(WordForm, LogicalSymbol, Gender).
    pn_pl(WordForm, LogicalSymbol, Gender).
    pndef_sg(WordForm, LogicalSymbol, Gender).
    pndef_pl(WordForm, LogicalSymbol, Gender).


`Gender` has the same meaning as for countable nouns. Some concrete examples:



    pn_sg('John', 'John', masc).

    pn_sg('Nokia', 'Nokia', neutr).

    pndef_sg('Nile', 'Nile', neutr).

    pndef_pl('United-Nations', 'United-Nations', neutr).

    pn_sg('Mona-Lisa', 'Mona-Lisa', neutr).
    pndef_sg('Mona-Lisa', 'Mona-Lisa', neutr).


It is not allowed to declare the same proper name as singular and plural at
the same time. It is recommended to use the word form also as the logical
symbol.

### Intransitive verbs

Intransitive verbs (e.g. "waits", "goes-away", "walks") are represented by two
different kinds of entries, defining the third singular form and the
infinitive form respectively:



    iv_finsg(ThirdSgForm, LogicalSymbol).
    iv_infpl(InfForm, LogicalSymbol).


The infinitive form should usually be the singular form without the 's' at the
end: "wait", "walk". Phrasal particles should be hyphenated to the verb, e.g.
"goes-away". Some concrete examples:



    iv_finsg(waits, wait).
    iv_infpl(wait, wait).

    iv_finsg('goes-away', 'go-away').
    iv_infpl('go-away', 'go-away').

    iv_finsg(walks, walk).
    iv_infpl(walk, walk).


It is recommended to use the infinitive form also as the logical symbol.
Furthermore, it is recommended to define a third singular form for each
infinitive form, and vice versa.

### Transitive verbs

Transitive verbs (e.g. "knows", "likes", "relates-to") are represented by
three different kinds of entries, defining the third singular form, the
infinitive form, and the past participle form respectively:



    tv_finsg(ThirdSgForm, LogicalSymbol).
    tv_infpl(InfForm, LogicalSymbol).
    tv_pp(PastPartForm, LogicalSymbol).


Phrasal particles and direct prepositions should be hyphenated to the verb,
e.g. "relates-to", "lives-in", and "comes-up-with". The past participle is the
form that is used for passive voice: "known", "liked", "seen". If it is not
defined then passive voice is not possible for the respective verb. Some
concrete examples:



    tv_finsg(knows, know).
    tv_infpl(know, know).
    tv_pp(known, know).

    tv_finsg(likes, like).
    tv_infpl(like, like).
    tv_pp(liked, like).

    tv_finsg('relates-to', 'relate-to').
    tv_infpl('relate-to', 'relate-to').
    tv_pp('related-to', 'relate-to').


It is recommended to use the infinitive form also as the logical symbol. It is
also recommended to define a third singular form for each infinitive form, and
vice versa. Furthermore, it is recommended to define third singular and
infinitive forms for each past participle form.

### Ditransitive verbs

Diransitive verbs (e.g. "shows", "forgives", "succeeds") are represented by
three different kinds of entries, defining the third singular form, the
infinitive form, and the past participle form respectively:



    dv_finsg(ThirdSgForm, LogicalSymbol, Preposition).
    dv_infpl(InfForm, LogicalSymbol, Preposition).
    dv_pp(PastPartForm, LogicalSymbol, Preposition).


ACE allows two forms of ditransitive verbs:

  * Verbs which take two complements neither of which is introduced by a preposition (e.g. "John shows Mary an apple.", "John forgives Mary her shortcomings."). The first complement is considered to be an indirect object, the second a direct object. In this case the preposition argument must be set to the empty atom ''.
  * Verbs which take two complements, second of which is prepositional, i.e. introduced by a preposition (e.g. "John shows an apple to Mary", "John succeeds Mary as the president"). The first complement is considered to be a direct object, the second an indirect object. In this case the preposition argument must contain the preposition, e.g. "to" in the case of "show" and "as" in the case of "succeed".

In case a verb allows both forms (such as the verb "show"), each lexicon entry
must be declared twice. Some concrete examples:



    dv_finsg(shows, show, '').
    dv_infpl(show, show, '').
    dv_pp(shown, show, '').
    dv_finsg(shows, show, to).
    dv_infpl(show, show, to).
    dv_pp(shown, show, to).

    dv_finsg(forgives, forgive, '').
    dv_infpl(forgive, forgive, '').
    dv_pp(forgiven, forgive, '').

    dv_finsg(succeeds, succeed, as).
    dv_infpl(succeed, succeed, as).
    dv_pp(succeeded, succeed, as).


It is recommended to use the infinitive form also as the logical symbol. It is
also recommended to define a third singular form for each infinitive form, and
vice versa. Furthermore, it is recommended to define third singular and
infinitive forms for each past participle form.

### Prepositions

Prepositions (e.g. "in", "for", "during") are represented by only one kind of
entry:



    prep(WordForm, LogicalSymbol).


Prepositions have only one word form. Some concrete examples:



    prep(in, in).

    prep(for, for).

    prep(during, during).


It is recommended to use the word form also as the logical symbol.

## Aliases

In order to define aliases, i.e. word forms that are parsed in exactly the
same way, one has to create several entries with the same logical symbol. Some
examples:



    adj_itr(gray, gray).
    adj_itr(grey, gray).

    noun_sg(cactus, cactus, neutr).
    noun_pl(cacti, cactus, neutr).
    noun_pl(cactuses, cactus, neutr).

    pndef_pl('United-States', 'USA', neutr).
    pndef_pl('USA', 'USA', neutr).


## Word class intersections

Generally, word class intersections are allowed. E.g. the verb "eats" can be
declared as an intransitive verb and as a transitive verb at the same time.
But there are some intersections that are not allowed:

  * Adverbs are not allowed to intersect with countable nouns or mass nouns.
  * Adverbs are not allowed to intersect with intransitive verbs.
  * Intransitive adjectives are not allowed to intersect with transitive adjectives.
  * Proper names with a definite article are not allowed to intersect with countable nouns or mass nouns.
  * Prepositions are not allowed to intersect with intransitive adjectives.
  * Prepositions are not allowed to intersect with transitive verbs.

The following table illustrates these restrictions. Fields containing an "X"
denote intersections that are not allowed. (The gray fields are a mirror image
of the white ones.)

> ![Word class intersection
> table](http://attempto.ifi.uzh.ch/site/docs/images/intersect_080728.jpg)

In addition, the following function words cannot be used as word forms in the
lexicon:



    null, zero, one, two, three, four, five, six, seven, eight, nine, ten, eleven, twelve, dozen, there,
    and, or, not, that, than, of, if, then, such, be, provably, more, most, are, is, the, a, an, some,
    no, every, all, each, which, its, his, her, their, whose, it, he, she, they, him, them, itself,
    himself, herself, themselves, someone, somebody, something, nobody, nothing, everyone, everybody,
    everything, what, who, how, where, when


All other function words (e.g. "can", "at", "true") can be used.

2013-07-31

