# Audio in Lenses (LS 5.20+)

API surface, licensing flow, asset pipeline, and gotchas for audio in Lens Studio 5.x — from background music and SFX to voice modulation, audio-reactive visuals, and Snap Music Library integration. Closes a previously-blind spot: ~50% of brand briefs include audio, but our skill had no curated reference for audio APIs before this file.

Compiled 2026-05-20 from Snap's official audio documentation. `[STALE]` markers indicate source URL is older than 24 months but the underlying behaviour is unchanged in current LS 5.x.

## Contents

1. Audio API surface — what we can do at all
2. Voice modulation / voice ML
3. Audio-reactive visuals (amplitude / FFT / time-based)
4. Snap Music Library licensing flow
5. Audio asset pipeline / format gotchas
6. Common gotchas + pitfalls
7. Sponsored Lens audio rules
8. Cross-references

## Cross-references

- **Audio recipes**: `references/lens-recipe-catalog.md` D-4 Soundboard, D-5 Music-Reactive (Beat Sync)
- **Sponsored Lens audio licensing rules**: `references/sponsored-lens-submission.md` → "Music must be original, licensed, or from Snap's library"
- **Performance budget impact**: audio counts toward 8 MB total lens-size limit and ≤4 MB Sponsored target — see `SKILL.md` Performance budget

---

## 1. Audio API surface

### `AudioComponent` — the universal audio player

Plays an `AudioTrackAsset`. Controls loop, volume, `Mix to Snap`, scriptable start/stop.

```typescript
@input audioTrack: AudioTrackAsset;
const audio = script.getSceneObject().getComponent("Component.AudioComponent");
audio.audioTrack = script.audioTrack;
audio.play(-1); // -1 = loop infinitely; positive int = play N times
```

Nearly every audio-using lens (music, SFX, ambience, licensed tracks) routes through `AudioComponent`.

**Source**: https://developers.snap.com/lens-studio/features/audio/playing-audio + https://developers.snap.com/lens-studio/api/lens-scripting/classes/Built-In.AudioComponent

---

### `AudioTrackAsset` — the audio resource, with 4 provider types

The asset that an `AudioComponent` plays. The provider type determines what you can do with it:

| Provider | Created via | Use for | Can be analysed? |
|---|---|---|---|
| `FileAudioTrackProvider` | Drag MP3/WAV into Asset Browser | Custom audio (jingle, VO, SFX) | **Yes — only this provider guarantees raw-data readability** |
| `FileLicensedSoundProvider` | Asset Library → Music section | Snap Music Library tracks | Yes, via Audio Analyzer |
| `MicrophoneAudioProvider` | `+ → Audio → Audio From Microphone` | Mic-driven analysis, voice-reactive | Yes |
| Audio Output | `+ → Audio Output` | Analyse the global mixed audio | Yes |

