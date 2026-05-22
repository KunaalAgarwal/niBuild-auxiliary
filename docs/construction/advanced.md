# Scatter, Conditions & Expressions

Beyond a plain linear pipeline, niBuild supports batch processing, runtime conditionals, and value expressions.

## Scatter (batch processing)

Enable a node's **Scatter** toggle to run that step once per input file instead of once for all inputs combined — the way you process many subjects or runs.

- Scatter on a node propagates automatically to all downstream connected nodes.
- An array-typed input (e.g. `File[]`) *gathers* scattered outputs without propagating scatter further.
- When a scattered step emits an array, niBuild injects a `$(self.flat())` expression downstream to unwrap the double nesting. This is automatic — you only see it in the CWL preview.

### Scatter method

When a step scatters over two or more inputs, a **Scatter Method** dropdown appears in the Parameters panel:

- `dotproduct` (default) — pairs inputs 1:1; all arrays must be equal length. `[A,B] × [1,2] → (A,1), (B,2)`
- `flat_crossproduct` — every combination, as a flat list. `[A,B] × [1,2] → (A,1), (A,2), (B,1), (B,2)`
- `nested_crossproduct` — every combination, nested by the first input.

## Conditional steps

Add a **when** expression in the Parameters panel to skip a step at runtime. Pick a parameter and a comparison — e.g. parameter `run_step` with `== true` produces `$(inputs.run_step == true)`. When it evaluates false, the step is skipped and produces null outputs.

## Expressions

Click the **fx** button beside a parameter to transform its value with a CWL expression. Type only the body — the `$(...)` wrapper is added for you.

- **Scalars** — `self` is the raw value. Example: `self / 2.355` converts a FWHM to a sigma.
- **Files** — `self` is a File object: `self.nameroot` (name without extension), `self.basename` (full name), `self.dirname` (parent directory).

A template dropdown offers common patterns.
