---
name: elevenlabs-tts-tags
description: "Write expressive ElevenLabs TTS scripts with inline audio tags. Use when directing emotion, delivery, pacing, reactions, accents, character voices, or sound effects; composing multi-beat performances; or troubleshooting spoken or ineffective tags."
---

# ElevenLabs audio tags

Audio tags are natural-language performance directions in **single square brackets**, supported by Eleven v4, v4 Turbo, and v3. They are an open vocabulary, not a fixed command list.

## Direct the performance

- Put a cue immediately **before the words it affects**, including mid-sentence. Delivery carries forward; add another cue where it should change rather than repeating it on every sentence.
- Aim for **one coherent direction per clause**. Combine compatible qualities inside one tag: `[whispering, fearful]`. Conflicting instructions on the same words blur the performance.
- Use punctuation alongside tags: ellipses for hesitation, dashes for interruptions, capitals for emphasis. Tags direct pacing; they are not exact-duration timing controls.
- Keep enough surrounding text to establish the scene and emotional progression. Add cues at meaningful changes, not mechanically before every phrase.
- Start with a simple cue, then specify what is missing: `[nervous]` → `[nervous, trying to sound confident]`. You can describe manner, situation, character, or a transition: `[out of breath after running upstairs]`, `[starting calm, then losing patience]`.
- Listen and adjust: try a neighboring emotion before rewriting the dialogue. Results vary with voice and context. If tags are spoken aloud, check model support and square-bracket syntax first.

## Cue palette

Examples to adapt—not an exhaustive list:

| Purpose | Tags |
|---|---|
| Emotion | `[excited]`, `[proud]`, `[playful]`, `[mad]`, `[bitter]`, `[anxious]`, `[scared]`, `[confused]`, `[tired]`, `[bored]`, `[let down]`, `[peaceful]`, `[curious]`, `[thoughtful]` |
| Delivery / volume | `[whispers]`, `[shouts]`, `[softly]`, `[quietly]`, `[barely audible]`, `[booming]`, `[low, threatening]` |
| Pacing | `[slowly]`, `[rushed]`, `[pause]`, `[long pause]`, `[drawn out]` |
| Human reactions | `[laughs]`, `[sighs]`, `[gasps]`, `[clears throat]`, `[crying]` |
| Accent / character | `[British accent]`, `[French accent]`, `[Australian accent]`, `[pirate voice]` |
| Sound events | `[thunder rumbling]`, `[footsteps]`, `[door creaking]`, `[clapping]` |

Reactions and sound events can introduce audible non-speech sounds. Accent and character cues steer the selected voice rather than guaranteeing an entirely different speaker.

## Examples

Simple direction and layering:

```text
[thoughtful] There may be a simpler explanation.
[whispering, playful] I hid the last biscuit somewhere very safe.
```

Mid-sentence changes:

```text
[confident] The repair will take five minutes—[hesitant] unless that was an important screw. [sighs] Let me get the manual.
```

A changing emotional arc:

```text
[curious] There's a light under the door. [whispers] I thought everyone had left. [door creaking] [startled] Who's there? [long pause] [laughs] Oh, it's you. [softly] You could have called first.
```

Pacing, escalation, and comic timing:

```text
[slowly] One small step... and we're across. [rushed] Not that step, the other step! [gasps] [long pause] [drawn out] Well... [trying to sound reassuring] At least the water looks shallow.
```

Natural-language performance and character shifts:

```text
[weary station announcer] The next train is delayed. [starting calm, then losing patience] By five minutes. Ten minutes. Apparently, forever. [brightly, as though nothing happened] Thank you for your patience.
[British accent] Shall we take the ferry instead? [pirate voice] Now you're talking, captain. [laughs] I'll bring the map.
```

Source: [ElevenLabs audio tags list](https://elevenlabs.io/blog/elevenlabs-audio-tags-list), updated October 15, 2026. Scripts above are original examples.
