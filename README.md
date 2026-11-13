# Bright Lines

**A supervised, fail-closed safety setup for Claude Code.** Copy one folder into your project and Claude reads
freely, asks before every edit, command, web lookup or helper agent, and refuses a short list of truly dangerous
actions outright, even if someone clicks "yes" by mistake: deleting in bulk, pushing or publishing, sending data
over the network, reading keys and password files, scheduling background work, installing software, obvious money
actions, and loosening its own rules (through file edits or the shell). The guard matches patterns, so it is a guard
rail, not a guarantee: you still read every request before you approve it. A kill switch stops every session in a
project with Bright Lines installed, per-session caps keep cost in check, and a setup checker proves the guard really
blocks things before you rely on it. It is built for people who want an AI agent's help on real work without
handing it the keys: no dependencies (Python 3 standard library), one hook, plain-language docs.

## Start here

1. [`QUICKSTART.md`](QUICKSTART.md): install in about 15 minutes, in plain language.
2. [`WHAT-IT-WILL-AND-WONT-DO.md`](WHAT-IT-WILL-AND-WONT-DO.md): read this before you trust it with anything.
3. [`THREAT-MODEL.md`](THREAT-MODEL.md): what can go wrong, what stops it, and what is still on you.

Try it in two minutes from a fresh clone:

```
python3 -m unittest discover -s tests        # 28 tests: 177 blocked commands, 50 allowed ones, secrets, caps, kill switch
mkdir -p /tmp/demo-project && cp -r template/.claude /tmp/demo-project/
python3 check_setup.py /tmp/demo-project      # every line should say OK
```

## How it works

Four layers, each catching what the one before it misses:

1. **Settings** (Claude Code permissions): reading is pre-approved; edits, commands, web and agents ask; the
   auto / accept-edits / skip-permissions modes are switched off.
2. **Guard hook** (`.claude/safe/guard.py`, runs before every tool call, including helper agents' calls): refuses
   the bright-line actions even after a "yes". It **fails closed**: bad input or an internal error means "no",
   and the hook command turns a crashed guard or a missing Python into a "no" as well.
3. **Human approval**: the last line, and the one that catches what patterns miss.
4. **Backups / git**: recovery when all three are wrong.

After every web fetch the guard also reminds the model that the fetched content is data, not instructions, which
blunts prompt injection from web pages.

## What's in the repo

| File | What it is |
|---|---|
| `template/.claude/settings.json` | The tight permission settings: reading is free, everything else asks you, the risky modes are switched off, the guard is wired in |
| `template/.claude/safe/guard.py` | The guard hook: kill switch, mode check, session caps, blocked commands, secret files, connector allow-list |
| `template/.claude/safe/guard_config.json` | The few numbers you may want to change (caps, extra blocked patterns, allowed connectors) |
| `template/.claude/skills/supervised-session/SKILL.md` | A `/supervised-session` skill: plan, do each step with approval, verify against real files, summarise |
| `killswitch.sh` | `./killswitch.sh on` stops every Claude session (and helper agent) running in a project with Bright Lines installed |
| `check_setup.py` | Checks your install and proves the guard really blocks things |
| `boundary-rules.md` | The rule list: DO / ASK / REFUSE, with ASK as the default |
| `brief-template.md`, `decision-card-template.md`, `verification-checklist.md` | Templates for briefing a helper agent, handing a decision back to a human, and checking an agent's claims against real files |
| `tests/test_guard.py` | Automated tests for the guard, kill switch and setup checker |
| `BREAKIT-2026-10-31.txt` | The pre-release attack log: every bypass attempt, the result before and after the fixes, and what cannot be fixed in a hook |

## What it deliberately does not do

- Run unattended, in the background, or on a schedule.
- Let the agent create its own projects or tasks (it may only *propose* them), or edit its own settings and rules.
- Promise to catch every dangerous command. The guard matches patterns; harm written as a script can slip past.
  That is why every command still needs your approval and why backups matter. See `WHAT-IT-WILL-AND-WONT-DO.md`.
- Cap spending in euros or dollars. The caps limit activity; set a spend limit in your Anthropic account for that.

## Known gaps (found by trying to break it)

Before release we attacked the guard with about 300 crafted commands and tool calls (quoting tricks, `bash -c`,
`$VAR` command names, wildcards, symlinks, `find -exec`, here-docs, git aliases, huge inputs, parallel calls, a broken
install). Everything we found that a hook can reasonably catch is now refused and has a regression test. What a
pattern-matching hook **cannot** catch, and what you must watch for when you approve a command:

- **Programs and scripts that do the harm for it.** `python3 cleanup.py`, `npm run x`, `make`, a shell script it wrote a
  step earlier: the guard sees the file name, not what the file does. Read scripts before you approve running them.
- **Names and paths built in several steps.** A path or program name assembled from variables, or a copy of a blocked
  program under a new name (`cp "$(which curl)" c`, then `./c`), is not recognised.
- **Archives and patches.** `tar x`, `unzip` or `git apply` can write into `.claude/` without naming it.
- **Your own shell aliases and functions.** Claude Code's shell can load them; an alias such as `gp` for `git push` is
  not known to the guard.
- **Indirect reads of secrets inside the project.** `grep -r KEY .`, an archive of the whole folder, or a search over
  everything can include a secret file's lines. Keep secrets out of the project folder.
- **Data in web lookups.** An approved web fetch or search sends its address or query out; very long addresses are
  refused, short ones are not. Read the address before you approve.
- **A guard that runs too long.** If the hook ever takes longer than its 10-second timeout, Claude Code goes ahead.
  The guard refuses commands over 8,000 characters so its checks stay well under a second.
- **Windows.** The PowerShell tool is refused outright; the hook command assumes a POSIX shell (Git Bash).

## Requirements

Claude Code and Python 3.8+. Tested on Linux with Claude Code 2.1.280 and 2.1.322 (see `THREAT-MODEL.md` for what was verified
end-to-end and what was not). On Windows, `python3` in `settings.json` may need to be `python`.

## Licence

MIT, see [`LICENSE`](LICENSE). Not affiliated with or endorsed by Anthropic. "Claude" and "Claude Code" are
Anthropic's names for their products.
