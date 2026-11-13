# QUICKSTART (about 15 minutes)

You need: Claude Code installed, Python 3 (type `python3 --version` in a terminal; on Windows it may be `python`,
and if so change `python3` to `python` in `template/.claude/settings.json`), and one project folder you want help with.

## 1. Pick a folder to work in

Use one project folder, not your whole home folder. Claude will be able to *read* files in this folder freely, so do
not use a folder that holds passwords, bank exports or private documents. If you are unsure, make a fresh folder and
copy in only the files you want help with.

**Back it up first** (or put it in git), so that any change, yours or Claude's, can be undone.

## 2. Copy the safe setup in

Copy the `.claude` folder from `template/` into your project folder. Afterwards you should have:

```
your-project/
  .claude/
    settings.json
    safe/guard.py
    safe/guard_config.json
    skills/supervised-session/SKILL.md
```

If your project already had a `.claude/settings.json`, do not overwrite it blindly. Merge the two by hand, or ask
someone who knows Claude Code to help.

## 3. Check the install

```
python3 check_setup.py /path/to/your-project
```

Every line should say `OK`. If a line says `PROBLEM`, the line below it tells you what to fix.

## 4. Start Claude the safe way

```
cd /path/to/your-project
claude
```

Start it **without** extra flags: no `--dangerously-skip-permissions`, no `--permission-mode`. The settings refuse
those modes anyway, but do not get used to typing them. The first time, Claude Code asks whether you trust the
folder. Say yes only if this is the folder you chose in step 1.

For a first task, type `/supervised-session` followed by what you want, for example:
`/supervised-session summarise the open issues in notes/todo.md and propose a plan`.

## 5. How approving works

- Claude reads files without asking.
- For **every** edit, command, web lookup or helper agent, Claude Code shows you exactly what it wants to do and
  asks. Read the request before you press yes. "Yes, and don't ask again" is the one button to avoid: it
  pre-approves that kind of action for the rest of the session.
- Some things are **refused even if you say yes**: deleting in bulk, pushing code, sending data over the network,
  reading key or password files, scheduling jobs, installing software, running as administrator, changing its own
  safety setup. The guard matches patterns, so treat it as a guard rail, not a guarantee. The full list is
  in `WHAT-IT-WILL-AND-WONT-DO.md`. If you really want one of these done, do it yourself in a terminal.

## 6. How to stop it

- **Esc** stops what Claude is doing right now.
- **`./killswitch.sh on`** (from this folder) stops every Claude session (and helper agent) running in a project
  with Bright Lines installed, at the next step. Sessions in folders without Bright Lines are not affected.
  `./killswitch.sh off` turns it back off. Run it as yourself (not with `sudo`): the switch is a file in your own
  home folder, and only Claude sessions running as you see it.
- Closing the terminal ends the session.

## 7. Limits you might want to change

`.claude/safe/guard_config.json` holds the caps: 300 tool calls and 2 helper agents per session by default. Lower is
safer and cheaper. If you pay per use with an API key, also set a **monthly spend limit in your Anthropic Console
account**. That is the only hard cap in money terms; the caps here limit activity, not euros.

## Common first-week mistakes

- Pressing "yes" without reading. The approval prompt only protects you if you read it.
- Pointing Claude at a folder full of personal files "just to see what it can do".
- Asking Claude to change the guard settings. The guard refuses it by design; change them yourself, and only for a reason.
- Treating Claude's summary as proof. Check the file it says it made (see `verification-checklist.md`).
