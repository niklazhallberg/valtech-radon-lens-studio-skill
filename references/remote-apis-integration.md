# Remote APIs Integration (LS 5.20+)

How to fetch live external data (weather, places, AI text generation, etc.) into a lens via Snap's Remote Service Module. Covers the universal scripting pattern, performance budget, the four Snap-proxied APIs (AccuWeather / ChatGPT / Snap Places / Stock Market), and a **critical capability tradeoff**: using Remote APIs disables several other LS features for privacy.

Compiled 2026-05-20 from Snap's official Remote APIs documentation.

## CRITICAL: Remote APIs DISABLE other LS features for privacy

When a lens uses the Remote Service Module, Snap automatically disables several APIs to protect the user's privacy:

- **`UserContextSystem`** — `getBirthdate()`, `getLocation()` methods
- **`DeviceTracking`** — mesh and raycast operations
- **`MicrophoneAudioProvider`** — no mic access
- **`Voice ML Module`** — no voice analysis
- Others (see Snap's Restrictions section)

**Implication for the agent**: At Phase 0 brief intake, the agent MUST flag this tradeoff. **You cannot have both:**

- A lens that fetches live data (weather, AI text, places) **AND**
- A lens that uses mic audio, voice ML, world mesh / raycast, or user birthday/location data

**When this hits**: brand briefs like "voice-activated lens that also pulls live sports scores" or "audio-reactive lens with live weather" are **mutually-exclusive** within the same lens. Re-scope at intake — choose one capability bucket OR design as two separate lenses (one organic for the voice/mic experience, one with the Remote API).

## Contents

1. Universal Remote Service Module scripting pattern
2. Performance budget for API calls
3. AccuWeather API
4. ChatGPT API + Discover-disabled caveat
5. Snap Places API
6. Sponsored Lens fit
7. Common gotchas
8. Cross-references

## 1. Universal Remote Service Module pattern

All four Snap-provided Remote APIs use the same scripting surface:

```typescript
const req = RemoteApiRequest.create();
req.endpoint = 'ENDPOINT_NAME';
// optional: req.parameters = { ... };
script.remoteServiceModule.performApiRequest(req, function (response) {
  // handle response
  // response.statusCode, response.body, etc.
});
```

**Async pattern**: callback-based only — Snap does NOT use Promises or async/await for Remote Service Module. Wrap in a Promise yourself if you want async/await ergonomics.

**Install**: each API arrives as a Remote Service Module from Asset Library → APIs category. Search by name (`AccuWeather`, `ChatGPT`, `Snapchat Places`, `Stock Market`). See `asset-library-guide.md` → APIs category.

## 2. Performance budget for API calls

Snap's published guidance (mandatory to follow):

- **Maximum 3 simultaneous requests** — prefer 1
- **Response size ≤ 800 KB** — if larger, find a different endpoint
- **No dynamic image fetching via API** — use Remote Assets for images, NOT API responses
- **Anticipate high latency** — design loading states; show placeholder content while waiting
- **Use minimum number of calls** with endpoints that return the least amount of data

**Agent's coaching rule**: if a brief calls for "live updating data every few seconds", push back — that's not the model. Remote APIs are for one-time-on-load or sparse-refresh patterns, not real-time streaming.

## 3. AccuWeather API

### What it returns

- **Current Condition** — present weather (temperature, humidity, pressure, wind speed, condition)
- **Hourly Forecast** — 12 hours
- **Daily Forecast** — 5 days (day/night separated)
- **Combined** — all three + location/timezone data
- **Air quality** (via Plume Labs integration) — pollution indices + dominant pollutants

Response fields include `temperature_f`, `wind_speed`, `condition`, `relative_humidity_perc`, plus administrative-division metadata (locality, country code, postal data).

### Authentication

**Snap-proxied** — you do NOT need your own AccuWeather API key. *"You will be developing with the APIs of Snap's custom service which communicates with AccuWeather APIs."*

### Install + use

- Asset Library → APIs category → search `AccuWeather` → install
- Request body requires `{"lat": LATITUDE, "lng": LONGITUDE}` — depends on device location

### Gotchas

- Air-quality timezone data returns `null` if unavailable
- Humidity + pressure only populate in current conditions, NOT forecasts
- Camera Kit platforms have "limited compatibility"
- **Disables MicrophoneAudioProvider, Voice ML, UserContextSystem birthdate/location, DeviceTracking mesh/raycast in the same lens** (see Critical section at top)

### Use cases

- "Lens that shows current weather as a particle effect" (rain particles when raining, snow when snowing)
- "Today's high/low as branded countdown text"
- "Sunset-aware lens that changes ambient lighting based on local time"

## 4. ChatGPT API

### Capabilities

**Text generation only.** Send a text prompt, receive a text response. NOT supported:
- Multi-turn conversations
- Image generation or image input
- Open-ended questions
- Personal data solicitation
- Location queries
- Politics, religion, sexually-suggestive, or other moderated topics

### Script API

```typescript
const request = {
  temperature: 1,
  messages: [{ role: 'user', content: script.question }],
};
global.chatGpt.completions(request, (errorStatus, response) => {
  const mainAnswer = response.choices[0].message.content;
});
```

### Authentication

**Snap-proxied** — you do NOT need your own OpenAI API key. Requests route through Snap's infrastructure with built-in moderation (human + programmatic).

### Critical distribution caveat

> *"Lenses with the ChatGPT API will be disabled in Discover by default."*

That's a big deal. ChatGPT-using lenses don't get organic Discover distribution unless Snap explicitly enables them. For brand briefs that depend on Discover reach, ChatGPT API is the wrong tool.

### Install

Asset Library → ChatGPT Helper Demo or ChatGPT Helper Custom Component (via Add New Components menu).

### Gotchas

- Strict moderation — assume any prompt that touches sensitive topics will be rejected
- Geographic limit: only available in countries where OpenAI operates ChatGPT
- Latency not documented — anticipate >1s response time
- **Disables MicrophoneAudioProvider, Voice ML, etc.** (see Critical section)

### Use cases

- "AI-generated horoscope of the day" (with prompts that pass moderation)
- "Generate a fun caption for the user's lens activity"
- "Generate branded personalised greeting" (must not solicit personal data)

### Don't propose

- ChatGPT-driven voice assistants (conflicts with mic restriction + multi-turn ban)
- Open dialog lenses (multi-turn banned)
- Lenses with ChatGPT as primary feature where Discover reach matters (Discover-disabled)

## 5. Snap Places API

### What it returns

POI / venue data from the Snapchat Map:
- Place identifiers + localised names
- Rankings + descriptive subtitles
- Category info (ID + name)
- Opening hours, addresses, phone numbers
- Lat/lng coordinates
- Reportability status

### Three endpoints

- `get_nearby_places` — list nearby places given a location (auto-fills lat/lng from device)
- `get_places_profile` — metadata for multiple places simultaneously (includes operating hours)
- `get_place` — complete metadata for a single place (detailed query)

Typical chain: `get_nearby_places` first → then `get_places_profile` or `get_place` for selected entries.

### Install

Asset Library → APIs category → search `Snapchat Places` → install.

### Location dependency

Defaults to user's GPS coordinates. Accepts optional `gps_accuracy_m` parameter (default: 65m). Search radius = `min(100m, accuracy + 50m buffer)`.

### Gotchas

- GPS accuracy >3000m → API returns no results (the device thinks it's not localised)
- Multiple-place response order is NOT guaranteed
- Camera Kit platforms have "limited compatibility"
- Coverage scope (global / US-only / per-region) not specified in Snap docs — test by region
- **Disables MicrophoneAudioProvider, Voice ML, etc.** (see Critical section)

### Use cases

- "Lens that shows nearby restaurants as world-anchored 3D markers"
- "Location-aware brand activation" — e.g. "you're at [BrandStore], here's a special filter"
- "Travel lens that surfaces local POI as branded callouts"

## 6. Sponsored Lens fit

Snap's Remote APIs documentation does **not** explicitly address Sponsored Lens compatibility. **Working assumption**: Remote APIs work in Sponsored Lenses, but should be tested per-brief.

**Cross-rule with `sponsored-lens-submission.md`**:
- Lens Cloud features are **NOT** allowed in Sponsored Lenses (different mechanism — see that file)
- Bitmoji is **NOT** allowed in Sponsored Lenses
- Remote APIs — not explicitly blocked, but treat as "verify per brief" until a Valtech project ships with one

**Flag for the agent**: at Phase 0 of a Sponsored brief that proposes Remote API usage, document the assumption + confirm with Snap Ads contact before committing to Phase 1 build. ChatGPT API in particular has the Discover-disabled caveat which may interact with Sponsored distribution mechanics.

## 7. Common gotchas across the Remote API surface

- **Feature-disable side effect** (re-stated): voice ML, mic, world mesh, raycast, user birthdate/location all become unavailable when ANY Remote Service Module is in use
- **Callback-only async** — no Promises; wrap manually if you want async/await
- **Response size cap 800 KB** — if your data is bigger, the API design is wrong; find a smaller endpoint
- **Max 3 concurrent calls (1 preferred)** — over-parallelising will hit Snap-side throttling
- **Don't dynamically fetch images via API** — Snap provides Remote Assets for that purpose
- **Latency is real** — design loading states; show placeholder content while waiting
- **Camera Kit support limited** — flag at Phase 0 if brief targets Camera Kit distribution
- **No promises / Snap doesn't document SLAs** — for production Sponsored campaigns, build defensive timeouts + fallback content

## 8. Cross-references

- `sponsored-lens-submission.md` → Lens Cloud restriction (similar mechanism), Bitmoji restriction
- `audio-in-lenses.md` → mic + voice ML are disabled when Remote APIs are in use (CRITICAL tradeoff flag)
- `asset-library-guide.md` → APIs category install path
- `lens-recipe-catalog.md` → can compose Remote API-driven content into recipes (e.g. weather-driven particle ambience B-4)

## Use-case quick reference

| Brief intent | API to use | Caveats |
|---|---|---|
| Live weather displayed in lens | AccuWeather | Lat/lng required; disables mic + voice ML |
| Localised text response generated by AI | ChatGPT | Discover-disabled by default; strict moderation; no multi-turn |
| Nearby venues / POI markers | Snap Places | Lat/lng required; GPS accuracy gotcha; coverage by region |
| Live stock / financial data | Stock Market / Alpaca (separate page — not researched yet) | Snap-proxied; verify per use case |
| Real-time chat / voice assistant | NOT POSSIBLE in same lens as Remote APIs | Mic + voice ML disabled |
| Live image fetching | NOT via Remote API — use Remote Assets | Snap explicitly forbids API-based image fetch |

## Adding new findings

When a Valtech project surfaces a Remote API behaviour not in this file:

1. **API + endpoint**
2. **Pattern / fact** — one sentence
3. **Capability-disable interaction** — did using the API block another feature unexpectedly?
4. **Source** — Snap docs URL or empirical record
5. **Confidence** — official-docs / multi-source / single-source / valtech-validated