**Why this matters**: If a brief calls for FFT or amplitude-driven visuals, the agent must know that **only `Audio From File` guarantees raw-data access**. Licensed Music can still be analysed (via Audio Analyzer's preset support) but with restrictions.

**Source**: https://developers.snap.com/lens-studio/features/audio/audio-track-assets

---

### `Audio From File` — for custom audio with raw-data analysis

Drag-and-drop an MP3 (preferred) or WAV into Asset Browser → becomes a `FileAudioTrackProvider` AudioTrackAsset.

**Important**: Snap mixes stereo to mono before raw analysis. Don't design visualisation patterns that rely on left/right channel separation.

---

### `Licensed Music` — for Snap-licensed tracks

Add via Asset Library → Music. Listen in Asset Library before importing. Imported track behaves like any other AudioTrackAsset (same `AudioComponent` + Behavior `Play Sound` pattern) — only the provider metadata flags it as licensed internally.

**Brand brief routing**: "use this track from the Snap catalogue" → Licensed Music. "use our own master jingle" → Audio From File.

---

### `Audio From Microphone` — live mic as an AudioTrackAsset

`+ → Audio → Audio From Microphone` creates a `MicrophoneAudioProvider` AudioTrackAsset. Everything voice-modulation, keyword-detection, or mic-reactive starts here.

**Critical**: In LS Preview, the user must explicitly click the **mic icon in the Preview panel** to grant mic access. Without that, mic-driven analysis returns no data and produces no error.

---

### `Audio Output` — analyse the global mix

A separate AudioComponent bound to an `Audio Output` asset with Autoplay Loop. Lets you analyse "everything that's playing" instead of binding to each individual AudioComponent.

Use for: audio-reactive UI that should respond to the lens's full mix, including music + SFX + ambience simultaneously.

---

### `AudioEffectComponent` — voice effects (post-record only)

Applies voice presets (robot, pitch up, pitch down, cute animal, etc.) to the **microphone input in the recorded Snap**. Does **NOT** affect Lens Studio Preview's live audio monitor.

Critical limits:
- **Only one Audio Effect can be active per lens.** Multiple AudioEffectComponents in scene → only one effect applies.
- **Effect is global on the mic track.** Cannot apply different effects to different parts of the mix (no "robot voice on the character but clean music").
- Effect heard only when the user records a Snap and plays it back. Preview panel does not show the effect.

**Source**: https://developers.snap.com/lens-studio/features/audio/audio-effect

---

### `AudioListenerComponent` — spatial audio

Acts as the "microphone position" for spatial audio mixing. Any `AudioComponent` with Spatial Audio flagged blends based on distance + direction from the listener.

Required for world-ambience and games where sound should fall off with distance. Without it, all audio is 2D-mixed regardless of Spatial Audio flag.

**Source**: https://developers.snap.com/lens-studio/api/lens-scripting/classes/Built-In.AudioListenerComponent

---

### `Audio Analyzer` — official FFT / amplitude module

Pre-built script + UI asset from Asset Library. Takes an AudioTrackAsset (File / Licensed / Microphone / Audio Component), splits into frequency-band amplitudes, exposes them as script inputs you can drive Behaviors or materials from.

**This is the agent's first-pass answer for any "react to audio" brief** — don't propose custom DSP. Audio Analyzer is what Snap officially supports.

Input Type modes:
- `Audio From File`
- `Licensed Music`
- `Microphone Audio`
- `Audio From Audio Component`

**Source**: https://developers.snap.com/lens-studio/features/audio/audio-templates/audio-analyzer

---

### `Beat Sync` — pre-analysed beat events for music-reactive lenses

Uses Sound Sync API with pre-computed beat timestamps. Fires events like `OnBeat`, `OnDownBeat` for any AudioTrackAsset that has beat data (predominantly Licensed Music tracks).

For "react on beat, not just loudness" briefs (pulsing UI, beat-driven colour shifts), Beat Sync is the standard answer — more stable than amplitude peaks for longer sessions.

See `lens-recipe-catalog.md` D-5 for full build approach.

**Source**: https://developers.snap.com/lens-studio/features/audio/beat-sync

---

### Audio templates — Music Video, Soundboard, Keyword Detection

Pre-built patterns the agent can map to instead of designing from scratch:

| Template | Pattern | Use case |
|---|---|---|
| **Music Video** | Timestamp-based callbacks against an audio track (via `AudioAttachedSequence`) | Lyric videos, chaptered effects, intro/verse/chorus state changes |
| **Soundboard** | UI buttons that play SFX + show pop-up visuals (see recipe D-4) | Branded SFX panels, joke-button lenses |
| **Keyword Detection** | ML detects specific spoken words/phrases from mic | "React when user says X" — branded catchphrase triggers |

**Sources**: https://developers.snap.com/lens-studio/features/audio/audio-templates/music-video, /soundboard, /keyword-detection

---

## 2. Voice modulation / voice ML

### `AudioEffectComponent` covers voice presets only

Snap ships built-in voice presets (pitch up "cute animal", pitch down, robot, etc.). Each preset has limited per-preset parameters — no exposed custom DSP curves.

**Brief expectation-setting**: voice modulation is **preset-based**, not full custom sound design. Sell that framing during Phase 0 so colleagues don't promise things the SDK can't do.

---

### Only one Audio Effect per lens

Multiple presets cannot be stacked (no "pitch + robot + echo"). The agent must pick the best single effect or design around this limit.

---

### Keyword Detection for "react when user says X"

LS Keyword Detection template uses ML on mic audio to find specific words/phrases and trigger effects. **Not** a general ASR / transcription API — Snap does not expose arbitrary speech-to-text.

Briefs with "lens reacts when user says BrandName" → Keyword Detection. Briefs asking for free-text recognition → push back, this isn't possible in LS.

---

### No published voice ML latency numbers

Snap doesn't publish ms-latency numbers for voice ML on mobile in public docs (only for Spectacles, which is out of scope). Treat latency as "test on device" rather than estimating.

---

## 3. Audio-reactive visuals (amplitude / FFT / time-based)

### Default to Audio Analyzer

For nearly every "react to audio" brief, Audio Analyzer is the official, supported pipeline. Build amplitude/band-driven materials, particles, and Behaviors from its exposed properties — not from custom polling.

---

### Choose Input Type by brief

- **Music sync** → Licensed Music
- **Voice-reactive** → Microphone
- **Global mix sync** → Audio Output or Audio From Audio Component

---

### Mic permission gotcha

For Microphone Audio analysis, the developer must:
1. Create an `Audio From Microphone` asset
2. Click the **mic icon in the Preview panel** to grant mic access

Without step 2, Audio Analyzer returns no data — no error, no log message. Common reason for "the audio-reactive demo isn't working" during local testing. The agent should proactively coach mic-permission step.

---

### Sample-rate must match

Audio Analyzer's `sample-rate` setting must match the track's actual sample-rate (e.g., 44100 Hz for Licensed Music). Mismatch causes drift / off-timing in the analysis output.

For briefs that want tight sync between visualiser and music, the agent should explicitly verify the sample-rate field during Phase 2 scripting.

---

### Music Video pattern for time-based callbacks

`AudioAttachedSequence` helper script (in Music Video template) schedules callbacks at specific timestamps in an audio track. Triggers Behaviors, text swaps, material changes.

For lyric videos / "chaptered beat" briefs, `AudioAttachedSequence` is more robust than reading live amplitude.

---

### Beat Sync for beat-driven (not loudness-driven) responses

Beat Sync uses pre-computed beat metadata to emit events directly to shaders, tweens, or Behaviors — no script-side FFT needed. Stable across long sessions. Standard for dance/party lenses.

---

### Don't poll AudioTrackAsset in `onUpdate()`

Anti-pattern: rolling your own sampling of audio data per frame. Snap recommends driving visuals from Audio Analyzer's exposed properties instead — the analyzer is frame-synchronous and designed for this. Custom polling is heavier and prone to drift.

---

## 4. Snap Music Library licensing flow

### How to add Licensed Music

Asset Library → Music section. Preview tracks in-Library before importing. Imported track becomes an AudioTrackAsset with `FileLicensedSoundProvider`, usable in any AudioComponent or Behavior `Play Sound` exactly like a file-imported track.

---

### Same code, different provider

The same scripting pattern works for both custom files and Licensed Music — agent doesn't need to generate different code, just guide colleague to pick the right asset type.

---

### Licensed Music is implicitly OK within Snapchat

Snap signals that Licensed Music is approved for use as background music in lenses on Snapchat. The commercial scope (Sponsored vs organic) is governed by Snap's Music license terms, not the developer docs.

**Agent's framing**: "Licensed Music follows Snap's in-platform licence. For Sponsored Lens commercial scope, confirm against Snap Ads Manager policy documentation separately." See `sponsored-lens-submission.md` → "Music must be original, licensed, or from Snap's library".

---

### External licensed music = separate clearance

If the brand wants a specific commercial track not in Snap's library (e.g., a Top-40 hit), that requires separate licensing handled outside Lens Studio. Agent should flag this at Phase 0 — it's a project-blocking dependency, not a Phase-4 last-minute add.

---

## 5. Audio asset pipeline / format gotchas

### Use MP3 for VO and SFX — not WAV

MP3 is Snap's recommended format ("best for optimization purposes"). Uncompressed WAV bloats lens size significantly. For Sponsored Lenses with strict <4 MB target, always recommend MP3.

---

### Drag-and-drop import for custom audio

Drag MP3 (or WAV if necessary) into Asset Browser → becomes `Audio From File`. Bind to AudioComponent or Behavior. Standard pipeline for VO/jingles when the brand has own masters.

---

### Raw data analysis requires 1-channel audio

Audio Analyzer / raw-data reading only supports 1-channel (mono). Stereo tracks are mixed to mono before analysis.

**Brief implication**: Don't promise "left ear has effect A, right ear has effect B" patterns — that's outside the SDK's analysis surface.

---

### Sample-rate matching for analysers

If using Audio Analyzer, set `sample-rate` field to match the track's actual rate. Licensed Music is typically 44100 Hz. Mismatch = drift in visualiser sync.

---

## 6. Common gotchas + pitfalls

### `Mix to Snap` can mute the microphone in the recorded Snap

Any `AudioComponent` with **Mix to Snap = true** writes its audio into the final recorded Snap. If the colleague has both background music (Mix to Snap on) and expects the user's mic voice in the recording, the music can mask or replace the mic audio depending on mix levels.

**Agent's coaching**: When a brief combines VO from mic + background music, walk through Mix to Snap flag with the colleague before Phase 2 scripting — easy to silently break with default settings.

---

### Audio Effects only hear-able after recording a Snap

The `AudioEffectComponent` (voice effect) applies in post-record. Live Preview shows no audible change — colleague must send lens to device and record + play back a Snap to hear the effect.

Common QA confusion: "the voice effect isn't working". Agent's response: "test by recording a Snap on device, not just live Preview".

---

### Microphone-based Audio Analyzer needs Preview mic-permission

For mic-driven analysers: click the **mic icon in the Preview panel** to grant LS access. Without it, no data, no error.

Agent should always include this step when proposing mic-reactive features.

---

### Drive visuals from analyzer outputs, not from custom `onUpdate` polling

Audio Analyzer is designed for frame-sync visual driving. Custom polling of AudioTrackAsset in `onUpdate()` is heavier and drift-prone. Hang visuals on the analyzer's exposed properties via Behavior or script binding.

---

### Beat Sync stays in sync over long sessions (Audio Analyzer can drift)

For 30–60+ second experiences, Beat Sync uses pre-analysed timestamps → no drift over time. Amplitude-peak detection through Audio Analyzer can accumulate drift on long tracks. Prefer Beat Sync for music-video and dance briefs.

---

### Multiple AudioComponents mix freely; AudioListener handles spatial only

No published soft-limit on number of simultaneous AudioComponents. Music + UI stings + ambience can all play in parallel. Only `AudioListenerComponent`-driven spatial blending uses 3D position; everything else mixes as 2D.

Agent can safely propose separate sources for `music + UI stings + ambience` without worrying about hard mix limits — but flag total audio levels for the colleague to balance.

---

### Audio Effects are global on the mic track

Cannot apply different effects to different parts of the mix (e.g. "robot voice on the character but clean music"). The effect processes the mic audio after recording.

Brief expectation-setting: voice effects apply to the user's voice in the recording, not to individual audio sources in the lens.

---

### No audio API deprecations in LS 5.x release notes

As of LS 5.20+, no audio classes are explicitly deprecated. AudioComponent + Behavior/Script pattern is first-class and stable. Watch for new features (Beat Sync, Keyword Detection) rather than migrations.

---

## 7. Sponsored Lens audio rules

### Licensed Music is in-scope; external music needs separate licensing

Snap's optimisation and Sponsored Lens docs treat Licensed Music via Asset Library as implicitly approved for use within Snapchat. External tracks (own files of a commercial song) require separate licensing handled outside LS.

See `sponsored-lens-submission.md` → "Music must be original, licensed, or from Snap's library" for the canonical rule.

---

### Audio assets count toward the 8 MB total lens-size budget

For Sponsored Lenses, audio (Licensed Music + own files) is part of the same lens-size budget as visuals. Snap recommends:
- Optimise MP3
- Keep loops short
- Reuse audio where possible
- Avoid large WAV files

**Anti-pattern**: 20-second full-quality WAV intro on a Sponsored Lens. Agent should translate that to a shorter, compressed jingle in the spec — otherwise the lens may breach the <4 MB Sponsored target and underperform in distribution.

---

## Adding new findings

When a Valtech project surfaces audio behaviour not in this file:

1. **Pattern** — one sentence
2. **Where it bit** — project name, what colleagues expected vs what happened
3. **Mitigation** — concrete fix
4. **Source** — Snap docs URL or empirical record
5. **Confidence** — official-docs / multi-source / single-source / valtech-validated

Audio gotchas in particular are easy to miss during desktop preview — flag any new finding that only surfaces during device QA so future projects catch it in Phase 4 DoD.
