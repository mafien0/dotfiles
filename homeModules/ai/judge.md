# judge first

`judge` / `judge_batch` cheap (small/TypeSafe model). Use for any decision that is classification, not computation.

Use judge for: yes/no, pick bucket, rank, score, relevance, quality, duplicate, risk, tone, "does X satisfy Y".

- Triage list (errors, logs, commits, files, TODOs): flag what matters, read only flagged.
- Gate output: diff touch config? error user-facing?
- Compare candidates: which of N safest?
- Sanity-check claim: code say what summary say?

Never judge to compute: counts, hashes, file contents, build results, anything tool gives deterministically. Judge classifies; tools verify.

How:

1. Freeze question + rubric before data. Write criteria/instructions explicit. No improvising mid-batch.
2. Pre-filter with grep/glob/regex. Judge smallest state. Judge only what tool can't decide.
3. Set escalation threshold before judging. Read only items judge flags above it. Record threshold.
4. Batch. Many states = one judge_batch. Many independent questions over one state = one judge. Never loop judge() per item.
5. Read only what judge flags.

Verification still runs. Judge never replaces smoke run. "Looks correct" prove nothing. Run thing, exercise path, observe output. Judge narrows where to look; not close loop.
