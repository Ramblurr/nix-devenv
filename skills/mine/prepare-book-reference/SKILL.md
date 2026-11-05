---
name: prepare-book-reference
description: Prepare PDF or DjVu books for agent reference with per-page searchable text, verified contents and bibliographic details, original page images, and reading instructions. Use when packaging a textbook for coding agents, extracting page-addressable OCR, or converting DjVu while preserving its text layer.
---

# Prepare book reference

Make a book searchable without treating OCR as authoritative mathematics. Use scripts
for extraction, transformations, and validation; inspect only metadata, contents,
and pages needed to resolve uncertainty. Do not round-trip the book's text through
model context or rewrite its prose.

## Output contract

```text
<Book Title>/
├── AGENTS.md
├── contents.md
├── book.pdf
├── book.djvu          # when supplied; do not manufacture one from a PDF
├── cache/
│   └── pages/         # on-demand images named NNNN.png
└── pages/
    ├── 0001.txt
    ├── 0002.txt
    └── ...
```

All file-page references are **1-based physical PDF/DjVu positions**, including
covers and blank pages. Printed page numbers are separate, optional metadata.
There is no duplicate whole-book text file and no pre-rendered image collection.
Render interesting pages on demand into the book's `cache/pages/NNNN.png`, using
four-digit file-page numbers. Reuse existing images. Use `cache/`, not `.cache/` or
loose files in `/tmp`. Keep intermediate extraction/conversion files under the book's
`cache/work/` and remove them after validation. Only disposable generated files belong
in `cache/`; deleting it must not affect originals, page text, or documentation.

## Shared page renderer

Use the bundled `render-book-page.sh` directly from this skill directory. Keep the
script here only; do not copy it into book directories or the target repository.
In `AGENTS.md`, identify it as `prepare-book-reference/render-book-page.sh` and tell
agents to load this skill to resolve its location. Do not embed machine-specific
absolute paths in the book documentation.

Usage: `render-book-page.sh BOOK_DIRECTORY PAGE [DPI]`. It prints the absolute PNG
path, uses installed `pdftoppm` or Nix, and caches 150-DPI renders by file-page number.
Without DPI it reuses a nonempty image unless the PDF is newer. Explicit DPI always
regenerates, so `300` provides a higher-resolution view or forces a refresh. Clear
cached images if replacing the PDF with a copy whose timestamps are preserved.
Temporary render files stay inside `cache/pages/` and are cleaned up; a failed render
does not replace a previously cached image. Use this script rather than repeating
rendering commands in each book's instructions.

## 1. Inventory and preserve

- Read applicable directory instructions. Identify the requested books and existing
  PDF/DjVu counterparts; do not reconvert unrelated books or overwrite existing files.
- Establish the destination. If several books need a new layout, prepare one first
  when the user wants to review the format.
- Check page counts and embedded text independently for each format. A DjVu may have
  OCR even when its converted PDF has none. Sample a substantive page, not only a cover.

```sh
djvused 'source.djvu' -e n
djvutxt --page=29 'source.djvu'
pdfinfo 'source.pdf'
pdftotext -f 29 -l 29 'source.pdf' -
```

Use installed tools, or `nix shell nixpkgs#djvulibre nixpkgs#poppler-utils -c ...`.
Quote paths. Record hashes before moving originals; verify them afterward. Build
new outputs under `cache/work/` and validate before replacing an existing derivative.
Move originals only within the user's requested scope, without clobbering destinations.

**Complete when:** source pairs, counts, text availability, and destination are known.

## 2. Supply a PDF without losing text

Skip conversion if a suitable PDF already exists. Check that a supplied PDF and
DjVu have corresponding page order; equal counts alone do not establish alignment.

`ddjvu -format=pdf` preserves page images but can discard the DjVu text layer.
Never treat successful conversion as proof of searchable output.

If conversion produces an image-only PDF while the DjVu has OCR:

1. Extract positioned text with `djvutoxml source.djvu cache/work/text.xml` (create `cache/work/` first).
2. Use a script and a PDF library such as PyMuPDF to overlay **invisible** text on
   the PDF's existing pages. Preserve page size, images, and page order.
3. Map each XML `OBJECT` to its PDF page. DjVuXML `WORD` coordinates are
   `left,bottom,right,top` in top-origin image pixels. Scale x and y independently
   from the object's width/height to the PDF page dimensions. Fit each word to its
   box with font metrics and horizontal scaling; use invisible render mode 3.
4. Embed a Unicode font covering the actual characters, then verify extraction.
   Font choice matters: a CJK font can map ASCII hyphens to another Unicode character;
   missing glyphs and font subsetting can also corrupt extraction.
5. Compare extracted non-whitespace characters **per page** against the source words.
   Compare rendered pages before/after at the same resolution to ensure the overlay
   remains invisible. Inspect representative word alignment against page images.

DjVu exports may contain invalid UTF-8. Decode explicitly, count replacements, and
record the policy; never silently drop bytes or claim that placeholders restore the
original symbols. If PDF glyph constraints require a different placeholder, document
that difference. Mathematical OCR errors must remain distinguishable from corrections.

