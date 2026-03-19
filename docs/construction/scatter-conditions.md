# Scatter, Conditions & Expressions

## Scatter (Batch Processing)

Enable the "Scatter" toggle on a node to run that processing step once per input file, rather than once for all inputs combined.

- Useful for processing multiple subjects or runs in parallel.
- When enabled on the first node in a chain, scatter propagates automatically to all downstream connected nodes.
- Array-typed inputs (e.g. `File[]`) naturally *gather* scattered outputs without propagating scatter further.
- When a scattered step produces an array output (e.g., `File[]`), scatter wraps it in another layer (`File[][]`). niBuild automatically injects a `$(self.flat())` expression on downstream inputs to unwrap the double nesting. This happens transparently as the graph changes — you'll see it in the CWL preview but don't need to set it manually.

## Scatter Method

When a step scatters over two or more inputs, a **Scatter Method** dropdown appears in the parameter modal. This controls how the input arrays are combined:

- `dotproduct` (default) — pairs elements 1:1 across inputs. All arrays must be the same length.
    `[A,B] × [1,2] → (A,1), (B,2)`
- `flat_crossproduct` — Cartesian product of all inputs, producing a flat list of every combination.
    `[A,B] × [1,2] → (A,1), (A,2), (B,1), (B,2)`
- `nested_crossproduct` — Cartesian product with results nested by the first input.
    `[A,B] × [1,2] → [(A,1),(A,2)], [(B,1),(B,2)]`

## Conditional Steps (When Expression)

Add a "when" expression to conditionally execute a step at runtime.

1. Double-click a node to open its parameter modal.
2. In the "When Expression" section, select a parameter from the dropdown.
3. Enter a condition using a comparison operator.

Example: selecting parameter `run_step` with condition `== true` produces:

```
$(inputs.run_step == true)
```

When the condition evaluates to false at runtime, the step is skipped and produces null outputs.

## Expressions (fx)

Click the **fx** button next to any parameter to transform its value with a CWL expression.

- Type only the expression body — the `$(...)` wrapper is added automatically.
- For **scalar parameters** (numbers, strings): `self` refers to the raw value.
    - Example: `self / 2.355` converts FWHM to sigma
- For **File parameters**: `self` is a File object with properties:
    - `self.nameroot` — filename without extension
    - `self.basename` — full filename with extension
    - `self.dirname` — parent directory path
- Use the template dropdown for common expression patterns.
