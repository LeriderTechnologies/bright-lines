# Boundary rules

Many agent setups let most work run on its own and stop only at a few bright lines. This setup flips the default: **ASK is the starting level**, and the bright lines are refused
outright rather than asked about.

## Levels
- **DO**: just do it. Only reading, searching and thinking are here.
- **ASK**: show the exact action and wait for a yes. Edits, commands, web lookups, helper agents.
- **REFUSE**: not done even with a yes; the agent prepares it so the human can do it themselves.

## REFUSE (enforced by the guard's patterns, not just by instructions; a guard rail, not a guarantee)
1. **Money**: orders, payments, transfers. The guard catches obvious command words and unlisted connectors; anything
   subtler relies on your approval.
2. **Credentials and accounts**: reading or changing keys, passwords, tokens, `.env` files, SSH/cloud credentials,
   logins, 2FA, account settings.
3. **Outward-facing**: pushing code, publishing, sending email or messages, posting, applying, signing up,
   command-line network access, connectors that act in the user's name.
4. **Purchases**: anything that spends money, however small.
5. **Unattended or persistent work**: scheduling (cron, services), background processes, auto/bypass modes.
6. **Destruction**: bulk delete, discarding git work, disk tools, administrator rights.
7. **Self-loosening**: editing its own settings, guard, rules or playbook.
8. **Installing software**: package installs (supply-chain risk). The human installs.

## ASK
Everything that changes something: file edits, commands, web lookups, helper agents, local git commits, proposing
new tasks.

## DO
Reading and searching inside the project folder; planning; drafting text in the chat.

## Changing these rules
Only the human changes this file and `guard_config.json`. Add rules from real experience ("this burned me once"),
not from guesswork, and date each change. Moving something from REFUSE to ASK should be rare and deliberate.
