# CURIA-LITE
 CURIA LITE searches official sources and your local archive. Enter a date range and any case criteria, choose document languages, and search with keywords or a brief research context. Results are grouped by case and can be exported to Word, CSV or JSON.

For quick start, Please download and extract the provided .zip file to a suitable environment first. A similar README file for setting up and using the tool is also available in it. I will be updating the provided .zip package (along with the rest of the files) of the tool as I come up with new iterations to the tool
 
## First installation

Install **64-bit Python 3.11, 3.12 or 3.13** and **Ollama for Windows**. Extract the repository to a short local folder such as `C:\Tools\CURIA-Lite`, then double-click `Setup_Windows.cmd`.

Download the initial local model in PowerShell:

```powershell
ollama pull ministral-3:8b
```

Double-click `Start_Windows.cmd`. The interface opens at `http://127.0.0.1:8765`. Keep its console open during use. Another port can be selected with `Start_Windows.cmd --port 8766`.

The code uses a separate virtual environment and a persistent data folder. PowerShell activation is unnecessary. Setup does not change BIOS settings, GPU allocation or the existing full-tool archive.

## A first search

Choose the required **Document versions**, decision dates, courts and document types. Additional filters can be left blank. Select a keyword operator, enter words or a brief context, then choose **Find cases**. The source mode determines whether missing documents are retrieved or only the existing archive is searched.

For a small real check, use the known judgment identifier `62024CJ0313`, French or English, and its decision date 12 February 2026. The identifier is a starting point for source access, not a bundled result. For a completely offline check, select **Load synthetic demo** and run the suggested literal search.

## Keywords and operators

The help menu explains each option when its item is hovered or reached with the keyboard. A preview below the input shows the actual interpreted expressions.

| Operator | Example input | Matching condition |
|---|---|---|
| Exact phrase | `language version` | The complete phrase "language version", with words together in that order. |
| Any word · OR | `language version` | "language" or "version", including documents containing both. |
| All words · AND | `language version` | Both "language" and "version" anywhere in the same document. |
| Any phrase | `language version; legal certainty` | The complete phrase "language version", the complete phrase "legal certainty", or both. |
| All phrases | `language version; legal certainty` | Both complete phrases; they may appear in different paragraphs. |
| Nearby words · NEAR | `language version` | The two terms within the selected number of intervening words in a paragraph, in either order. |

Semicolons separate phrase entries. In word-based searches, double quotation marks keep an expression together: `"language version" customs` searches for that complete phrase and/or "customs", according to the selected operator.

Exact matching ignores capitalisation and line wrapping and respects whole-word boundaries. The singular phrase "language version" does not match "language versions". For both forms choose **Any phrase** and enter:

```text
language version; language versions
```

With **Any word · OR**, those same entries become the individual words "language", "version" and "versions". In English judgments, the footer "Language of the case" can therefore make a document a valid literal candidate. The contextual model then assesses whether the substantive research question is supported. No operator has been silently changed to suppress these candidates.

The **Exclude** field removes documents containing an excluded word or phrase. Full-text keyword checks cover the extracted source. A nonempty context adds a relevance assessment after these literal conditions. Clear the keywords when the context alone should select relevant documents.

See `docs/KEYWORD_OPERATORS.md` for worked examples.

## Contextual questions

Every context is supplied in full to the local model. Each assessment checks the requested subject, action or relationship, responsible actor, outcome, negation and stated conditions. This applies to questions about sanctions, aid recovery, proportionality, annulment, language interpretation and other topics.

Examples:

```text
Cases where the court refused recovery of aid
Cases where applicants requested annulment of a decision
Opinions proposing prospective application only
Judgments comparing the English and French wording
```

**Whose action should the evidence show?** defaults to Automatic. A specific actor can be selected when needed: the deciding court, a referring court, a party, the Advocate General, a public authority, the legislature, or a court in an earlier cited case. **Any relevant participant** suits broader subject-matter research.

The model returns the requested actor, the actor supported by the evidence, and the strength of that support, together with its score, category, cited passages and short reason. The application checks explicit actor contradictions and score/support inconsistencies. A party requesting annulment can strongly support a question about requests; it does not establish that the court actually annulled the decision. The same distinction applies to other requested actions and outcomes.

For language-comparison questions, a specific comparison finding agreement is relevant even when no discrepancy exists. A general instruction to compare versions, an earlier-case quotation and a correction to one version from its context require different evidence. The dedicated language-comparison preset remains available as a convenient starting point.

These are prompt, evidence-selection and validation improvements. Model weights are unchanged. Actual model quality should be checked with the evidence and the built-in contextual test; no universal accuracy guarantee is implied.

## Fast and complete-text screening

**Fast** scans the extracted source locally and supplies selected passages to the model. Substantive passages matching the question are prioritised; the procedural-language footer no longer takes priority unless procedural language is the topic. The source and full-text keyword results remain unchanged.

