# 0.1.2 — 15 October 2026

- Added explicit Exact phrase, Any word / OR, All words / AND, All phrases, Any phrase and NEAR controls, plus exclusions.
- Added operator explanations on hover and keyboard focus, a parsed-query preview and highlighted matches.
- Corrected the lower-ratings view and exports so keyword-excluded documents do not appear as shortlist matches.
- Identified the current judicial document from its standalone heading, preserving rectification notes and quoted procedural history.
- Added direct language/format-catalogue item retrieval, 404-to-XHTML negotiation, ordinary EUR-Lex text fallback and bounded transport retry.
- Separated catalogue-confirmed unlisted language/format versions from retrieval or validation errors.
- Added automatic local re-extraction of older cached sources, preserving original bytes and settings.
- Added a ten-scenario offline keyword acceptance check in the UI and Windows launcher.

# Changes

## 0.1.1 — 15 October 2026

This release addresses the English-document retrieval failures reported after the first Windows trial. CELLAR resource addresses are handled through HTTPS, alternative document locations are preserved, and an optional EUR-Lex fallback is enabled by default. Discovery groups repeated addresses and continues from the last document identifier and date.

Settings includes a one-document download check. Saved searches can be retried from their results, and detailed request records make remaining failures easier to diagnose. Existing archives, saved searches, model settings and completed classifications are retained.

Interface headings, help, progress messages, documentation and Word-list wording have been refreshed. The footer coverage sentence was removed. The new version number appears in the header.

The test suite now has 98 passing checks. The verification record describes their scope and the live checks needed after installation.
