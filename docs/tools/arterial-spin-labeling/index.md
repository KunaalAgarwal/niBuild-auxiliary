# Arterial Spin Labeling

Non-invasive perfusion imaging using magnetically labeled blood. Used for cerebral blood flow quantification and partial volume correction.

## FSL

Docker image: `brainlife/fsl`

### ASL Processing

| Tool | Description |
|---|---|
| [Oxford ASL Processing Pipeline](oxford_asl.md) | Multi-step pipeline for ASL MRI quantification. Internally chains motion correction, registration, BASIL kinetic mode... |
| [Bayesian Inference for Arterial Spin Labeling (BASIL)](basil.md) | Bayesian kinetic model inversion for ASL data using variational Bayes to estimate perfusion and arrival time. |
| [ASL Calibration (asl_calib)](asl_calib.md) | Calibrates ASL perfusion data to absolute CBF units (ml/100g/min) using an M0 calibration image. |
