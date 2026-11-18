---
layout: page
title: PSet-5
parent: Assignments
grand_parent: Deliverables
nav_order: 5
description: Hamming distance and approximate matching problem set.
---

# PSet-5: Approximate Matching

**Due Friday, November 20, 2026, at midnight (end of day, Eastern Time).**

[Assignment instructions and starter files on GitHub](https://github.com/SmithCSC258/stringReps/tree/main/pset-5)

This assignment lives in `pset-5/` in your existing `stringReps` repository.
Complete the four stubs in `src/pset5/`. Replace each TODO comment and
`raise NotImplementedError(...)` line with your code. Keep the function
signatures and `__init__.py` exports as provided.

| Problem | Function | File |
| --- | --- | --- |
| [BA1G: Hamming Distance](https://rosalind.info/problems/ba1g/) | `hammingDistance(p, q)` | `src/pset5/hamming_distance.py` |
| [BA1H: Approximate Pattern Matching](https://rosalind.info/problems/ba1h/) | `approximatePatternMatching(pattern, text, d)` | `src/pset5/approximate_pattern_matching.py` |
| [BA1I: Frequent Words with Mismatches](https://rosalind.info/problems/ba1i/) | `frequentWordsWithMismatches(text, k, d)` | `src/pset5/frequent_words_with_mismatches.py` |
| [BA1J: Frequent Words with Mismatches and Reverse Complements](https://rosalind.info/problems/ba1j/) | `frequentWordsWithMismatchesAndReverseComplements(text, k, d)` | `src/pset5/frequent_words_with_mismatches_and_reverse_complements.py` |

Refer to the linked Rosalind pages for the problem requirements. The BA1H
signature takes the pattern first, matching Rosalind's input order. Return
an integer for BA1G, a list of integer positions for BA1H, and a set of
strings for BA1I and BA1J.

## Submission

[PSet-5 submission form](https://docs.google.com/forms/d/e/1FAIpQLSd0zsJdmnuo_apBuWpc1WmneGKKkNWJKFo4jFQv_nAxUt1e_g/viewform?usp=header)
