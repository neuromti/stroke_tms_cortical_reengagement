# Cortical Re-engagement After Stroke — TEP Analysis Pipeline

This repository contains the processing pipeline used to compute TMS-evoked potentials (TEPs) from raw EEG/TMS recordings, from raw data import through to publication-ready figures.

## Before You Run Anything

1. **Set your local paths.** All scripts contain paths pointing to where data is stored on the local server. These paths must be updated to match your own environment before running any script.
2. **Configure EEGLAB path.** Open `local_settings.config` and update the path to your local EEGLAB installation (and to the `custom_functions` folder, if not already correct).
3. Make sure the `custom_functions` folder (see below) is on your MATLAB path — the main scripts depend on it.

## Repository Structure

```
.
├── custom_functions/          # Custom & third-party functions required by the main scripts
├── def_pro.m                  # Defines project directories and creates a backup copy
├── local_settings.config      # Paths to custom_functions and EEGLAB (edit before running)
├── pre_pulling_HC.m           # Data pulling for healthy controls
├── pre_pulling_ST.m           # Data pulling for stroke patients
├── pre_cleaning.m
├── pre_epoching.m
├── pre_erp.m
├── main_tep_analysis.m
└── README.md
```

## Pipeline Overview

The scripts are meant to be run in the following order. Each stage consumes the output of the previous one.

```
                        def_pro  (project setup, run first)
                              │
                              ▼
                pre_pulling_HC  /  pre_pulling_ST
                              │
                              ▼
                        pre_cleaning
                              │
                              ▼
                        pre_epoching
                              │
                              ▼
                          pre_erp
                              │
                              ▼
                     main_tep_analysis
                  (TEP computation, clinical
                 correlations & final figures)
```

## Stage Descriptions

### Setup

| Script / Folder | Description |
|---|---|
| `custom_functions/` | Contains all custom and third-party functions required to run the main scripts. Must be on the MATLAB path. |
| `def_pro` | Defines the project directories and creates a backup copy (of the project/data structure). |
| `local_settings.config` | Contains the paths to the `custom_functions` folder and to the EEGLAB installation. **The local EEGLAB path must be updated before running the pipeline.** |

### Preprocessing

| Script | Description |
|---|---|
| `pre_pulling_HC` | Reads raw `.xdf` files for the **healthy control** group, extracts the relevant data streams (EEG, markers, etc.), and saves them into `.mat` files for downstream processing. |
| `pre_pulling_ST` | Reads raw `.xdf` files for the **stroke** group, extracts the relevant data streams (EEG, markers, etc.), and saves them into `.mat` files for downstream processing. |
| `pre_cleaning` | Takes the `.mat` files produced by `pre_pulling` and cleans the data (e.g. artifact removal, filtering, bad channel/segment handling). |
| `pre_epoching` | Epochs the cleaned continuous data around events of interest (e.g. TMS pulses). |
| `pre_erp` | Computes the event-related potential (ERP) for each individual trial. |

### Main Analysis & Publication

| Script | Description |
|---|---|
| `main_tep_analysis` | Computes TEPs for healthy controls and stroke patients (pre- and post-rehabilitation), correlates TEP measures with clinical outcomes, and generates the final figures used for publication. |

## Usage

1. Update `local_settings.config` with your local EEGLAB (and `custom_functions`) paths.
2. Run `def_pro` to set up project directories and create a backup.
3. Update the data paths inside each script to point to your local server/data location.
4. Run the preprocessing stages in order: `pre_pulling_HC` and/or `pre_pulling_ST` → `pre_cleaning` → `pre_epoching` → `pre_erp`.
5. Run `main_tep_analysis` to compute TEPs, run the clinical correlations, and generate the publication figures.

## Requirements

- MATLAB (version 2022b) with the following toolboxes: EEGLAB2023, xdfimport, TESA, ICLabel, FieldTrip
- EEGLAB (path set via `local_settings.config`)
- Functions in `custom_functions/` (add to MATLAB path)
- Add any additional dependencies your scripts require
