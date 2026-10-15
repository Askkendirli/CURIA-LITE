# CURIA-LITE
 CURIA LITE searches official sources and your local archive. Enter a date range and any case criteria, choose document languages, and search with keywords or a brief research context. Results are grouped by case and can be exported to Word, CSV or JSON.

For quick start, Please download and extract the provided .zip file to a suitable environment first. A similar README file for setting up and using the tool is also available in it. I will be updating the provided .zip package (along with the rest of the files) of the tool as I come up with new iterations to the tool
 
## Windows setup
Install 64-bit **Python 3.12** and the Python launcher, then install and start **Ollama**. Python 3.11 and 3.13 are also supported by the setup scripts.

Extract this repository into a short local folder, for example `C:\Tools\CURIA-Lite`. Double-click **`Setup_Windows.cmd`** to create the application environment and install its dependencies. Double-click **`Start_Windows.cmd`** to open the interface. Keep the console window open while working.

For contextual searches, install the default model in PowerShell:

```powershell
ollama pull ministral-3:8b
```

Keyword searches can be used before the model is installed. Internet access is needed for initial installation and collecting new sources. Once saved, the documents can be searched locally.

The default data folder is:

```text
%LOCALAPPDATA%\CURIA-Lite
```

A different persistent local folder can be selected at startup:

```powershell
.\.venv\Scripts\python.exe -m curia_lite --home "D:\Research\CURIA-Lite-Data" serve
```

The same arguments can be passed to `Start_Windows.cmd`. Each installation creates its own virtual environment; keep the data folder separate from that environment.

## Try a small search

### Explore the interface

Choose **Load synthetic demo**, then **Find cases**. This loads four fictional examples and selects a French keyword search. Two French cases should appear. Open their supporting passages and try the Word export.

### Check phrase and word matching

Select **Test keyword matching** below the search controls, or double-click **`Test_Keywords_Windows.cmd`**. Ten checks cover the English phrase, English separate words, French negative examples, quoted expressions, exclusions and NEAR. The check uses a temporary archive and makes zero source-site or model calls. Its result is saved in `diagnostics/keyword-check.json`.

### Check document access

In Settings, choose **Test a document download**. The check requests the selected language of C‑313/24 and displays the resulting source address or an error. It saves a detailed record under `diagnostics/source-check.json`.

For a small real search, import `examples/known_cases.json` through **Use a CELEX selection JSON**. This contains a few official identifiers. The application retrieves their selected language versions before screening them.

### Check the model

In Settings, first select **Check storage + model inventory**, then **Test one real model request**. After a successful test, use the comparison option or enter a brief context. Review the displayed evidence to judge whether the classifications suit the research question.

## Search controls

### Case criteria

Dates refer to decisions, Opinions or orders. Choose courts and document types, then add any identifiers, names or further metadata filters. Leaving a filter blank includes all values.

Some advanced fields need supplementary information from an inspected source. Documents missing a required detail appear under **Needs metadata**. [Language and field support](docs/LANGUAGES_AND_FIELDS.md) explains which details are extracted automatically and how to provide the rest.

### Document versions and query language

Choose the language versions to collect and read in **Document versions**. The default model profile enables French, English, German, Spanish, Italian, Portuguese and Dutch. The **Query language** controls the language of the research context and brief model explanations.

The **Language of the case** filter refers to procedural metadata and is set under Additional filters. For example, the French version of a judgment may concern a case conducted in Italian.

The interface's core labels are available in English, French and German. More detailed technical messages remain in English.

### Local sources and downloading

**Local first + retrieve missing** checks the catalogue for the selected period, reuses validated files, and downloads missing language versions. **Check for new documents** refreshes the catalogue search. **Local archive only** searches the current local collection.

Existing catalogue details are reused within the configured cache period. The date of that check and any retrieval problems are saved with the run. First-time collection over several years can take considerable time, especially with several language versions selected.

### Keywords and context

Select how the words should match from the operator menu. Hover over an option to read its explanation. The same help appears when an option receives keyboard focus, and a preview below the input shows how the entered text is interpreted.

For the input `language version`:

