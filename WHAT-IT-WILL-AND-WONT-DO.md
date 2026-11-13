# What this will and won't do

## It WILL, without asking
- Read and search files inside your project folder (not outside it).
- Think, plan and write answers in the chat.

## It WILL, after you approve each one
- Create or edit files in your project folder.
- Run ordinary commands (run your tests, run a script, `git status`, `git commit` to your *local* repository).
- Look things up on the web. Whatever comes back is treated as information, never as instructions.
- Start a helper agent, at most **2 per session** by default.
- Propose new tasks or sub-projects. It writes them down as proposals; you decide.

## It WON'T, even if you say yes (the guard refuses)
The guard recognises these by pattern. It is a guard rail, not a guarantee; see "It CAN'T promise" below.
- Delete in bulk (`rm -r`, `rm -f`, `find -delete`) or throw away work in git (`reset --hard`, `clean -f`, ...).
- Push code, publish or deploy packages, use the GitHub/GitLab command-line tools, or send email.
- Use the network from the command line (`curl`, `wget`, `ssh`, `scp`, `rsync`, ...). This also stops it from
  quietly sending your files somewhere.
- Read or change secret files: `.env`, SSH keys, cloud credentials, `.pem`/`.key` files, password stores, shell history.
- Print environment variables (they often hold API keys).
- Run as administrator (`sudo`), schedule jobs (crontab, services), or start anything that keeps running after the
  session ends (`nohup`, `tmux`, background `&`).
- Install software (`pip install`, `npm install`, `brew install`, ...). You install what you need yourself.
- Change its own settings, its guard, its counters, the kill switch, or the skills, agents and hooks under `.claude/`,
  with file tools or with shell commands that name them.
- Run commands in the background, or very long commands (over 8,000 characters) that it could not check quickly.
- Use connectors such as email, calendar or payment tools unless you add them by name to `guard_config.json`.
- Run in auto mode, accept-edits mode or skip-permissions mode.
- Keep going after the session cap (300 tool calls by default) or after the kill switch is on.
- Run obvious order or payment commands (`place_order`, `transfer_funds`, `send_payment`, ...). No money tools are
  shipped and connectors are off unless you list them. A money script or tool under another name is not recognised.

## It CAN'T promise
- **That every dangerous command is caught.** The guard matches patterns. A determined or confused agent can write
  something harmful that no pattern recognises, for example a Python script that deletes files. That is why every
  command still needs your approval, and why the backup in QUICKSTART step 1 matters. The README's "Known gaps"
  lists what a pattern guard cannot see: scripts, names built in several steps, archives, your own shell aliases.
- **That a "yes" is safe.** If you approve an edit that breaks your project, it is broken. Undo it with your backup or git.
- **That web content is harmless.** It is labelled as data, and the agent is told to ignore instructions inside it,
  but a cleverly written page can still mislead the agent's *reasoning*. Read what it proposes after browsing.
- **A cap in euros.** The caps limit activity. For a money cap, set a spend limit in your Anthropic account.
- **Correct work.** It will sometimes be wrong and sound sure. Check results against the actual files.
