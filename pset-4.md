---
layout: page
title: PSet-4
parent: Assignments
grand_parent: Deliverables
nav_order: 4
description: Hamming distance and approximate matching problem set.
---

# PSet-4: Approximate Matching

**Due Tuesday, November 3, 2026.**

[Assignment instructions and starter files on GitHub](https://github.com/SmithCSC258/stringReps/tree/main/pset-4)

This assignment lives in `pset-4/` in your existing `stringReps` repository.
Complete the four stubs in `src/pset4/`. Replace each TODO comment and
`raise NotImplementedError(...)` line with your code. Keep the function
signatures and `__init__.py` exports as provided.

| Problem | Function | File |
| --- | --- | --- |
| [BA1G: Hamming Distance](https://rosalind.info/problems/ba1g/) | `hammingDistance(p, q)` | `src/pset4/hamming_distance.py` |
| [BA1H: Approximate Pattern Matching](https://rosalind.info/problems/ba1h/) | `approximatePatternMatching(pattern, text, d)` | `src/pset4/approximate_pattern_matching.py` |
| [BA1I: Frequent Words with Mismatches](https://rosalind.info/problems/ba1i/) | `frequentWordsWithMismatches(text, k, d)` | `src/pset4/frequent_words_with_mismatches.py` |
| [BA1J: Frequent Words with Mismatches and Reverse Complements](https://rosalind.info/problems/ba1j/) | `frequentWordsWithMismatchesAndReverseComplements(text, k, d)` | `src/pset4/frequent_words_with_mismatches_and_reverse_complements.py` |

Refer to the linked Rosalind pages for the problem requirements. The BA1H
signature takes the pattern first, matching Rosalind's input order. Return
an integer for BA1G, a list of integer positions for BA1H, and a set of
strings for BA1I and BA1J.

## Submission

[PSet-4 submission form](https://docs.google.com/forms/d/e/1FAIpQLSd0zsJdmnuo_apBuWpc1WmneGKKkNWJKFo4jFQv_nAxUt1e_g/viewform?usp=header)
