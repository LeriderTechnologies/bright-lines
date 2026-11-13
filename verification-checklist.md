# Verification checklist — claim vs. artifact

The step most agent setups skip. A sub-agent's own summary of its work is still model output: optimistic by
default, written by the same model that might have hit a problem and quietly glossed over it. Before you mark
anything done, check the *claim* against an *artifact* — something that exists independently of the agent's own
account of itself.

**Never mark something done on the strength of a summary alone.** A summary is a claim, not evidence.

## The checklist

For each deliverable a sub-agent reports:

1. **Does the file exist, at the exact path claimed?** Not "a file like that" — the path it gave you, opened and
   skimmed. An agent that names the wrong path, or no path, is a flag on its own.
2. **Does a specific number in the report match a number in a log, file, or re-run?** If it says "processed 412
   rows" or "all 9 tests passed," find that number somewhere other than the prose summary — a
   log line, a test runner's own output, a file's row count — and compare them directly.
3. **Does a quick re-run reproduce the claimed result?** Not a full re-run of everything — the cheapest check
   that would catch a fabricated or stale claim. Running the test suite again, re-opening the file and counting,
   re-running the one command that produces the number.
4. **Does it match other things it should be consistent with?** A claimed commit should show up in `git log`. A
   claimed board update should show up in the board. A claimed send should show up in the outbox (if it even got
   that far — sending is outward-facing and should have stopped for a human first; see `boundary-rules.md`).
5. **If anything above doesn't check out:** don't quietly fix it and move on as if nothing happened. Record what
   the agent claimed, what you actually found, and treat the gap itself as a finding — it's often a sign of a
   pattern worth fixing upstream (a brief that invited guessing, a tool that fails silently, a prompt that made
   the agent self-report prematurely).

## What this looks like in practice

- "Tests pass" → open the test runner's actual output, confirm the pass count and that nothing was skipped.
- "Added the feature" → diff the file, don't just read the agent's description of the diff.
- "Here's the number" → find the same number in the source it claims to be reading from.
- "Updated the tracker" → open the tracker, look at the item, confirm the state actually changed.

## Why this matters more than it looks

Verification is cheap per instance (seconds to minutes) and expensive to skip: a single unverified false claim,
recorded as done, compounds — downstream decisions get made on top of it, and by the time it surfaces the
context for catching it is gone. Treat every "done" as a hypothesis until an artifact confirms it, not a fact.
