# CodeWiringKit - Show AI your Mental Model
You may find this useful.
I created this because I was frustrated with AI's inability to see my code the way I do in my mind. figured that if I could get it to see what happens in runtime, then I open the key or all pages in my app and do something , then it can 
see the data flow and next time I ask it to debug something it knows the connections.
So I tried it out and it seems to work, pretty well actually. In one of my android projects I have a page that is used for 3 different purposes, simply by hiding some feature and exposing others. each go through a different pipeline and all this is determined
by server settings that update on each sync.  After doing this wiring , Claude was able to now know that any changes to that page had to consider all the 3 scenarios and it stopped blindly changing code for just one path.

so basically all this is in Alpha or Pre alpha (hehe). Claude will do the wiring logs and then you run your app and open all the pages and do something within them. then you copy paste the logs and give them to Claude and it then creates 
a wiring diagram. Thereafter I include a summarized version of this in the my startup sequence so that claude is aware. for gritty bugs I tell it to read the wiring.md file then I go ahead and do the bug fixes

I'm hoping someone can extend all this to work for other platforms. web etc





**See your app's runtime wiring — then hand it to AI.**

CodeWiringKit is a lightweight methodology for instrumenting any app (Android, web, backend) with structured debug-only traces, capturing a live walkthrough, and producing a **WIRING.md** document that maps every screen → query → API call → security gate in your codebase.

## Why?

AI coding assistants (Claude, ChatGPT, Copilot) are great at reading static code. But static code can't tell you:

- Which database query fires when a user opens the Settings page
- That your SMS log screen loads 9,000 rows **three times** due to overlapping observers
- The exact startup sequence: Application → Splash → PIN check → MainActivity → default fragment
- Which screens re-query when the app returns from background

**Runtime traces answer these questions in minutes.** Feed the resulting WIRING.md to your AI assistant, and it instantly understands how your app actually behaves — not just how it's written.

## What You Get

After a single walkthrough of your app:

1. **WIRING.md** — A structured document mapping screens, queries, API calls, workers, and security gates
2. **Trace logs** — Timestamped evidence of every lifecycle event, DB read, HTTP call
3. **Performance data** — Actual query durations and row counts per screen
4. **Bug discoveries** — Duplicate queries, missing data loads, unnecessary work

## Quick Start

👉 **[Getting Started Guide](docs/GETTING_STARTED.md)** — Full step-by-step instructions

### The 30-Second Version

1. Add a tracer (singleton with structured log methods)
2. Wire it into lifecycle hooks, DB calls, HTTP calls
3. Run your app while capturing logs
4. Read the traces → produce WIRING.md

## Platform Support

| Platform | Tracer | Capture |
|----------|--------|---------|
| **Android/Kotlin** | Logcat with `Log.d("WIRING", ...)` | `adb logcat -s WIRING:V` |
| **Web/JS** | `console.debug("[WIRING]", ...)` | Browser DevTools console filter |
| **Node.js** | `console.debug("[WIRING]", ...)` | `node app.js 2>&1 \| grep WIRING` |
| **iOS/Swift** | `os_log(.debug, "[WIRING] ...")` | Xcode console filter |
| **Python** | `logging.debug("[WIRING] ...")` | `python app.py 2>&1 \| grep WIRING` |

## Trace Format

All platforms use the same structured format:

```
timestamp|EVENT_CODE|subject|details
```

Example output:
```
12:23:22.159|INIT|Application.onCreate.start
12:23:22.661|INIT|DatabaseRoutines|dur=500ms
12:23:25.771|FRAG_RESUME|RecentsFragment|host=MainActivity
12:23:26.313|DB_READ|transactionstable|rows=216 dur=520ms
12:24:58.479|HTTP|GET /api/tariffs|code=200 dur=1432ms
12:25:38.352|DB_READ|MpesaTrans.count|rows=8997 dur=0ms
```

## Event Codes

| Code | What It Captures |
|------|-----------------|
| `INIT` | App/module initialization steps with duration |
| `ACT_CREATE` | Activity/page created (FRESH or RELAUNCH) |
| `ACT_RESUME` | Activity/page became visible |
| `ACT_PAUSE` | Activity/page went to background |
| `FRAG_RESUME` | Fragment/component became visible |
| `FRAG_PAUSE` | Fragment/component hidden |
| `DB_READ` | Database query: table, row count, duration |
| `DB_WRITE` | Database insert/update/delete |
| `HTTP` | Network call: method, endpoint, status, duration |
| `WORKER` | Background job: name, state (START/SUCCESS/FAIL) |
| `SEC_GATE` | Security checkpoint: gate name, result (PASS/FAIL) |
| `SETTING` | Config/preference read at a decision point |
| `BRANCH` | Routing decision: which path was taken |

## Real-World Results

From the MpesaJournal Android app (first use of CodeWiringKit):

| Finding | Impact |
|---------|--------|
| SMS log screen queried 9,000 rows **3x** on load | Fixed: StateFlow observers lacked `isFirst` guards |
| Type and Time screens double-queried on entry | Fixed: `loadData()` called in both `onCreate()` and `onResume()` |
| Person screen query was invisible to traces | Fixed: missing instrumentation on `getTransacteeSummaries()` |
| Background resume re-queried all ViewModels | Identified as architecture-level issue for future fix |

## Repository Structure

```
CodeWiringKit/
├── README.md                    # This file
├── docs/
│   ├── GETTING_STARTED.md       # Step-by-step guide for any platform
│   ├── PLAYBOOK.md              # The AI-assisted wiring playbook
│   └── WIRING_TEMPLATE.md       # Blank WIRING.md template to fill in
├── examples/
│   ├── android/
│   │   └── AppLifecycleTracer.kt   # Drop-in Android tracer
│   └── web/
│       └── wiring-tracer.js        # Drop-in web/Node.js tracer
├── scripts/
│   └── capture.sh                  # ADB capture script (Android)
└── LICENSE
```

## License

MIT — use it however you want.

---

*Created from real instrumentation work on the MpesaJournal Android app. If this saves you debugging time, that's the whole point.*