**Complete text** processes all extracted blocks in bounded requests and takes longer. Neither mode hides unavailable source versions. Every supplied passage is saved in JSON and can be expanded in the interface, including the input for low-rated documents.

## When an assessment needs a second reading

The default **Take a second look when the evidence and rating need clarification** setting schedules one additional request for a flagged Fast assessment. Examples include a Low rating beside a concrete grammatical comparison, or conflicting attribution across neighbouring passages. The second reading includes the relevant observation and nearby reasoning within the existing request budget. It may raise, lower or retain the initial grade.

The first answer and the review answer remain in JSON. The interface shows that an additional review occurred, and both requests are cached. A failed review leaves the first assessment available and records the outstanding issue. Changing this setting does not alter the installed model weights. The saved passages and review triggers can be inspected before interpreting a result as relevant.

## Relevance levels

| Grade | Use |
|---|---|
| Very low · 1 | The supplied evidence does not establish the requested event or contradicts it. |
| Low · 2 | Incidental mention or background, or evidence concerning a different required actor. |
| Medium · 3 | Part of the requested relationship is supported; important conditions remain unclear. |
| High · 4 | Direct evidence for the requested actor and relationship. |
| Very high · 5 | Detailed direct evidence. |

Literal-only grades describe match strength. Contextual grades prioritise research reading. They are ordinal labels and should be checked against the passages. An incomplete model request remains unassessed. If a validation check adjusts a score, the original model answer and the reason for the adjustment remain in the record.

Case groups preserve the component judgments, Opinions and language versions. A group's grade is its highest document grade. The display threshold controls what is shown; JSON retains all assessments. Selecting Very low + displays all graded candidates, including those that do not establish contextual relevance.

## Understanding the counters

Each status count has its own explanation on mouse hover, keyboard focus or click. Press Escape to close the popup. The definitions are available in English, French and German, and the exported Word list contains a **Collection and screening guide**.

| Counter | Meaning |
|---|---|
| Already saved | Requested document-language versions reused from the checked local archive. |
| Downloaded | Requested versions retrieved and accepted during this run. |
| Needs attention | Retrieval or source validation remains incomplete. Open the associated error details to see the next step. |
| Unlisted | The checked publication records list no full-text file that this tool can read for the requested language version. The available file languages and check time are shown under Publication details. That version was left out of the analysis. |
| Still to check | Versions awaiting a download or a publication-availability check. |
| Publication checks reused | Recent saved availability checks reused for this run. |
| Additional reviews | Documents receiving the targeted second reading described above. |

Collection counts refer to **document-language versions**. Several such versions can belong to one case. An unlisted version has no relevance grade because its requested text was not analysed; it remains part of the collection’s documented gaps. The shortlist contains assessed source texts.

New runs also produce **collection_status.csv**, a compact table of counts and definitions, and a `status_guide` inside `results.json`. Historical run exports remain unchanged. A new run is required to obtain the updated Word/CSV guide.

## Retrieval and language availability

**Discovery:** CELLAR metadata identifies documents by decision date and judicial publication type. **Content:** the configured provider is CELLAR by default, with EUR-Lex, CURIA and embedded-text PDF recovery options available in Settings. Provider and source addresses are retained with each file.

The collector accepts the media type advertised for each official file, including PDF/A variants, and prefers HTML or XHTML before a PDF when both are available. The document reader handles joined-case headings, attached language prefixes and the General Court’s short preliminary-ruling heading. An inconclusive catalogue triggers the independent RDF publication-tree lookup; standard literal and collection nodes are supported. Nested resources and equivalent identifiers are followed locally. An advertised file is validated against the requested language, legal identity, type and available date information before indexing.

A complete English title or English case summary does not imply that an English full judgment is published. The Court's policy states that some judgments are available only in the language of the case and the drafting language, usually French. The application keeps a requested English gap visible and lists the languages with actual file links. It never relabels a French document as English or replaces a full judgment with a short notice.

A publication check is cacheable only when the source records support its stated scope; unsuccessful notices and failed advertised files remain visible as retrieval issues. Recent successful availability checks are reused for the configured period. **Retry this search** refreshes a run with unresolved versions or download failures.

To focus the next test on the outstanding documents, choose **Use a CELEX selection JSON** and load `examples/remaining_12_documents.json`. Keep the decision-date range 1 January 2025 to 1 January 2026 and choose the required document languages. These are the official identifiers from the submitted failure set. Their current availability still requires a fresh online check.

For wider case coverage, French can be selected as an additional document language. It is analysed directly and remains labelled French. An English-only literal phrase can still exclude French source text; use a suitable context or language-appropriate keywords.

Official source-language policy: https://curia.europa.eu/site/jcms/d2_5170/en/site-language-policy
CELLAR metadata notices: https://op.europa.eu/en/web/cellar/cellar-data/metadata/metadata-notices

## Model and performance controls

Defaults are unchanged: `ministral-3:8b`, 8192 context tokens, 256 output tokens, up to 5600 evidence bytes and four Fast passages, one model worker, temperature 0 and 30-minute model retention. Settings can select another compatible local model and the languages it supports. Seven source languages are enabled initially: French, English, German, Spanish, Italian, Portuguese and Dutch.