| Operator | A matching document contains |
|---|---|
| **Exact phrase** (default) | `language version`, together and in that order |
| **Any word · OR** | `language`, `version`, or both |
| **All words · AND** | Both `language` and `version` anywhere in the same document |
| **All phrases** | Every complete expression entered, separated with `;` |
| **Any phrase** | At least one complete expression entered, separated with `;` |
| **Nearby words · NEAR** | Two words or quoted expressions within a chosen number of intervening words, in either order, in the same paragraph |

Choose **Exact phrase** to search for a complete expression. For example, `language version` matches that complete phrase and excludes `language … version` and `language versions`. To include the singular and plural, choose **Any phrase** and enter `language version; language versions`.

In the word and NEAR modes, double quotes keep an expression together: `"language version" customs` with OR finds the quoted phrase or the word `customs`.

**Exclude words or phrases** removes documents containing any listed expression. Separate exclusions with `;`, for example `customs; import duties`. This exclusion filter is applied before contextual screening too.

Matching ignores capitalisation, repeated whitespace and line wrapping, while preserving accents and word boundaries. Exact phrases stay within a paragraph and retain punctuation. Keyword-only searches compare the supplied wording directly with the selected source text. Thus an English phrase absent from a French text yields no match. A word such as `version`, shared by French and English, can occur naturally in both; an English phrase explicitly quoted in French text also remains searchable.

Select the operator in the menu; enter the words or expressions in the text field. The search does not use inline Boolean formulas. [Keyword operators](docs/KEYWORD_OPERATORS.md) includes the full rules and examples.

A context of up to **30 words**, or the comparison option, adds a short model assessment. When both are supplied, the keyword and exclusion conditions are applied first. For a broad conceptual question, leave the keyword field blank.

### Finding comparisons of language versions

Choose **Court compared language versions**. Judgments are the clearest starting point; orders can be added. Leave keywords blank for a broad search.

The classifier looks for a comparison applied by the deciding court. General multilingual principles, party arguments, an Advocate General's own comparison and quotations of earlier judgments are recorded separately. A comparison that finds the versions agree can also be relevant.

**Fast** reviews selected passages in a short request. **Complete text** sends every extracted block in bounded packets and takes longer. Both modes retain evidence locations for inspection.

## Reading the results

Five relevance levels help prioritise the reading:

| Level | Contextual interpretation |
|---|---|
| Very low | No supporting passage identified in the supplied material |
| Low | An incidental or background connection |
| Medium | A plausible connection that needs closer review |
| High | Clear, direct supporting evidence |
| Very high | Detailed, explicit supporting evidence |

Keyword-only ratings describe phrase coverage and frequency. Contextual ratings reflect the model's reading of the supplied passages. Review those passages before relying on a classification.

Each case group retains its document types, dates, languages and identifiers. Its headline rating is the highest document rating in the group. Open the individual documents to see any differences or pending assessments.

Word and CSV use the search's saved rating threshold. JSON includes every assessment, download details and missing metadata. **Include lower ratings and pending assessments** shows more matched cases and pending reviews. Documents excluded by the keyword condition remain outside the shortlist and are counted in the search summary. Their details are preserved in JSON. Files and assessments that could not be completed remain available for retry.

## Document sources

The default source is the Publications Office's **CELLAR** service. Catalogue entries are grouped by CELEX identifier and decision date. Alternative CELLAR addresses are retained, and recognised older resource addresses are requested through HTTPS.

For a discovered document, the downloader first checks the published language/format catalogue and tries the requested HTML or XHTML file directly. It can then try CELEX/work addresses with format negotiation, the documented language query, and EUR-Lex text pages. A known rectification note or reference to an Opinion in a judgment no longer changes its detected document type. **Try EUR-Lex when a CELLAR file is unavailable** is enabled by default and can be changed in Settings. The selected and resolved URLs are saved, so the origin of each document can be inspected.

**EUR-Lex HTML** and **CURIA document pages** can also be selected as the preferred source. Source language, document identity and known dates are checked before a file enters the archive. Where a successful catalogue lookup lists other languages or formats but omits the requested version, that availability information is displayed separately. A bare 404, failed catalogue lookup or rejected source remains an error to investigate.

Optional browser assistance is installed with:

