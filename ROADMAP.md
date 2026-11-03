# Raccoon AI Roadmap

## Milestone 1 — Visual and app foundation
- [x] Flutter app entry point and assistant screen
- [x] Custom geometric raccoon mascot illustration
- [x] Explicit unconfigured-model state (no simulated AI responses)
- [x] Android APK build workflow
- [ ] Run and verify the first Android build on a Pixel 8a
- [ ] Refine mascot animation and accessibility

## Milestone 2 — Local assistant
- [ ] Select and benchmark practical on-device models
- [ ] Integrate a local inference runtime
- [ ] Persist conversations locally
- [ ] Add offline speech-to-text and text-to-speech
- [ ] Connect mascot states to real assistant activity

## Milestone 3 — Android integration
- [ ] Investigate Android assistant-role support
- [ ] Add an invocation shortcut where Android permits it
- [ ] Add an optional overlay with explicit user permission
- [ ] Handle background execution within Android platform limits

## Milestone 4 — Agent capabilities
- [ ] Permission-aware tool architecture
- [ ] Screen understanding and accessibility integration
- [ ] Visible execution status and cancellation
- [ ] Confirmations for destructive or external actions
- [ ] Verification and transparent reporting

## Milestone 5 — Desktop and creator integrations
- [ ] Windows and macOS application adapters
- [ ] Desktop mascot and computer interaction
- [ ] Native OBS plugin, after the core assistant is stable

## Engineering guardrails
- Never label a placeholder as a working AI feature.
- Keep private conversations, audio, and transcripts local by default.
- Treat model and web output as untrusted input.
- Do not execute consequential actions without permission and appropriate confirmation.
- Verify model licenses, runtime support, device memory, speed, heat, and battery use before recommending a model.
