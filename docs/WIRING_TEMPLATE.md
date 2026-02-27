# WIRING.md — [Your App Name]

> Generated from live runtime trace on [DATE].
> Re-generate after structural changes: `./scripts/capture.sh live`

---

## 1. Screen Inventory

### Pages / Activities

| Screen | File | Purpose |
|--------|------|---------|
| | | |

### Components / Fragments

| Component | Parent | Purpose |
|-----------|--------|---------|
| | | |

### Background Workers / Jobs

| Worker | Trigger | Purpose |
|--------|---------|---------|
| | | |

---

## 2. Navigation Flow

### Startup Sequence

```
App Launch
  ├─ [Init step 1]
  ├─ [Init step 2]
  └─ [Default screen]
```

### Screen Navigation Map

```
[Main Host]
  ├─ [Screen A]
  ├─ [Screen B]
  ├─ [Screen C]
  └─ [Settings] → [Sub-screen 1], [Sub-screen 2]
```

---

## 3. Data Queries Per Screen

| Screen | Query / API Call | Table/Endpoint | Typical Rows | Duration |
|--------|-----------------|----------------|-------------|----------|
| | | | | |

### HTTP / API Calls

| Endpoint | Method | Caller | Purpose |
|----------|--------|--------|---------|
| | | | |

---

## 4. Background Processes

```
[Trigger]
  └─ [Worker/Job]
      ├─ [Step 1]
      ├─ [Step 2]
      └─ [Result: success/failure]
```

---

## 5. Security Gates

```
Gate 1: [Name]
  ├─ Condition? → [Action if YES]
  └─ Otherwise → [Action if NO]
```

---

## 6. Settings / Configuration Map

| Setting Key | Where Checked | Effect |
|-------------|--------------|--------|
| | | |

---

## 7. Timing Profile

> From live trace captured on [DATE].

| Event | Duration |
|-------|----------|
| App startup total | ms |
| First screen render | ms |
| Largest query | ms |

---

## 8. Issues Found

| Issue | Severity | Status |
|-------|----------|--------|
| | | |