```powershell
py -3.12 scripts\bootstrap.py --browser
```

Enable it in Settings for pages that need interaction. A verification page can be completed manually when the provider permits it. A saved official HTML file can also be imported directly. See [Source access](docs/SOURCES.md) for the supported routes.

## Model and performance settings

The default model is `ministral-3:8b`. A different compatible local model, including `ministral-3:14b`, can be selected in Settings.

| Setting | Default |
|---|---:|
| Context | 8,192 tokens |
| Output limit | 256 tokens |
| Fast-mode source budget | 5,600 UTF-8 bytes, adjusted to fit the request |
| Selected passages | Up to 4 |
| Model workers | 1 |
| Keep model loaded | 30 minutes |
| Download workers | 2 |
| Request spacing | 0.8 seconds |
| Catalogue cache | 24 hours |

The list-focused workflow reduces repeated generation, downloading and model loading. Actual speed depends on the collection size, model, backend and workstation. Start with one model worker and increase it only after observing stable operation.

The language list should match the model's capabilities. Source recognition currently covers the default seven languages and some additional headings. Settings checks that both the model-language declaration and document reader can support the chosen codes.

## Reuse documents from the full research tool

Import its original HTML files into the Lite archive:

```powershell
.\.venv\Scripts\python.exe -m curia_lite import "C:\Path\To\OldProject\archive\raw"
```

The importer reads UTF-8 HTML/XHTML and checks document language and identity. A `document.html.metadata.json` sidecar can supply verified supplementary information. Source conflicts are reported for review. Scanned documents require a separate text-extraction workflow before import.

An exact case selection can be supplied through `examples/selection_with_metadata.json`. Keep the Lite database and environment separate from the full tool.

## Updating an existing installation

Close the running console, extract this release into a new source folder, run **Setup_Windows.cmd**, and then **Start_Windows.cmd**. The version shown at the top should be **0.1.2**. The existing `%LOCALAPPDATA%\CURIA-Lite` workspace is reused; a custom workspace still uses the same `--home` argument.

Saved source bytes and model settings are retained. Previously parsed source text is refreshed locally when needed by the new document reader. Begin a new search and choose **Exact phrase** for the phrase test. Retried older searches retain their saved combinations, displayed as **All phrases** or **Any phrase**. The fresh search reuses already saved documents.

## Command-line use

```powershell
.\.venv\Scripts\python.exe -m curia_lite test-keywords
.\.venv\Scripts\python.exe -m curia_lite doctor --sources --source-language en --out source-check.json
.\.venv\Scripts\python.exe -m curia_lite doctor --models
.\.venv\Scripts\python.exe -m curia_lite doctor --smoke --out model-check.json
.\.venv\Scripts\python.exe -m curia_lite search examples\keyword_query.json
.\.venv\Scripts\python.exe -m curia_lite search examples\comparison_query.json --selection examples\known_cases.json
```

Settings are stored in `settings.json` inside the data folder. The GUI covers common options; **Advanced settings** accepts other validated values. A command-line search returns a nonzero exit code when work is incomplete, making it easier to detect problems in scripts.

## Development and GitHub

The repository includes tests, source code, Windows launchers and CI jobs for Windows and Ubuntu with Python 3.11–3.13. Run from the source folder:

```powershell
.\.venv\Scripts\python.exe -m pip install ".[test]"
.\.venv\Scripts\python.exe -m pytest -q
.\.venv\Scripts\python.exe scripts\verify_integrity.py
```

Create an empty GitHub repository, then connect and push this directory. Keep the local archive, `.venv`, settings and research logs out of the repository; `.gitignore` excludes the usual generated files. After reviewed source changes, regenerate the release checksum manifest with `python scripts/verify_integrity.py --write`.

The [verification record](audit/VERIFICATION.md) describes the tests performed and the checks still needed on the target Windows machine. For troubleshooting, begin with the visible error and the saved download trace described in [Troubleshooting](docs/TROUBLESHOOTING.md).

## Credits and licence

Source-reading and archive helpers build on the author's French-first EU legal-linguistic research prototype. This software is distributed under MIT. Model weights and judicial documents retain their respective terms. CURIA LITE is an independent research application; official source links are provided for checking each result.
