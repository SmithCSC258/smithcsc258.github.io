---
layout: page
title: PSet-1
parent: Assignments
grand_parent: Deliverables
nav_order: 1
description: Frequent Words problem set.
---

# PSet-1: Frequent Words

**In-class assignment: Friday, September 25, 2026.**

[Assignment instructions and starter files on GitHub](https://github.com/SmithCSC258/stringReps/tree/main/pset-1)

Implement two functions for analyzing text (such as DNA sequences):

- `PatternCount(text, pattern)`: count occurrences, including overlapping matches.
- `FrequentWords(text, k)`: find all most frequent length-`k` substrings.

Both functions start as TODO stubs that raise `NotImplementedError`. Their
docstrings describe the expected behavior and assumptions.

## Package layout

```text
pyproject.toml                  # Package metadata and build configuration
src/
    frequent_words/
        __init__.py             # Makes both functions available to import
        pattern_count.py        # Implement PatternCount here
        frequent_words.py       # Implement FrequentWords here
```

Separate `.py` files are called **modules**. A directory of related modules
with an `__init__.py` file forms a Python **package**. Putting these functions
in separate modules is valid Python practice; related small functions can
also share a module.

Python convention normally uses `pattern_count` and `frequent_words` for
function names. This starter keeps `PatternCount` and `FrequentWords` to
match the algorithm names used in class, while using lowercase module names.
