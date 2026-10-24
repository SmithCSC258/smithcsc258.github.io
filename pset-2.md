---
layout: page
title: PSet-2
parent: Assignments
grand_parent: Deliverables
nav_order: 2
description: DNA Strings and k-mer Counting problem set.
---

# PSet-2: DNA Strings and k-mer Counting

**Due Sunday, October 4, 2026, at 11:59 p.m.**

[Assignment instructions and starter files on GitHub](https://github.com/SmithCSC258/stringReps/tree/main/pset-2)

**Submission:** Commit and push your work to your GitHub repository by the deadline, even if it is incomplete. Submissions received by the deadline will be reviewed before class on Wednesday, October 7.

For this assignment, you are asked to complete the next four problems on Rosalind (5-8).
Each problem matches with one of the four functions in `src/pset2/`, with all of the imports you are expected to need already provided.
These stubs each contain a TODO comment and a `raise NotImplementedError(...)` line so that you can see where to develop your code and so that you will get an informative error message (not implemented) if your code is not picked up during testing.
Leave the imports and `__init__.py` file as provided to ensure your functions can all run.

| Function | File | Rosalind Problem |
| --- | --- | --- |
| `countNucleotides` | `src/pset2/count_nucleotides.py` | Problem 5 |
| `patternIndex` | `src/pset2/pattern_index.py` | Problem 6 |
| `patternCount` | `src/pset2/pattern_count.py` | Problem 7 |
| `frequentWords` | `src/pset2/frequent_words.py` | Problem 8 |

Refer to each Rosalind page for the specific function requirements.

## Submission

[PSet-2 submission form](https://docs.google.com/forms/d/e/1FAIpQLSd0zsJdmnuo_apBuWpc1WmneGKKkNWJKFo4jFQv_nAxUt1e_g/viewform?usp=header)

## Setup Options

Make sure you are using Python 3.10 or newer. For terminal use, install the
packages in a virtual environment; this does not require administrator permissions.

1. Open a terminal in the repository root, which is the folder containing both `pset-1/` and `pset-2/`.
2. Run:

```sh
python3 -m venv .venv
source .venv/bin/activate
python -m pip install -e ./pset-1 -e ./pset-2
```

On subsequent visits, activate the existing environment with
`source .venv/bin/activate`. When adding a new assignment, run the install
command above to make its package available.

The install command connects both local packages to your environment.
The `-e` means edits in either folder take effect without reinstalling.
You'll want to activate this same environment when you return to work in a new terminal.

For JupyterHub or a Jupyter notebook, open a notebook in the repository root
and run this in a notebook cell to install into the notebook's environment:

```python
%pip install -e ./pset-1 -e ./pset-2
```

Restart the kernel after installation. Activating a virtual environment in
a separate terminal does not change the Python environment of a running notebook.

## Imports from Prior Class Work

The in-class functions are already imported in the corresponding assignment
files under these names:

| Assignment file | Imported name | Source |
| --- | --- | --- |
| `pattern_count.py` | `inclass_pattern_count` | `PatternCount` in `pset-1/src/frequent_words/pattern_count.py` |
| `frequent_words.py` | `inclass_frequent_words` | `FrequentWords` in `pset-1/src/frequent_words/frequent_words.py` |

The `as` keyword in each import provides a local nickname for the imported
function. The setup command above makes the in-class package available;
no file copying or changes to Python's search path are needed.

Python imports use the package names inside the `src/` folders:
`frequent_words` for `pset-1/src/frequent_words/`, and `pset2` for
`pset-2/src/pset2/`. The outer folder names are not Python import names.

After setup, import your assignment functions in Python or a notebook with:

```python
from pset2 import countNucleotides, patternIndex, patternCount, frequentWords
```

Use the package imports instead of running individual source files directly.
Unfinished stubs raise `NotImplementedError` when called.
