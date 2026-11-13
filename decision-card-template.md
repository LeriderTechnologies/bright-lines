# Decision-card template

The format for anything an agent has prepared but can't finish itself — because it crossed one of the boundary
rules' bright lines (see `boundary-rules.md`: money, credentials, outward-facing, a purchase). The point: by the time a human sees this,
there is exactly one thing left for them to do, and it's obvious what that is.

## Format

```
**Ask:** <the one exact question or action you need from them — a single sentence, no hedging>

**Reply:** <the reply options, as short as possible — e.g. "approve" / "reject" / "A or B" / a number>

---

<background: why this came up, the comparison or research behind it, the numbers that matter, links or paths to
anything they'd want to check, and exactly what happens next once they answer>
```

## Rules for filling it in

- **The Ask line never gets buried in the background.** If someone reads only the first line, they should know
  exactly what's being asked. Put the background after the `---`, not before it.
- **Do the comparison before asking, not after.** If there are options, lay out the tradeoff in the background so
  the reply really is one word or one click, not the start of a research conversation.
- **State the cost.** If the decision involves spending money, say the exact number — not "a small fee."
- **State what you'll do with each answer.** "If approved, I'll do X. If rejected, I'll do Y instead" (or "mark it
  closed") — so a yes/no actually resolves it.
- **One ask per card.** Two decisions bundled into one card means the easy one blocks on the hard one. Split them.
- **Don't block on it.** Park the card, mark whatever work depends on it as waiting, and go do something else.
  Nothing else in the run should stall because one card is open.

## Worked example

```
**Ask:** OK to subscribe to the data vendor's $49/mo plan so the reporting pipeline gets hourly data instead of daily?

**Reply:** yes / no / "revisit next quarter"

---

Current plan (free tier) gives end-of-day data only, which means the dashboard is always a day stale. The $49/mo
tier adds hourly data — a test run on the vendor's sample feed (see `sample_hourly.log`) shows stock-out alerts
would fire about 18 hours sooner on average, which matters for the time-sensitive cases (roughly a third of
alerts in the sample). No annual commitment, cancel anytime. If approved, you put the new API key in
the config yourself (credentials are a bright line) and I switch the pipeline's data source on the next run. If declined, I'll leave it on the free tier and this doesn't block anything else.
```
