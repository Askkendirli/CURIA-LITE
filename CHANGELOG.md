# 0.1.4 — 15 October 2026

- Replaces the rejected unbounded catalogue query with a bounded direct-link query and runs the independent RDF-tree route even after SPARQL errors. Keeps response excerpts for troubleshooting.
- Handles nested RDF resources, avoids duplicate catalogue requests, and checks CURIA case addresses including appeal variants. Available source files remain identity- and language-checked.
- Applies the same actor/action/outcome/condition rubric to every contextual question, with an editable actor choice, structured support fields, examples for negation and party requests, and a new eight-example local-model check.
- Retains original scores when evidence checks adjust an answer; clarifies that specific agreement between language versions supports comparison. Correcting one version from context alone is kept separate.
- Prioritises substantive context passages over procedural-language footnotes without changing full-text keyword matching.
- Rewrites operator help with quoted search examples and adds Example: placeholders. Existing matching semantics remain unchanged.
- Adds an identifier selection for the 34 outstanding English documents from the submitted run, for focused local testing.

# 0.1.3 — 15 October 2026

- Reconcile metadata-only language entries with a separately requested official RDF publication tree; follow equivalent WEMI identifiers.
- Cache scoped publication-file observations with an expiry and explicit refresh, while retaining unlisted requested texts in coverage details.
- Add embedded-text PDF retrieval/import and optional CURIA fallback. Preserve raw PDF bytes and existing language/identity checks.
- Retry interrupted HTTP body transfers within a bounded allowance.
- Recognise explicit current-court comparison intent in a general context query and preview it in the interface.
- Check cited passage attribution, preserving original model answers when a party/general-principle/referring-court finding requires a lower displayed grade.
- Prioritise literal-match passages, retain every supplied model-input passage and restore keyword audit information on semantic results.
- Clean incidental words from rapporteur names and recognise General Court party headings during local re-extraction.
- Preserve keyword operators and runtime model settings; refresh prompt-version-dependent classification caches.

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
