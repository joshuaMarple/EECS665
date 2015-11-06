# Joshua Marple

# Lab 7 

# Problem Statement
The report should include the objective of this lab, as well as, describe how your program works at a high level. You should discuss the functionality of the resulting design and explain why your implementation of this project works. Also, briefly discuss any troubles you had in writing and testing this program. Make sure to "make clean" your project and remove any debugging flags you added before submission.

# Description

In this lab, we constructed a symbol table for a c-like language. This symbol table was constructed by writing out the `enterblock`, `leaveblock`, and `dump` functions inside of `sym.c`, and by modifying the functions `fname`, `ftail`, `blockdcl`, and `btail` inside of `sem_sym.c`. 

# How the program works

At a high level, this program works by defining blocks of code, and then tracking the symbols within those blocks. By keeping track of the level and the block that the symbols are contained in (via `enterblock` and `leaveblock`), we are able to tell where we are in the program thus far.

After entering and leaving each of these blocks, we also dump the symbol table that is contained within the block (line 114 `sym.c`)

# Problems/Concerns

I had a number of issues in this lab with getting lost in what exactly was expected of each of the functions, and how to handle the identifiers. For some functions, what was required was obvious (`enterblock` for example). For others, such as `exit_block`, the correct solution was somewhat less clear. 

While the overall goal of the lab seems obvious, perhaps the slides could be more clear on how to implement the solution. 