When neither source has text, report that OCR is required. Use an available OCR tool
and identify its output as newly generated OCR; do not invent a text layer or present
empty extraction as success. Keep the original page images unchanged.

**Complete when:** PDF page correspondence is checked and any added text is validated,
with known losses recorded. Keep failed conversion outputs away from the final files.

## 3. Extract page-addressable text

Write a short script that loops over the source's real page count. Prefer the original
DjVu OCR when the PDF was derived from it; otherwise extract the PDF page by page.

```sh
djvutxt --page=29 book.djvu
pdftotext -f 29 -l 29 -enc UTF-8 book.pdf -
```

Write each result directly to `pages/{page:04d}.txt`. Include a file for every page,
including pages with empty OCR. Remove extractor form-feed separators, not prose,
spacing, line breaks, or apparent OCR mistakes. Keep UTF-8 decoding policy explicit.

Each file starts with:

```text
File page: 29
Printed page: 20
Source: book.pdf / book.djvu
Text: original DjVu OCR; mathematical symbols may be incorrect
---
<extracted page text>
```

Adapt `Source` to the files actually present and `Text` to the actual extraction
provenance. Use `Printed page: not verified` unless checked against the book. Do not
apply an assumed constant offset across front matter, inserts, and missing pages.
A printed number occurring inside OCR does not replace the authoritative file page.

**Complete when:** filenames and headers cover exactly pages 1 through N, and each body
matches the corresponding extraction under the stated decoding/separator policy.

## 4. Build a compact contents reference

Locate and render title, copyright, and contents pages; their positions vary by book.
Use their images to check bibliographic facts and repair extraction of the contents
only. Script the bulk of the index from OCR, then inspect exceptions such as wrapped
titles and page numbers detached into another column.

`contents.md` starts with the book title and a short bibliographic list:

- Author, subtitle if present, publisher, series/volume if present.
- Publication year; distinguish original publication from this printing or edition.
- ISBNs with binding labels only where supported by the source. Do not invent an
  ISBN-13, publication day, or binding label that the inspected pages do not establish.
- File pages used to verify these details.

Then state:

```text
All page numbers are 1-based PDF/DjVu file pages, not printed page numbers.
Page text is in pages/NNNN.txt, zero-padded to four digits
(page 268 → pages/0268.txt).
```

Use a **simple nested list**, not a table or Markdown links:

```text
- 3. Feature Structures — page 42
  - Subsumption — page 49
  - Unification — page 54
```

Preserve chapter/section numbers, part headings, and useful back-matter entries.
Do not add generated summaries, speculative topic tags, or per-entry verification
columns. Keep provenance and validation notes in `AGENTS.md` instead.

For every contents entry, verify the proposed file page against the target heading
in OCR; inspect the page image when OCR is ambiguous or broken. An offset may propose
a candidate but is not verification. Record printed metadata only when supported.
Keep any contents-title corrections separate from uncorrected page OCR.

**Complete when:** every contents entry has an existing, checked target, with no
unresolved guesses concealed as verified references.

## 5. Write AGENTS.md for retrieval

Keep it short and actionable. Include:

- Where to find bibliographic details, contents, page text, and images.
- Search example: `rg -n -i 'subsumption' pages/`.
- File-page versus printed-page numbering, with a verified example from this book.
- A pointer to `prepare-book-reference/render-book-page.sh`: load this skill,
  resolve the script from its directory, and run it with arguments `. 29` from
  the book directory. This is a skill-relative reference, not a repository path.

- Open the returned image path (`cache/pages/0029.png`). For small notation, run
  the same script with arguments `. 29 300` to regenerate at higher resolution.
- `cache/` can be deleted safely. Keep cache behavior and dependency handling in the
  shared script rather than repeating the implementation in each book's instructions.
- Verify formulas, definitions, diagrams, grammar notation, and code against images
  before using them in an implementation. PDF OCR is not independent confirmation.
- If search fails, try prose variants and the contents/index; OCR can miss concepts.
- Cite book, file page, verified printed page, and section/definition/theorem number.
- Actual extraction provenance, decoding replacements, and validation coverage.

Use `AGENTS.md`, not `README.md`. Do not claim checks that were not performed.

## 6. Validate and hand over

Run scripted checks rather than loading all page files into context:

- Source and derivative counts agree; page correspondence has been checked.
- Exactly N consecutive text files exist, including empty pages; headers match names.
- Every text body matches its page extraction under the documented policy.
- Every contents target exists and its heading/location was checked.
- `contents.md` uses file-page numbers, a list, and no tables or Markdown links.
- The documented rendering command produces a readable image in `cache/pages/` and
  reuses it on a second run. No page-rendering command writes to `/tmp` or `.cache/`.
- Relocated originals retain their hashes; unrelated books remain untouched.
- Converted PDFs retain extractable text and unchanged images as checked in step 2.

Report the destination, page and contents-entry counts, and any limitations. If a
review inbox is available, send `contents.md` and `AGENTS.md` there for review. Do not
reload agent resources without permission or commit files unless requested.