Lite performs a narrower task on the same hardware. Literal-only searches make no model requests. A contextual candidate normally needs one small classification, and repeated identical questions reuse valid cached decisions. Changes to the source, query, model digest or prompt version invalidate the relevant assessment cache. No reports or translations are generated.

The loopback Ollama address is required. No model weights are downloaded automatically and no research context is sent to a cloud inference service. Source discovery and downloading still need internet access. The interface itself runs locally.

## Built-in checks

**Test keyword matching** runs ten artificial cases through the archive and search pipeline, with no model or network requests. The result is saved to `diagnostics/keyword-check.json`. It can also be started with `Test_Keywords_Windows.cmd`.

**Test contextual screening (12 examples)** makes twelve short English-language requests to the selected local model. The examples check judicial action versus party requests, broad-topic relevance, negation, AG reasoning, and agreement between language versions. This optional test uses artificial passages, leaves the judicial archive unchanged, and saves inputs, raw answers and expected ranges to `diagnostics/context-check.json`. It can also be started with `Test_Context_Windows.cmd`. A transport or invalid-response error stops the check promptly.

**Settings → Test a document download** checks a single real source before a longer collection. Model inventory checks only availability; a small contextual run is needed to test loading and generation.

## Existing documents and output

Existing Lite installations reuse `%LOCALAPPDATA%\CURIA-Lite`. A custom home is selected before the command:

```powershell
.\.venv\Scripts\python.exe -m curia_lite --home D:\Research\CuriaData serve
```

For sources from the full tool, import the raw HTML or embedded-text PDF files. The full tool's database and virtual environment are separate. Scanned/textless PDFs remain for manual follow-up. Imported metadata must be inspected and cannot override conflicting source identity.

Each run saves `request.json`, `results.json`, `shortlist.csv` and `shortlist.docx` under `runs/<run-id>/`. Source diagnostics are stored under `downloads/`; the latest checks are under `diagnostics/`. Files can contain research questions and source passages, so review them before public sharing.

## Troubleshooting

If setup fails, keep the visible error and confirm a supported 64-bit Python installation. If Ollama is unavailable, open it and check `ollama list`. A cloud-labelled model is rejected. If an HTTP page is blocked, the Settings browser option supports permitted interactive verification after installing the optional Playwright browser dependency. Access controls are not bypassed.

A source 404, metadata error and unlisted publication version describe different conditions. The export and download trace distinguish them. Repeated blind requests to an unlisted English version do not improve coverage; the availability panel identifies actual file languages. Advertised files that cannot be read remain retryable issues.

For a contextual result that looks wrong, inspect the cited and all supplied passages, actor choice, support field, original score and any adjustment. Include `results.json` and the contextual-check record when reporting it. These make the next diagnosis more specific.

## GitHub publication

Upload the repository folder containing this README. The archive includes source, tests, examples, documentation, Windows launchers and CI. It excludes the personal workspace, private result JSON, model weights and academic documents.

```powershell
git init
git add .
git commit -m "Add CURIA LITE 0.1.5"
git branch -M main
git remote add origin https://github.com/ACCOUNT/curia-lite.git
git push -u origin main
```

Replace `ACCOUNT` with the actual account. A remote repository has not been created or pushed by this package. The included Windows/Ubuntu CI matrix runs after push; its presence is not a completed native platform test.

Verify the downloaded snapshot with `python scripts/verify_integrity.py`. After intentional reviewed changes, regenerate it with `python scripts/verify_integrity.py --write`.

## Validation and limits

See `audit/VERIFICATION.md` for executed tests and `audit/RUN_REVIEW.md` for the latest submitted result review. The development environment has no usable local model service or source-site DNS access. Live recovery and native Windows execution therefore remain target-machine checks. The supplied synthetic and replay tests must not be presented as new real-model accuracy measurements.

MIT licence for the software. Official sources and model weights have their own terms. This is an independent research application.

## Preparing a larger date-range run

Run the keyword check and the contextual check before expanding the period. Previously accepted source files are reused, and compatible assessments are cached. A changed reader re-extracts saved bytes locally; it does not force the same document to be downloaded again.

Collection and model work are submitted through bounded queues. Source text is opened as a model worker becomes available, rather than loading every candidate text at once. The recent-search menu reads small run summaries, and publication details are paged. These changes limit pending work and interface load as the collection grows. They do not remove the time required to retrieve genuinely missing documents.

The submitted yearly search contained 927 requested English versions: 700 accepted, 215 unlisted and 12 unresolved retrievals. Use `examples/remaining_12_documents.json` for a focused retrieval check before the next large collection. Successful availability checks can be reused for the configured period; Retry this search performs the documented fresh checks.

The recorded development audit for this release is in `audit/VERIFICATION.md`; actual source and model checks on the target Windows machine remain necessary.
