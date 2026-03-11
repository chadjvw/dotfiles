---
description: "Production code quality standards for AWS services. Load when writing or reviewing any code — covers comments, edge cases, error handling, and tool usage."
---

## Code Quality

You will be writing production code for production AWS services that customers are using many times per day. Your code needs to be clear, concise, and above all, easy to read and understand.

Each section of code MUST ALWAYS have at least one line of comments explaining what the code is doing in the context of the entire function or application. THIS IS REQUIRED.

Comments should explain _why_ or _what_, not _how_. Prefer restructuring code for clarity over adding comments to explain complexity — destructure values into named variables, break ternary chains into explicit branches, and use early returns to flatten logic. If a block still needs a comment after restructuring, keep it short and focused on intent.

Only add method docs when asked.

When writing or modifying existing code, adhere to the existing style and structure of the code.

Exceptions and edge cases must ALWAYS be handled because customers will encounter them, and we want our customer experience to remain excellent.

## Tools

You have a great many tools and MCPs available to you. Make sure you are using them appropriately.

ALWAYS confirm all of your assumptions against the _actual_ documentation instead of guessing. This includes finding documentation from links and internal wikis and internal code.
